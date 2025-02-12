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

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly IUsuarioLogin _usuarioBL;
        private readonly IMapper _mapper;

        public UsuarioController(IUsuarioLogin usuarioBL, IMapper mapper)
        {
            _usuarioBL = usuarioBL;
            _mapper = mapper;
        }
        [HttpPost("validar_usuario")]
        public ActionResult<RespuestaUsuario> validar_usuario([FromBody] UsuarioLoginDto usuarioDTO)
        {
            RespuestaUsuario respuesta = new RespuestaUsuario();
  
            try
            {
                var usuario = _usuarioBL.validar_usuario(usuarioDTO);
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
