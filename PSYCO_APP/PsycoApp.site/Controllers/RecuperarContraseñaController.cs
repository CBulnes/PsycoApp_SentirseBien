using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.site.Models;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.entities;
using PsycoApp.utilities;
using Newtonsoft.Json;

namespace PsycoApp.site.Controllers
{
    public class RecuperarContraseñaController : Controller
    {
        private string url_api = Helper.GetUrlApi();
        private string url = "";
        private string res = "";
        dynamic obj = new System.Dynamic.ExpandoObject();

        RespuestaUsuario oRespuesta = new RespuestaUsuario();
        RespuestaContraseña oContraseña = new RespuestaContraseña();

        public IActionResult Index()
        {
            string path = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.PathBase}";
            return View("Index", path);
        }

        [HttpPost]
        public ActionResult<RespuestaUsuario> cambiar_contraseña(Usuario usuario)
        {
            try
            {
                url = url_api + "/api/usuario/validar_usuario";
                obj = (dynamic)usuario;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                oRespuesta = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
                usuario = oRespuesta.data;

                if (oRespuesta.estado)
                {
                    // actualizar contraseña
                    url = url_api + "/api/usuario/actualizar_contraseña";
                    obj = (dynamic)usuario;
                    res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                    oRespuesta = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
                }
            }
            catch (Exception ex)
            {
                oRespuesta.estado = false;
                oRespuesta.descripcion = "Ocurrió un error al validar sus credenciales";
            }
            return oRespuesta;
        }

        [HttpPost]
        public ActionResult<RespuestaContraseña> validar_requisitos_contraseña(Usuario usuario)
        {
            try
            {
                if (usuario.nuevo_pass1 != usuario.nuevo_pass2)
                {
                    oContraseña.iguales = false;
                }
                if (!Helper.validar_mayusculas(usuario.nuevo_pass1))
                {
                    oContraseña.mayusc = false;
                }
                if (!Helper.validar_minusculas(usuario.nuevo_pass1))
                {
                    oContraseña.minusc = false;
                }
                if (!Helper.validar_numeros(usuario.nuevo_pass1))
                {
                    oContraseña.numeros = false;
                }
                if (!Helper.validar_caracteres_especiales(usuario.nuevo_pass1))
                {
                    oContraseña.especial = false;
                }
            }
            catch (Exception ex)
            {
                
            }
            return oContraseña;
        }

        [HttpPost]
        public ActionResult<RespuestaUsuario> validar_credenciales(Usuario usuario)
        {
            try
            {
                bool validacion_email = Helper.ValidarCorreo(usuario.email);
                bool validacion_pass = string.IsNullOrEmpty(usuario.password) ? false : true;

                if (validacion_email && validacion_pass)
                {
                    oRespuesta.estado = true;
                }
                else
                {
                    oRespuesta.estado = false;
                }
            }
            catch (Exception ex)
            {
                oRespuesta.estado = false;
            }
            return oRespuesta;
        }

    }
}
