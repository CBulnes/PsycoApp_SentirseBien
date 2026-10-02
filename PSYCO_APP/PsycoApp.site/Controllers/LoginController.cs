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

        [HttpGet]
        public async Task<IActionResult> empresas()
        {
            try
            {
                using (var client = new HttpClient())
                {
                    var json = await client.GetStringAsync(url_api + "/api/EmpresaSede/empresas");
                    return Content(json, "application/json");
                }
            }
            catch
            {
                return StatusCode(503, "No se pudieron cargar las empresas.");
            }
        }

        [HttpGet]
        public async Task<IActionResult> sedes(int idEmpresa)
        {
            if (idEmpresa <= 0)
                return BadRequest("Selecciona una empresa válida.");

            try
            {
                using (var client = new HttpClient())
                {
                    var json = await client.GetStringAsync(url_api + "/api/EmpresaSede/empresas/" + idEmpresa + "/sedes");
                    return Content(json, "application/json");
                }
            }
            catch
            {
                return StatusCode(503, "No se pudieron cargar las sedes.");
            }
        }

        [HttpPost]
        public async Task<ActionResult<RespuestaUsuario>> validar_usuario(Usuario usuario)
        {
            try
            {
                usuario.email= usuario.email.Trim().ToUpper();
                usuario.password = usuario.password.Trim().ToUpper();
                int centro = usuario.id_sede;
                int idEmpresaSeleccionada = usuario.id_empresa;

                url = url_api + "/api/usuario/validar_usuario";
                obj = (dynamic)usuario;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                oRespuesta = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
                usuario = oRespuesta.data;

                if (oRespuesta.estado && usuario.id_tipousuario != 20
                    && !await EmpresaYSedeValidas(idEmpresaSeleccionada, usuario.id_sede))
                {
                    oRespuesta.estado = false;
                    oRespuesta.descripcion = "Selecciona una empresa y una sede activa que pertenezca a esa empresa.";
                    return oRespuesta;
                }

                if (oRespuesta.estado)
                {
                    centro = usuario.id_tipousuario == 20 ? 0 : usuario.id_sede;
                    HttpContext.Session.SetString("email", usuario.email);
                    HttpContext.Session.SetString("password", usuario.password);
                    HttpContext.Session.SetInt32("id_usuario", usuario.id_usuario);
                    HttpContext.Session.SetString("nombres", usuario.nombres);
                    HttpContext.Session.SetString("apellidos", usuario.apellidos);
                    HttpContext.Session.SetInt32("id_tipousuario", usuario.id_tipousuario);
                    HttpContext.Session.SetInt32("id_psicologo", usuario.id_psicologo);
                    HttpContext.Session.SetInt32("id_sede", centro);
                    HttpContext.Session.SetInt32("id_empresa", usuario.id_tipousuario == 20 ? 0 : idEmpresaSeleccionada);
                    HttpContext.Session.SetString("tipousuario", usuario.tipousuario.ToUpper());
                    HttpContext.Session.SetString("tipo_documento", usuario.tipo_documento);
                    HttpContext.Session.SetString("num_documento", usuario.num_documento);
                    HttpContext.Session.SetInt32("test_actual", usuario.test_actual);
                    HttpContext.Session.SetString("login", usuario.email);
                    HttpContext.Session.SetInt32("flag_chat", 1);
                }
            }
            catch (Exception ex)
            {
                oRespuesta.estado = false;
                oRespuesta.descripcion = "Ocurrió un error al validar sus credenciales";
            }
            return oRespuesta;
        }

        private async Task<bool> EmpresaYSedeValidas(int idEmpresa, int idSede)
        {
            using (var client = new HttpClient())
            {
                var empresasJson = await client.GetStringAsync(url_api + "/api/EmpresaSede/empresas");
                var empresas = JsonConvert.DeserializeObject<List<Empresa>>(empresasJson);
                var empresaActiva = empresas != null && empresas.Exists(e => e.Id == idEmpresa && e.Estado);
                if (!empresaActiva || idSede <= 0)
                    return false;

                var sedesJson = await client.GetStringAsync(url_api + "/api/EmpresaSede/empresas/" + idEmpresa + "/sedes");
                var sedes = JsonConvert.DeserializeObject<List<Sede>>(sedesJson);
                return sedes != null && sedes.Exists(s => s.Id == idSede && s.IdEmpresa == idEmpresa && s.Estado);
            }
        }

        [HttpPost]
        public ActionResult<RespuestaUsuario> actualizar_password(Usuario usuario)
        {
            try
            {
                url = url_api + "/api/usuario/actualizar_contraseña";
                obj = (dynamic)usuario;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                oRespuesta = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
                usuario = oRespuesta.data;
            }
            catch (Exception ex)
            {
                oRespuesta.estado = false;
                oRespuesta.descripcion = "Ocurrió un error al actualizar la contraseña.";
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
