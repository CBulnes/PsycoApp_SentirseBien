using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using PsycoApp.BL;
using PsycoApp.utilities;
using PsycoApp.entities;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        UsuarioBL usuarioBL = new UsuarioBL();
        private readonly IConfiguration configuration;

        public UsuarioController(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        [HttpPost("validar_usuario")]
        [AllowAnonymous]
        public ActionResult<RespuestaUsuario> validar_usuario([FromBody] Usuario usuario)
        {
            RespuestaUsuario respuesta = new RespuestaUsuario();
            try
            {
                usuario = usuarioBL.validar_usuario(usuario);

                respuesta.estado = usuario.validacion == "OK" ? true : false;
                if (respuesta.estado && usuario.id_tipousuario != 20 && (usuario.id_sede <= 0 || usuario.id_empresa <= 0))
                {
                    respuesta.estado = false;
                    respuesta.descripcion = "No se pudo validar la empresa y sede activa del usuario.";
                }
                if (respuesta.estado && usuario.id_tipousuario == 20)
                {
                    usuario.id_sede = 0;
                }
                else if (respuesta.estado)
                {
                    respuesta.descripcion = usuario.validacion;
                }
                usuario.password = string.Empty;
                respuesta.data = usuario;
                if (respuesta.estado)
                {
                    respuesta.token = PsycoApp.api.Security.JwtTokenIssuer.Create(usuario, configuration);
                }
            }
            catch (Exception)
            {
                respuesta.estado = false;
                respuesta.descripcion = "Ocurrió un error al validar sus credenciales";
            }
            return respuesta;
        }

        [HttpPost("actualizar_contraseña")]
        [AllowAnonymous]
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
            catch (Exception)
            {
                respuesta.estado = false;
                respuesta.descripcion = "Ocurrió un error al actualizar la contraseña";
            }
            return respuesta;
        }



    }
}
