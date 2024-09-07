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
    public class EncuestaController : ControllerBase
    {
        private readonly IWebHostEnvironment _host;
        private string main_path;

        public EncuestaController(IWebHostEnvironment host)
        {
            this._host = host;
            main_path = _host.ContentRootPath;
        }

        EncuestaBL encuestaBL = new EncuestaBL();
        RandomUtilities ru = new RandomUtilities();

        string res = "";
        string random_str = "";

        // POST api/values
        [HttpPost("registrar_puntuacion")]
        public string Post([FromBody] Puntuacion oPuntuacion)
        {
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                LOG.registrarLog("(Input " + random_str + ")[DATA]->[EncuestaController.cs / registrar_puntuacion <> json: " + JsonConvert.SerializeObject(oPuntuacion), "TRANSAC", main_path);

                res = encuestaBL.registrar_puntuacion(oPuntuacion, main_path, random_str);

                LOG.registrarLog("(Output " + random_str + ")[DATA]->[EncuestaController.cs / registrar_puntuacion <> string: " + res, "TRANSAC", main_path);
            }
            catch (Exception)
            {
                res = "Ocurrió un error al registrar la encuesta";
                LOG.registrarLog("(Output " + random_str + ")[DATA]->[EncuestaController.cs / registrar_puntuacion <> string_error: " + res, "TRANSAC", main_path);
            }
            return res;
        }
    }
}
