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
    public class ReportesController : Controller
    {
        private string url_reporte = Helper.GetUrlApi() + "/api/reporte";
        private string url = "";

        dynamic obj = new System.Dynamic.ExpandoObject();

        List<ReporteNPS> listaReporteNPS = new List<ReporteNPS>();

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
                obj.vista = "REPORTE";
                obj.call_center_invitado = Helper.GetCallCenterInvitado();

                var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.Psicologo>>
                {
                    DynamicData = obj
                };

                return View("Index", viewModelContainer);
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        [HttpGet]
        public ActionResult<List<ReporteNPS>> reporte_nps(InputVisita oInputReporte)
        {
            string res = "";
            try
            {
                url = url_reporte + "/reporte_nps/" + oInputReporte.año + "/" + oInputReporte.mes;

                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                listaReporteNPS = JsonConvert.DeserializeObject<List<ReporteNPS>>(res);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                //oRespuestaPV.descripcion = ex.Message.ToString();
            }
            return listaReporteNPS;
        }
    }
}
