using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using System.Collections.Generic;
using System;
using PsycoApp.entities;
using PsycoApp.DA;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PsicologoController : ControllerBase
    {

        PsicologoBL _psicologoBL = new PsicologoBL();

        [HttpGet("listar/{pagina}/{tamanoPagina}")]
        public ActionResult<List<Psicologo>> Listar(int pagina = 1, int tamanoPagina = 100)
        {
            try
            {
                return _psicologoBL.ListarPsicologos(pagina, tamanoPagina);
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
            List<entities.Psicologo> lista = new List<entities.Psicologo>();
            try
            {
                lista = _psicologoBL.listar_psicologos_combo();
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("listar_usuarios_caja_combo")]
        public ActionResult<List<entities.Usuario>> listar_usuarios_caja_combo()
        {
            List<entities.Usuario> lista = new List<entities.Usuario>();
            try
            {
                lista = _psicologoBL.listar_usuarios_caja_combo();
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
            List<entities.Sede> lista = new List<entities.Sede>();
            try
            {
                lista = _psicologoBL.listar_sedes_x_usuario_combo(id_usuario);
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
            List<entities.Sede> lista = new List<entities.Sede>();
            try
            {
                lista = _psicologoBL.listar_sedes_combo();
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
    }
}
