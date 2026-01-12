using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.BL;
using PsycoApp.entities;
using PsycoApp.utilities;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FlujoController : ControllerBase
    {
        private readonly IWebHostEnvironment _host;
        private string main_path;

        public FlujoController(IWebHostEnvironment host)
        {
            this._host = host;
            main_path = _host.ContentRootPath;
        }

        FlujoBL flujoBL = new FlujoBL();
        RandomUtilities ru = new RandomUtilities();

        List<Flujo> lista = new List<Flujo>();
        string res = "";
        string random_str = "";

        // GET api/values
        [HttpGet("{id_usuario}")]
        public ActionResult<List<Flujo>> Get(int id_usuario)
        {
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                LOG.registrarLog("(Input " + random_str + ")[DATA]->[FlujoController.cs / validar_flujo_actual <> id_usuario: " + id_usuario, "TRANSAC", main_path);

                lista = flujoBL.validar_flujo_actual(id_usuario, main_path, random_str);

                LOG.registrarLog("(Output " + random_str + ")[DATA]->[FlujoController.cs / validar_flujo_actual <> json: " + JsonConvert.SerializeObject(lista), "TRANSAC", main_path);
            }
            catch (Exception e)
            {
                
                LOG.registrarLog("(Output " + random_str + ")[DATA]->[FlujoController.cs / validar_flujo_actual <> json_error: " + JsonConvert.SerializeObject(lista), "TRANSAC", main_path);
            }
            return lista;
        }

        [HttpPost("registrar_flujo")]
        public string Post([FromBody] Flujo oFlujo)
        {
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                LOG.registrarLog("(Input " + random_str + ")[DATA]->[FlujoController.cs / registrar_flujo <> json: " + JsonConvert.SerializeObject(oFlujo), "TRANSAC", main_path);

                res = flujoBL.registrar_flujo(oFlujo, main_path, random_str);

                LOG.registrarLog("(Output " + random_str + ")[DATA]->[FlujoController.cs / registrar_flujo <> string: " + res, "TRANSAC", main_path);
            }
            catch (Exception)
            {
                res = "Ocurrió un error al registrar el flujo";
                LOG.registrarLog("(Output " + random_str + ")[DATA]->[FlujoController.cs / registrar_flujo <> string_error: " + res, "TRANSAC", main_path);
            }
            return res;
        }

    }
}
