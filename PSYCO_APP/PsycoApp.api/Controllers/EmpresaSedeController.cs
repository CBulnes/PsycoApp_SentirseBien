using System;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using PsycoApp.entities;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmpresaSedeController : ControllerBase
    {
        private readonly EmpresaSedeBL _empresaSedeBL = new EmpresaSedeBL();

        [HttpGet("empresas")]
        public ActionResult ListarEmpresas()
        {
            try
            {
                return Ok(_empresaSedeBL.ListarEmpresas());
            }
            catch
            {
                return StatusCode(500, "No se pudieron cargar las empresas.");
            }
        }

        [HttpPost("empresas")]
        public ActionResult CrearEmpresa([FromBody] Empresa empresa)
        {
            try
            {
                empresa.Id = _empresaSedeBL.CrearEmpresa(empresa);
                return Ok(empresa);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch
            {
                return StatusCode(500, "No se pudo crear la empresa.");
            }
        }

        [HttpGet("empresas/{idEmpresa:int}/sedes")]
        public ActionResult ListarSedes(int idEmpresa)
        {
            try
            {
                return Ok(_empresaSedeBL.ListarSedes(idEmpresa));
            }
            catch (ArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch
            {
                return StatusCode(500, "No se pudieron cargar las sedes.");
            }
        }

        [HttpPost("sedes")]
        public ActionResult CrearSede([FromBody] Sede sede)
        {
            try
            {
                sede.Id = _empresaSedeBL.CrearSede(sede);
                return Ok(sede);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch
            {
                return StatusCode(500, "No se pudo crear la sede.");
            }
        }

        [HttpPost("usuarios")]
        public ActionResult CrearUsuario([FromBody] UsuarioEmpresa usuario)
        {
            try
            {
                var idUsuario = _empresaSedeBL.CrearUsuario(usuario);
                return Ok(new { id = idUsuario, message = "Usuario creado correctamente." });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (Exception)
            {
                return StatusCode(500, "No se pudo crear el usuario.");
            }
        }

    }
}
