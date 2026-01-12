using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.site.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.entities;
using PsycoApp.utilities;

namespace PsycoApp.site.Controllers
{
    public class FlujoController : Controller
    {
        private string url_flujo = Helper.GetUrlApi() + "/api/flujo";
        private string url = "";

        List<Flujo> listaFlujo = new List<Flujo>();

        dynamic obj = new System.Dynamic.ExpandoObject();

        [HttpGet]
        public ActionResult<List<Flujo>> validar_flujo_actual(Ticket oTicket)
        {
            string res = "";
            try
            {
                url = url_flujo + "/" + oTicket.id_usuario;

                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                listaFlujo = JsonConvert.DeserializeObject<List<Flujo>>(res);
            }
            catch (Exception ex)
            {
              
                //oRespuestaPV.descripcion = ex.Message.ToString();
            }
            return listaFlujo;
        }

        [HttpPost]
        public ActionResult<string> registrar_flujo(Flujo oFlujo)
        {
            string rpta = "";
            try
            {
                if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
                {
                    url = url_flujo + "/registrar_flujo";
                    obj = (dynamic)oFlujo;

                    rpta = ApiCaller.consume_endpoint_method(url, obj, "POST");
                } else
                {
                    return RedirectToAction("Index", "Login");
                }
            }
            catch (Exception ex)
            {
               
                rpta = "Ocurrió un error registrando el flujo";
            }
            return rpta;
        }

    }
}
