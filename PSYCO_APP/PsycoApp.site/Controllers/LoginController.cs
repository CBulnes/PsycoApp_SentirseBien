using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using PsycoApp.site.Models;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.entities;
using PsycoApp.utilities;
using Newtonsoft.Json.Linq;

namespace PsycoApp.site.Controllers
{
    public class LoginController : Controller
    {
        private string url_api = Helper.GetUrlApi();
        private string url = "";
        private string res = "";
        dynamic obj = new System.Dynamic.ExpandoObject();

        RespuestaUsuario oRespuesta = new RespuestaUsuario();

        public IActionResult Index()
        {
            string path = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.PathBase}";
            return View("Index", path);
        }

        [HttpPost]
        public ActionResult<RespuestaUsuario> validar_usuario(Usuario usuario)
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
                    HttpContext.Session.SetString("email", usuario.email);
                    HttpContext.Session.SetString("password", usuario.password);
                    HttpContext.Session.SetInt32("id_usuario", usuario.id_usuario);
                    HttpContext.Session.SetString("nombres", usuario.nombres);
                    HttpContext.Session.SetString("apellidos", usuario.apellidos);
                    HttpContext.Session.SetInt32("id_tipousuario", usuario.id_tipousuario);
                    HttpContext.Session.SetInt32("id_psicologo", usuario.id_psicologo);
                    HttpContext.Session.SetInt32("id_sede", usuario.id_sede);
                    HttpContext.Session.SetString("tipousuario", usuario.tipousuario.ToUpper());
                    HttpContext.Session.SetString("tipo_documento", usuario.tipo_documento);
                    HttpContext.Session.SetString("num_documento", usuario.num_documento);
                    HttpContext.Session.SetInt32("test_actual", usuario.test_actual);
                    HttpContext.Session.SetString("login", usuario.login);
                    HttpContext.Session.SetInt32("flag_chat", 1);
                    HttpContext.Response.Cookies.Append("AuthToken", usuario.token, new CookieOptions
                    {
                        HttpOnly = true, 
                        Secure = true,  
                        SameSite = SameSiteMode.Strict,
                        Expires = DateTime.UtcNow.AddHours(1) 
                    });
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
        public ActionResult<RespuestaUsuario> validar_credenciales(Usuario usuario)
        {
            try
            {
                bool validacion_email = Helper.ValidarCorreo(usuario.email);
                bool validacion_pass = string.IsNullOrEmpty(usuario.password) ? false : true;

                if (validacion_email && validacion_pass)
                {
                    oRespuesta.estado = true;
                } else
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
