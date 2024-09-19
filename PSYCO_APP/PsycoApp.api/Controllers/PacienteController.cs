using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using System.Collections.Generic;
using System;
using PsycoApp.entities;

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
            try
            {
                var pacientes = _pacienteBL.ListarPacientes(pagina, tamanoPagina);
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
                _pacienteBL.AgregarPaciente(paciente);
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
            try
            {
                var pacientes = _pacienteBL.BuscarPaciente(nombre, pageNumber, pageSize);
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
            try
            {
                _pacienteBL.EliminarPaciente(id);
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
                var paciente = _pacienteBL.BuscarPacienteId(id);
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
    }
}
