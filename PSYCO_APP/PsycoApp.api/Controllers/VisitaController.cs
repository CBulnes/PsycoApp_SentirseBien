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
    public class VisitaController : ControllerBase
    {
        private readonly IWebHostEnvironment _host;
        private string main_path;

        public VisitaController(IWebHostEnvironment host)
        {
            this._host = host;
            main_path = _host.ContentRootPath;
        }

        VisitaBL visitaBL = new VisitaBL();
        RandomUtilities ru = new RandomUtilities();

        string res = "";
        string random_str = "";

        // POST api/values
        [HttpPost("registrar_visita")]
        public string Post([FromBody] Visita oVisita)
        {
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                LOG.registrarLog("(Input " + random_str + ")[DATA]->[VisitaController.cs / registrar_visita <> json: " + JsonConvert.SerializeObject(oVisita), "TRANSAC", main_path);

                res = visitaBL.registrar_visita(oVisita, main_path, random_str);

                LOG.registrarLog("(Output " + random_str + ")[DATA]->[VisitaController.cs / registrar_visita <> string: " + res, "TRANSAC", main_path);
            }
            catch (Exception)
            {
                res = "Ocurrió un error al registrar la visita";
                LOG.registrarLog("(Output " + random_str + ")[DATA]->[VisitaController.cs / registrar_visita <> string_error: " + res, "TRANSAC", main_path);
            }
            return res;
        }

        // POST api/values
        [HttpPut("registrar_punto_visitado")]
        public string Put([FromBody] Visita oVisita)
        {
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                LOG.registrarLog("(Input " + random_str + ")[DATA]->[VisitaController.cs / registrar_punto_visitado <> json: " + JsonConvert.SerializeObject(oVisita), "TRANSAC", main_path);

                res = visitaBL.registrar_punto_visitado(oVisita, main_path, random_str);

                LOG.registrarLog("(Output " + random_str + ")[DATA]->[VisitaController.cs / registrar_punto_visitado <> atring: " + res, "TRANSAC", main_path);
            }
            catch (Exception)
            {
                res = "Ocurrió un error al registrar la visita";
                LOG.registrarLog("(Output " + random_str + ")[DATA]->[VisitaController.cs / registrar_punto_visitado <> string_error: " + res, "TRANSAC", main_path);
            }
            return res;
        }
    }
}
