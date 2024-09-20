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
 
        [HttpGet("buscar")]
        public ActionResult Buscar([FromQuery] string nombre)
        {
            if (string.IsNullOrEmpty(nombre))
                nombre = "";
            try
            {
                var psicologos = _psicologoBL.BuscarPsicologo(nombre);
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
    }
}
