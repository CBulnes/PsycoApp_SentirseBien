using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using PsycoApp.BL.Interfaces;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PacienteController : ControllerBase
    {
        private readonly IPacienteBL pacienteBL;

        public PacienteController(IPacienteBL pacienteBL)
        {
            this.pacienteBL = pacienteBL;
        }

        [HttpGet("listar/{pagina}/{tamanoPagina}")]
        public ActionResult<List<Paciente>> Listar(int pagina = 1, int tamanoPagina = 100)
        {
            try
            {
                var pacientes = pacienteBL.ListarPacientes(pagina, tamanoPagina);
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
            try
            {
                pacienteBL.AgregarPaciente(paciente);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("buscar")]
        public ActionResult Buscar([FromQuery] string nombre, int pageNumber = 1, int pageSize = 10)
        {
            if (string.IsNullOrEmpty(nombre))
                nombre = "";
            try
            {
                var pacientes = pacienteBL.BuscarPaciente(nombre, pageNumber, pageSize);
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
            try
            {
                pacienteBL.ActualizarPaciente(paciente);
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
                pacienteBL.EliminarPaciente(id);
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
            try
            {
                var paciente = pacienteBL.BuscarPacienteId(id);
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
        public ActionResult<List<entities.Paciente>> ListarPacientesCombo([FromQuery] int page = 1, [FromQuery] int pageSize = 10, [FromQuery] string search = "", [FromQuery] int sede = 1)
        {
            List<entities.Paciente> lista = new List<entities.Paciente>();
            try
            {
                lista = pacienteBL.listar_pacientes_combo_dinamico(page, pageSize, search, sede); // Llamada al método BL con paginación y filtro
            }
            catch (Exception e)
            {
                lista.Clear();
            }

            return lista; 
        }
        [HttpGet("listar_pacientes_combo")]
        public ActionResult<List<entities.Paciente>> listar_pacientes_combo()
        {
            List<entities.Paciente> lista = new List<entities.Paciente>();
            try
            {
                lista = pacienteBL.listar_pacientes_combo();
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            return lista;
        }

        #region "version react"
        [HttpGet("listarPacientes")]
        public async Task<IActionResult> GetList([FromQuery] ListPacientesDto request)
        {
            var respuesta = await pacienteBL.GetList(request);
            return Ok(respuesta);
        }
        #endregion
    }
}
