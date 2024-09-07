using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.site.Models;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.entities;
using PsycoApp.utilities;

namespace PsycoApp.site.Controllers
{
    public class RegistroController : Controller
    {
        private string url_usuario = Helper.GetUrlApi() + "/api/usuario";
        private string url = "";
        dynamic obj = new System.Dynamic.ExpandoObject();

        public IActionResult Index()
        {
            string path = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.PathBase}";
            return View("Index", path);
        }

        [HttpPost]
        public ActionResult<string> registrar_usuario(Usuario oLinea)
        {
            string rpta = "";
            try
            {
                url = url_usuario + "/registrar_usuario";
                obj = (dynamic)oLinea;

                rpta = ApiCaller.consume_endpoint_method(url, obj, "POST");
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                rpta = "Ocurrió un error registrando el usuario";
            }
            return rpta;
        }
    }
}
