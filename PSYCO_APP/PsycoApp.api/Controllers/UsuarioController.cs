using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.BL;
using PsycoApp.utilities;
using PsycoApp.entities;
using PsycoApp.entities.DTO.DtoRequest;
using AutoMapper;
using PsycoApp.BL.Interfaces;
using Microsoft.AspNetCore.Authorization;
using System.IdentityModel.Tokens.Jwt;
using Newtonsoft.Json.Linq;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly IUsuarioLogin _usuarioBL;
        private readonly IMapper _mapper;
        private IManejoJwt manejoJwt;
        public UsuarioController(IUsuarioLogin usuarioBL, IMapper mapper, IManejoJwt manejoJwt)
        {
            _usuarioBL = usuarioBL;
            _mapper = mapper;
            this.manejoJwt = manejoJwt;
        }

        [HttpPost]
        [AllowAnonymous]
        [Route("debug-token")]
        [Consumes("application/json")]  // Asegura que solo acepte JSON
        public IActionResult DebugToken([FromBody] TokenRequest request)
        {
            if (string.IsNullOrEmpty(request?.Token))
            {
                return BadRequest("Token no proporcionado.");
            }

            var handler = new JwtSecurityTokenHandler();
            try
            {
                var jwtToken = handler.ReadJwtToken(request?.Token);
                return Ok(new
                {
                    Issuer = jwtToken.Issuer,
                    Audience = jwtToken.Audiences,
                    Expiration = jwtToken.ValidTo,
                    Claims = jwtToken.Claims.Select(c => new { c.Type, c.Value })
                });
            }
            catch (Exception ex)
            {
                return BadRequest($"Error al leer el token: {ex.Message}");
            }
        }

        [AllowAnonymous]
        [HttpPost("Autenticar")]
        public string Obtener()
        {
            

            var token = this.manejoJwt.GenerarToken("admin@abc.com", "Juan");



            return "Token: " + token;
        }
        [AllowAnonymous]
        [HttpGet("hora-localhost")]
        public IActionResult ObtenerHoraLocalhost()
        {
            return Ok(new
            {
                HoraUTC = DateTime.UtcNow,  // Hora en UTC
                HoraLocal = DateTime.Now,   // Hora en tu zona horaria
                ZonaHoraria = TimeZoneInfo.Local.StandardName
            });
        }

        [AllowAnonymous]
        [HttpPost("validar_usuario")]
      
        public ActionResult<RespuestaUsuario> validar_usuario([FromBody] UsuarioLoginDto usuarioDTO)
        {
            RespuestaUsuario respuesta = new RespuestaUsuario();
  
            try
            {
                var usuario = _usuarioBL.validar_usuario(usuarioDTO);
                var token = this.manejoJwt.GenerarToken(usuario.email, usuario.nombres);
                usuario.token = token;
                respuesta = _mapper.Map<RespuestaUsuario>(usuario);

                return Ok(respuesta);

            }
            catch (Exception e)
            {
                respuesta.estado = false;
                respuesta.descripcion = "Ocurrió un error al validar sus credenciales";
            }
            return respuesta;
        }

        [HttpPost("actualizar_contraseña")]
        public ActionResult<RespuestaUsuario> actualizar_contraseña([FromBody] Usuario usuario)
        {
            RespuestaUsuario respuesta = new RespuestaUsuario();
            try
            {
                usuario = _usuarioBL.actualizar_contraseña(usuario);

                respuesta.estado = usuario.validacion == "OK" ? true : false;
                respuesta.descripcion = usuario.validacion;
                respuesta.data = usuario;
            }
            catch (Exception e)
            {
                respuesta.estado = false;
                respuesta.descripcion = "Ocurrió un error al actualizar la contraseña";
            }
            return respuesta;
        }

    }
}
