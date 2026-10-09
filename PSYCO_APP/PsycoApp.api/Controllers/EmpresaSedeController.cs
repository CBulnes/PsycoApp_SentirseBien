using System;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using PsycoApp.entities;
using PsycoApp.api.Security;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmpresaSedeController : ControllerBase
    {
        private readonly EmpresaSedeBL _empresaSedeBL = new EmpresaSedeBL();

        [HttpPost("registro-prueba")]
        [AllowAnonymous]
        public ActionResult RegistrarEmpresaPrueba([FromBody] RegistroSaasEmpresa registro)
        {
            if (registro == null)
                return BadRequest("Completa los datos de empresa, sede y administrador.");
            try
            {
                var resultado = _empresaSedeBL.RegistrarEmpresaPrueba(registro);
                return Ok(new
                {
                    empresa = resultado.Empresa,
                    sede = resultado.Sede,
                    usuario = resultado.Usuario,
                    idEmpresa = resultado.IdEmpresa,
                    idSede = resultado.IdSede,
                    idUsuario = resultado.IdUsuario
                });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (System.Data.SqlClient.SqlException ex) when (ex.Number >= 50101 && ex.Number <= 50104)
            {
                return BadRequest(ex.Message);
            }
            catch
            {
                return StatusCode(500, "No se pudo completar el registro de prueba.");
            }
        }

        [HttpGet("empresas")]
        [AllowAnonymous]
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
            if (!TenantContext.IsGlobalAdministrator(User))
                return Forbid();
            if (empresa == null || string.IsNullOrWhiteSpace(empresa.Nombre))
                return BadRequest("El nombre de empresa es obligatorio.");
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
        [AllowAnonymous]
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
            if (sede == null || sede.IdEmpresa <= 0 || string.IsNullOrWhiteSpace(sede.Nombre))
                return BadRequest("La empresa y el nombre de sede son obligatorios.");
            if (!TenantContext.CanAccessCompany(User, sede.IdEmpresa))
                return Forbid();
            if (!_empresaSedeBL.EmpresaActiva(sede.IdEmpresa))
                return BadRequest("La empresa no existe o está inactiva.");
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
            if (usuario == null || usuario.IdEmpresa <= 0 || usuario.IdSede <= 0)
                return BadRequest("La empresa y sede del usuario son obligatorias.");
            if (!TenantContext.CanAccessCompany(User, usuario.IdEmpresa))
                return Forbid();
            if (usuario.IdTipoUsuario != 1 && usuario.IdTipoUsuario != 3)
                return BadRequest("Solo se permiten los roles Administrador y Counter.");
            if (!_empresaSedeBL.SedePerteneceEmpresaActiva(usuario.IdSede, usuario.IdEmpresa))
                return BadRequest("La sede no pertenece a una empresa activa o está inactiva.");
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
