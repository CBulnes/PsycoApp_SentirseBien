using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.entities;
using PsycoApp.site.Models;
using PsycoApp.utilities;

namespace PsycoApp.site.Controllers
{
    public class AtencionController : Controller
    {
        private string url_centros_atencion = Helper.GetUrlApi() + "/api/centroatencion/listar_centros";
        private string url = "";

        RespuestaCentroAtencion oRespuesta = new RespuestaCentroAtencion();

        public IActionResult Index()
        {
            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
            {
                dynamic obj = new System.Dynamic.ExpandoObject();
                string path = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.PathBase}";
                obj.path = path;
                obj.call_center = Helper.GetCallCenter();
                obj.horario_atencion = Helper.GetHorario();
                obj.whatsapp = Helper.GetWhatsapp();
                obj.nombres = HttpContext.Session.GetString("nombres");
                obj.apellidos = HttpContext.Session.GetString("apellidos");
                obj.id_usuario = HttpContext.Session.GetInt32("id_usuario");
                obj.id_tipousuario = HttpContext.Session.GetInt32("id_tipousuario");
                obj.tipo_documento = HttpContext.Session.GetString("tipo_documento");
                obj.num_documento = HttpContext.Session.GetString("num_documento");
                obj.vista = "ATENCION";
                obj.call_center_invitado = Helper.GetCallCenterInvitado();

                if (obj.id_tipousuario == 1) //admin
                {
                    return RedirectToAction("Index", "Home");
                }
                else //cliente
                {
                    return View("Index", obj);
                }
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        [HttpPost]
        public ActionResult<RespuestaCentroAtencion> listar_centros_atencion(Position oPosition)
        {
            string res = "";
            try
            {
                url = url_centros_atencion + "/" + oPosition.latitud + "/" + oPosition.longitud;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                oRespuesta = JsonConvert.DeserializeObject<RespuestaCentroAtencion>(res);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                oRespuesta.estado = "ERROR";
                oRespuesta.descripcion = "Ocurrió un error obteniendo la lista de centros de atención"; //ex.Message.ToString();
            }
            return oRespuesta;
        }
    }
}
