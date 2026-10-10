using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using System.Collections.Generic;
using System;
using PsycoApp.entities;
using PsycoApp.api.Security;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PacienteController : ControllerBase
    {
   
        PacienteBL _pacienteBL = new PacienteBL();

        [HttpGet("listar/{pagina}/{tamanoPagina}")]
        public ActionResult<List<Paciente>> Listar(int pagina = 1, int tamanoPagina = 100)
        {
            if (!TenantContext.IsGlobalAdministrator(User) && (!TenantContext.TryGetIntClaim(User, "id_sede", out var idSede) || idSede <= 0))
                return Forbid();

            try
            {
                var pacientes = TenantContext.IsGlobalAdministrator(User)
                    ? _pacienteBL.ListarPacientes(pagina, tamanoPagina)
                    : _pacienteBL.ListarPacientesSede(pagina, tamanoPagina, TenantContext.TryGetIntClaim(User, "id_sede", out var sedeClaim) ? sedeClaim : 0);
                return Ok(pacientes);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("listarSede/{pagina}/{tamanoPagina}/{sede}")]
        public ActionResult<List<Paciente>> ListarSede(int pagina = 1, int tamanoPagina = 100,int sede=0)
        {
            if (!TryResolveSede(sede, out var sedeAutorizada))
                return Forbid();

            try
            {
                var pacientes = _pacienteBL.ListarPacientesSede(pagina, tamanoPagina, sedeAutorizada);
                return Ok(pacientes);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("agregar")]
        public ActionResult Agregar([FromBody] Paciente paciente)
        {
            if (paciente == null || paciente.id_sede <= 0)
                return BadRequest("No se recibió una sede válida para el paciente.");
            if (!TryResolveSede(paciente.id_sede, out var sedeAutorizada))
                return Forbid();
            paciente.id_sede = sedeAutorizada;

            try
            {
                _pacienteBL.AgregarPaciente(paciente);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("buscar")]
        public ActionResult Buscar([FromQuery] string nombre, int pageNumber = 1, int pageSize = 10, int sede=0)
        {
            if (!TryResolveSede(sede, out var sedeAutorizada))
                return Forbid();
            if (string.IsNullOrEmpty(nombre))
                nombre = "";
            try
            {
                var pacientes = _pacienteBL.BuscarPaciente(nombre, pageNumber, pageSize, sedeAutorizada);
                return Ok(pacientes);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut("actualizar")]
        public ActionResult Actualizar([FromBody] Paciente paciente)
        {
            if (paciente == null)
                return BadRequest();
            var isGlobal = TenantContext.IsGlobalAdministrator(User);
            var idSede = 0;
            if (!isGlobal && (!TenantContext.TryGetIntClaim(User, "id_sede", out idSede) || idSede <= 0))
                return Forbid();
            var sedeParaActualizar = isGlobal ? paciente.id_sede : idSede;
            if (sedeParaActualizar <= 0)
                return BadRequest("La sede del paciente no es válida.");
            if (!isGlobal && _pacienteBL.BuscarPacienteId(paciente.Id) == null)
                return NotFound();
            paciente.id_sede = sedeParaActualizar;
            try
            {
                _pacienteBL.ActualizarPaciente(paciente);
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
            var sede = TenantContext.TryGetIntClaim(User, "id_sede", out var idSede) ? idSede : 0;
            if (!TenantContext.IsGlobalAdministrator(User) && sede <= 0)
                return Forbid();
            if (!TenantContext.IsGlobalAdministrator(User) && _pacienteBL.BuscarPacienteId(id) == null)
                return NotFound();
            try
            {
                _pacienteBL.EliminarPaciente(id, TenantContext.IsGlobalAdministrator(User) ? 0 : sede);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet("BuscarId/{id}")]
        public ActionResult ObtenerPaciente(int id)
        {
            var sede = TenantContext.TryGetIntClaim(User, "id_sede", out var idSede) ? idSede : 0;
            if (!TenantContext.IsGlobalAdministrator(User) && sede <= 0)
                return Forbid();
            if (!TenantContext.IsGlobalAdministrator(User) && !_pacienteBL.PacientePerteneceASede(id, sede))
                return NotFound("Paciente no encontrado.");
            try
            {
                var paciente = _pacienteBL.BuscarPacienteId(id, TenantContext.IsGlobalAdministrator(User) ? 0 : sede);
                if (paciente == null)
                {
                    return NotFound("Paciente no encontrado.");
                }
                return Ok(paciente);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet("listar_pacientes_combo_dinamico")]
        public ActionResult<List<entities.Paciente>> ListarPacientesCombo([FromQuery] int page = 1, [FromQuery] int pageSize = 10, [FromQuery] string search = "", [FromQuery] int sede = 0)
        {
            if (!TryResolveSede(sede, out var sedeAutorizada))
                return Forbid();
            List<entities.Paciente> lista = new List<entities.Paciente>();
            try
            {
                lista = _pacienteBL.listar_pacientes_combo_dinamico(page, pageSize, search, sedeAutorizada);
            }
            catch (Exception)
            {
                lista.Clear();
            }

            return lista; 
        }
        [HttpGet("listar_pacientes_combo")]
        public ActionResult<List<entities.Paciente>> listar_pacientes_combo()
        {
            if (!TenantContext.IsGlobalAdministrator(User) && !TenantContext.TryGetIntClaim(User, "id_sede", out _))
                return Forbid();
            List<entities.Paciente> lista = new List<entities.Paciente>();
            try
            {
                var sede = TenantContext.TryGetIntClaim(User, "id_sede", out var idSede) ? idSede : 0;
                lista = _pacienteBL.listar_pacientes_combo(sede);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        private bool TryResolveSede(int sedeSolicitada, out int sedeAutorizada)
        {
            if (TenantContext.IsGlobalAdministrator(User))
            {
                sedeAutorizada = sedeSolicitada;
                return sedeAutorizada >= 0;
            }

            if (!TenantContext.TryGetIntClaim(User, "id_sede", out sedeAutorizada) || sedeAutorizada <= 0)
                return false;

            return sedeSolicitada <= 0 || sedeSolicitada == sedeAutorizada;
        }
    }
}
