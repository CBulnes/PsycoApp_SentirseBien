using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using PsycoApp.BL;
using PsycoApp.BL.Interfaces;
using PsycoApp.DA;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.ApplicationInsights.MetricDimensionNames.TelemetryContext;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly IUsuarioBL usuarioBL;
        private readonly IConfiguration configuration;

        public UsuarioController(IUsuarioBL usuarioBL, IConfiguration configuration)
        {
            this.usuarioBL = usuarioBL;
            this.configuration = configuration;
        }

        [HttpPost("validar_usuario")]
        public ActionResult<RespuestaUsuario> validar_usuario([FromBody] Usuario usuario)
        {
            RespuestaUsuario respuesta = new RespuestaUsuario();
            try
            {
                usuario = usuarioBL.validar_usuario(usuario);

                respuesta.estado = usuario.validacion == "OK" ? true : false;
                respuesta.descripcion = usuario.validacion;
                respuesta.data = usuario;
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
                usuario = usuarioBL.actualizar_contraseña(usuario);

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

        #region "version react"
        [HttpPost("loginV2")]
        public async Task<IActionResult> LoginV2([FromBody] LoginDto request)
        {
            var respuesta = await usuarioBL.LoginV2(request);
            if (respuesta.Codigo == 0)
            {
                respuesta.Data.id_sede = request.idCentro;
                var token = GenerateJwtToken(respuesta.Data);

                return Ok(new{ Codigo = 0, Texto = "Autenticación exitosa", Datos = token });
            }
            else
            {
                return Ok(respuesta);
            }
        }

        private string GenerateJwtToken(Usuario usuario)
        {
            var jwtKey = configuration["Jwt:Key"];
            var key = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(jwtKey));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim("idUsuario", usuario.id_usuario.ToString()),
                new Claim("nombres", usuario.nombres),
                new Claim("apellidos", usuario.apellidos),
                new Claim("usuario", usuario.email),
                new Claim("tipoUsuario", usuario.tipousuario),
                new Claim("idSede", usuario.id_sede.ToString()),
                new Claim("idPsicologo", usuario.id_psicologo.ToString())
            };

            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.UtcNow.AddHours(1),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
        #endregion

    }
}
