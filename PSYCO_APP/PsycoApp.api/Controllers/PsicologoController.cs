using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using System.Collections.Generic;
using System;
using PsycoApp.entities;
using PsycoApp.DA;
using PsycoApp.api.Security;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PsicologoController : ControllerBase
    {

        PsicologoBL _psicologoBL = new PsicologoBL();
        EmpresaSedeBL _empresaSedeBL = new EmpresaSedeBL();

        private bool PuedeAdministrarSede(int idSede)
        {
            if (idSede <= 0)
                return false;

            if (TenantContext.IsGlobalAdministrator(User))
                return true;

            return (User.IsInRole("1") || User.IsInRole("3"))
                && TenantContext.TryGetIntClaim(User, "id_sede", out var sedeToken)
                && sedeToken == idSede
                && TenantContext.TryGetIntClaim(User, "id_empresa", out var empresaToken)
                && empresaToken > 0;
        }

        private bool PuedeConsultarCombos()
        {
            return TenantContext.IsGlobalAdministrator(User) ||
                (PuedeOperarMantenimiento()
                && TenantContext.TryGetIntClaim(User, "id_sede", out var idSede)
                && idSede > 0
                && TenantContext.TryGetIntClaim(User, "id_empresa", out var idEmpresa)
                && idEmpresa > 0);
        }

        private bool SedesIncluyen(string sedes, int idSede)
        {
            return !string.IsNullOrWhiteSpace(sedes)
                && Array.Exists(sedes.Split('/'), sede => int.TryParse(sede.Trim(), out var id) && id == idSede);
        }

        private bool PsicologoAsignadoASede(int idPsicologo, int idSede)
        {
            try
            {
                var psicologo = _psicologoBL.BuscarPsicologoId(idPsicologo);
                return psicologo != null && (psicologo.IdSedePrincipal == idSede
                    || psicologo.IdSedeSecundaria == idSede
                    || psicologo.IdSedeTerciaria == idSede
                    || psicologo.IdSedeSecundaria2 == idSede);
            }
            catch
            {
                return false;
            }
        }

        [HttpGet("listar/{pagina}/{tamanoPagina}")]
        public ActionResult<List<Psicologo>> Listar(int pagina = 1, int tamanoPagina = 100)
        {
            if (!TenantContext.IsGlobalAdministrator(User))
                return Forbid();

            try
            {
                return _psicologoBL.ListarPsicologos(pagina, tamanoPagina);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("actualizar_password")]
        public ActionResult ActualizarPassword([FromBody] Usuario usuario)
        {
            try
            {
                if (usuario == null || usuario.id_psicologo <= 0)
                    return BadRequest("Ingrese una contraseña válida.");

                if (!PuedeAdministrarSede(usuario.id_sede))
                    return Forbid();

                if (!PsicologoAsignadoASede(usuario.id_psicologo, usuario.id_sede))
                    return NotFound();

                _psicologoBL.ActualizarPasswordPsicologo(usuario.id_psicologo, usuario.id_sede, usuario.password);
                return Ok(new { message = "Contraseña del especialista actualizada correctamente." });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("credenciales/{idPsicologo:int}/sede/{idSede:int}")]
        public ActionResult ObtenerCredenciales(int idPsicologo, int idSede)
        {
            if (!PuedeAdministrarSede(idSede))
                return Forbid();

            try
            {
                var usuario = _psicologoBL.ObtenerCredencialesPsicologo(idPsicologo, idSede);
                if (usuario == null)
                    return NotFound();

                return Ok(usuario);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("empresa/{idEmpresa}/sede/{idSede}/listar/{pagina}/{tamanoPagina}")]
        public ActionResult<List<Psicologo>> ListarPorEmpresaYSede(int idEmpresa, int idSede, int pagina = 1, int tamanoPagina = 100)
        {
            if (idEmpresa <= 0 || idSede <= 0)
                return BadRequest("La empresa y la sede son obligatorias.");
            if (!PuedeAccederEmpresaYSede(idEmpresa, idSede))
                return Forbid();

            try
            {
                return _psicologoBL.ListarPsicologos(pagina, tamanoPagina, idEmpresa, idSede);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("empresa/{idEmpresa}/listar/{pagina}/{tamanoPagina}")]
        public ActionResult<List<Psicologo>> ListarPorEmpresa(int idEmpresa, int pagina = 1, int tamanoPagina = 100)
        {
            if (idEmpresa <= 0)
                return BadRequest("La empresa es obligatoria.");
            if (!PuedeAccederEmpresa(idEmpresa))
                return Forbid();

            try
            {
                return _psicologoBL.ListarPsicologos(pagina, tamanoPagina, idEmpresa);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("empresa/{idEmpresa}/buscar")]
        public ActionResult BuscarPorEmpresa(int idEmpresa, [FromQuery] string nombre)
        {
            if (idEmpresa <= 0)
                return BadRequest("La empresa es obligatoria.");
            if (!PuedeAccederEmpresa(idEmpresa))
                return Forbid();

            try
            {
                return Ok(_psicologoBL.BuscarPsicologo(nombre ?? string.Empty, idEmpresa));
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("empresa/{idEmpresa}/sede/{idSede}/buscar")]
        public ActionResult BuscarPorEmpresaYSede(int idEmpresa, int idSede, [FromQuery] string nombre)
        {
            if (idEmpresa <= 0 || idSede <= 0)
                return BadRequest("La empresa y la sede son obligatorias.");
            if (!PuedeAccederEmpresaYSede(idEmpresa, idSede))
                return Forbid();

            try
            {
                return Ok(_psicologoBL.BuscarPsicologo(nombre ?? string.Empty, idEmpresa, idSede));
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("agregar")]
        public ActionResult Agregar([FromBody] Psicologo psicologo)
        {
            if (psicologo == null)
                return BadRequest("Ingrese datos válidos del especialista.");
            if (!PuedeAsignarPsicologo(psicologo))
                return Forbid();

            try
            {
                _psicologoBL.AgregarPsicologo(psicologo);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("guardar_credenciales")]
        public ActionResult GuardarCredenciales([FromBody] Usuario usuario)
        {
            if (usuario == null || usuario.id_psicologo <= 0)
                return BadRequest("Ingrese datos válidos del especialista.");

            if (!PuedeAdministrarSede(usuario.id_sede))
                return Forbid();

            if (!PsicologoAsignadoASede(usuario.id_psicologo, usuario.id_sede))
                return NotFound();

            try
            {
                _psicologoBL.GuardarCredencialesPsicologo(usuario.id_psicologo, usuario.id_sede, usuario.email, usuario.password);
                return Ok(new { message = "Usuario del especialista guardado correctamente." });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
 
        [HttpGet("buscar")]
        public ActionResult Buscar([FromQuery] string nombre, [FromQuery] int idEmpresa = 0)
        {
            if (!PuedeAccederEmpresa(idEmpresa))
                return Forbid();

            if (string.IsNullOrEmpty(nombre))
                nombre = "";
            try
            {
                var psicologos = _psicologoBL.BuscarPsicologo(nombre, idEmpresa);
                return Ok(psicologos);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut("actualizar")]
        public ActionResult Actualizar([FromBody] Psicologo psicologo)
        {
            if (psicologo == null || psicologo.Id <= 0)
                return BadRequest("Ingrese datos válidos del especialista.");
            if (!PuedeAdministrarPsicologo(psicologo.Id) || !PuedeAsignarPsicologo(psicologo))
                return Forbid();

            try
            {
                _psicologoBL.ActualizarPsicologo(psicologo);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete("eliminar/{id}")]
        public ActionResult Eliminar(int id)
        {
            if (!PuedeAdministrarPsicologo(id))
                return Forbid();

            try
            {
                _psicologoBL.EliminarPsicologo(id);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet("BuscarId/{id}")]
        public ActionResult ObtenerPsicologo(int id)
        {
            if (!PuedeAdministrarPsicologo(id))
                return Forbid();

            try
            {
                var psicologo = _psicologoBL.BuscarPsicologoId(id);
                if (psicologo == null)
                {
                    return NotFound("Psicologo no encontrado.");
                }
                return Ok(psicologo);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("listar_psicologos_combo")]
        public ActionResult<List<entities.Psicologo>> listar_psicologos_combo()
        {
            if (!PuedeConsultarCombos())
                return Forbid();

            List<entities.Psicologo> lista = new List<entities.Psicologo>();
            try
            {
                lista = _psicologoBL.listar_psicologos_combo();
                if (!TenantContext.IsGlobalAdministrator(User))
                {
                    TenantContext.TryGetIntClaim(User, "id_sede", out var idSede);
                    lista = lista.FindAll(psicologo => SedesIncluyen(psicologo.Sedes, idSede));
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("listar_usuarios_caja_combo")]
        public ActionResult<List<entities.Usuario>> listar_usuarios_caja_combo(int idEmpresa, int idSede = -1)
        {
            if (!PuedeConsultarCombos())
                return Forbid();
            if (idEmpresa <= 0 || !_empresaSedeBL.EmpresaActiva(idEmpresa))
                return BadRequest("La empresa seleccionada no es válida.");

            if (!TenantContext.IsGlobalAdministrator(User)
                && (!TenantContext.TryGetIntClaim(User, "id_empresa", out var empresaToken) || empresaToken != idEmpresa))
                return Forbid();

            if (idSede != -1 && !_empresaSedeBL.SedePerteneceEmpresaActiva(idSede, idEmpresa))
                return BadRequest("La sede seleccionada no pertenece a la empresa indicada o está inactiva.");

            if (User.IsInRole("3") && (!TenantContext.TryGetIntClaim(User, "id_sede", out var sedeToken)
                || idSede != sedeToken))
                return Forbid();

            List<entities.Usuario> lista = new List<entities.Usuario>();
            try
            {
                lista = _psicologoBL.listar_usuarios_caja_combo(idEmpresa, idSede);
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("listar_sedes_x_usuario_combo/{id_usuario}")]
        public ActionResult<List<entities.Sede>> listar_sedes_x_usuario_combo(int id_usuario)
        {
            if (!PuedeAdministrarPsicologo(id_usuario))
                return Forbid();

            List<entities.Sede> lista = new List<entities.Sede>();
            try
            {
                lista = _psicologoBL.listar_sedes_x_usuario_combo(id_usuario);
                if (!TenantContext.IsGlobalAdministrator(User))
                {
                    TenantContext.TryGetIntClaim(User, "id_sede", out var idSede);
                    TenantContext.TryGetIntClaim(User, "id_empresa", out var idEmpresa);
                    lista = lista.FindAll(sede => sede.Id == idSede
                        && _empresaSedeBL.SedePerteneceEmpresaActiva(sede.Id, idEmpresa));
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("listar_sedes")]
        public ActionResult<List<entities.Sede>> listar_sedes_combo()
        {
            if (!PuedeConsultarCombos())
                return Forbid();

            List<entities.Sede> lista = new List<entities.Sede>();
            try
            {
                lista = _psicologoBL.listar_sedes_combo();
                if (!TenantContext.IsGlobalAdministrator(User))
                {
                    TenantContext.TryGetIntClaim(User, "id_sede", out var idSede);
                    TenantContext.TryGetIntClaim(User, "id_empresa", out var idEmpresa);
                    lista = lista.FindAll(sede => sede.Id == idSede
                        && _empresaSedeBL.SedePerteneceEmpresaActiva(sede.Id, idEmpresa));
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("horarios_psicologo/{id_psicologo}/{inicio}/{fin}/{dias}")]
        public List<entities.Horario> horarios_psicologo(int id_psicologo, string inicio, string fin, string dias)
        {
            List<entities.Horario> res_ = new List<entities.Horario>();
            if (!PuedeAdministrarPsicologo(id_psicologo))
                return res_;

            try
            {
                res_ = _psicologoBL.horarios_psicologo(id_psicologo, inicio, fin, dias);
            }
            catch (Exception)
            {
                res_.Clear();
            }
            return res_;
        }

        [HttpGet("vacaciones_psicologo/{id_psicologo}/{inicio}/{fin}/{año}")]
        public List<entities.Horario> vacaciones_psicologo(int id_psicologo, string inicio, string fin, int año)
        {
            List<entities.Horario> res_ = new List<entities.Horario>();
            if (!PuedeAdministrarPsicologo(id_psicologo))
                return res_;

            try
            {
                res_ = _psicologoBL.vacaciones_psicologo(id_psicologo, inicio, fin, año);
            }
            catch (Exception)
            {
                res_.Clear();
            }
            return res_;
        }

        [HttpPost("guardar_horarios_psicologo")]
        public RespuestaUsuario guardar_horarios_psicologo(List<entities.Horario> lista)
        {
            var res_ = new RespuestaUsuario();
            if (lista == null || lista.Count == 0 || lista.Exists(item => item == null || !PuedeAdministrarPsicologo(item.IdPsicologo)))
            {
                res_.estado = false;
                res_.descripcion = "No está autorizado para modificar estos horarios.";
                return res_;
            }

            try
            {
                res_ = _psicologoBL.guardar_horarios_psicologo(lista);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al guardar los horarios.";
            }
            return res_;
        }

        [HttpPost("guardar_vacaciones_psicologo")]
        public RespuestaUsuario guardar_vacaciones_psicologo(List<entities.Horario> lista)
        {
            var res_ = new RespuestaUsuario();
            if (lista == null || lista.Count == 0 || lista.Exists(item => item == null || !PuedeAdministrarPsicologo(item.IdPsicologo)))
            {
                res_.estado = false;
                res_.descripcion = "No está autorizado para modificar estas vacaciones.";
                return res_;
            }

            try
            {
                res_ = _psicologoBL.guardar_vacaciones_psicologo(lista);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al guardar las vacaciones.";
            }
            return res_;
        }

        private bool PuedeOperarMantenimiento()
        {
            return TenantContext.IsGlobalAdministrator(User) || User.IsInRole("1") || User.IsInRole("3");
        }

        private bool PuedeAccederEmpresa(int idEmpresa)
        {
            if (TenantContext.IsGlobalAdministrator(User))
                return idEmpresa > 0;

            return PuedeOperarMantenimiento()
                && TenantContext.TryGetIntClaim(User, "id_empresa", out var empresaToken)
                && empresaToken > 0
                && empresaToken == idEmpresa;
        }

        private bool PuedeAccederEmpresaYSede(int idEmpresa, int idSede)
        {
            if (!PuedeAccederEmpresa(idEmpresa))
                return false;

            if (TenantContext.IsGlobalAdministrator(User))
                return _empresaSedeBL.SedePerteneceEmpresaActiva(idSede, idEmpresa);

            return TenantContext.TryGetIntClaim(User, "id_sede", out var sedeToken)
                && sedeToken == idSede
                && _empresaSedeBL.SedePerteneceEmpresaActiva(idSede, idEmpresa);
        }

        private bool PuedeAdministrarPsicologo(int idPsicologo)
        {
            if (TenantContext.IsGlobalAdministrator(User))
                return idPsicologo > 0;
            if (!PuedeOperarMantenimiento() || !TenantContext.TryGetIntClaim(User, "id_empresa", out var idEmpresa) || idEmpresa <= 0)
                return false;

            try
            {
                var psicologo = _psicologoBL.BuscarPsicologoId(idPsicologo);
                return psicologo != null && SedePerteneceEmpresa(psicologo.IdSedePrincipal, idEmpresa,
                    psicologo.IdSedeSecundaria, psicologo.IdSedeTerciaria, psicologo.IdSedeSecundaria2);
            }
            catch
            {
                return false;
            }
        }

        private bool PuedeAsignarPsicologo(Psicologo psicologo)
        {
            if (TenantContext.IsGlobalAdministrator(User))
                return psicologo != null;
            if (psicologo == null || !PuedeOperarMantenimiento() || !TenantContext.TryGetIntClaim(User, "id_empresa", out var idEmpresa) || idEmpresa <= 0)
                return false;

            return SedePerteneceEmpresa(psicologo.IdSedePrincipal, idEmpresa,
                psicologo.IdSedeSecundaria, psicologo.IdSedeTerciaria, psicologo.IdSedeSecundaria2);
        }

        private bool SedePerteneceEmpresa(int? sedePrincipal, int idEmpresa, params int?[] otrasSedes)
        {
            if (!sedePrincipal.HasValue || !_empresaSedeBL.SedePerteneceEmpresaActiva(sedePrincipal.Value, idEmpresa))
                return false;

            foreach (var idSede in otrasSedes)
            {
                if (idSede.HasValue && idSede.Value > 0 && !_empresaSedeBL.SedePerteneceEmpresaActiva(idSede.Value, idEmpresa))
                    return false;
            }

            return true;
        }
    }
}
