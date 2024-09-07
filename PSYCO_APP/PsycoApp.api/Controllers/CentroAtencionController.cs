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
    public class CentroAtencionController : ControllerBase
    {
        private readonly IWebHostEnvironment _host;
        private string main_path;

        public CentroAtencionController(IWebHostEnvironment host)
        {
            this._host = host;
            main_path = _host.ContentRootPath;
        }

        CentroAtencionBL centroAtencionBL = new CentroAtencionBL();
        RandomUtilities ru = new RandomUtilities();

        RespuestaCentroAtencion oRespuesta = new RespuestaCentroAtencion();
        CentroAtencion oCentroAtencion = new CentroAtencion();
        List<CentroAtencion> lista = new List<CentroAtencion>();

        string random_str = "";

        // GET api/values
        [HttpGet("listar_centros/{latitud}/{longitud}")]
        public ActionResult<RespuestaCentroAtencion> listar_centros(string latitud, string longitud)
        {
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                LOG.registrarLog("(Input " + random_str + ")[DATA]->[CentroAtencionController.cs / listar_centros_atencion <> json: " + JsonConvert.SerializeObject(null), "TRANSAC", main_path);

                lista = centroAtencionBL.listar_centros_atencion(latitud, longitud, main_path, random_str);
                oRespuesta.data = lista;

                // vlidar si hay error
                if (lista.Count > 0 && lista[0].validacion != "OK")
                {
                    oRespuesta.estado = "ERROR";
                    oRespuesta.descripcion = lista[0].validacion;
                }

                LOG.registrarLog("(Output " + random_str + ")[DATA]->[CentroAtencionController.cs / listar_centros_atencion <> json: " + JsonConvert.SerializeObject(oRespuesta), "TRANSAC", main_path);
            }
            catch (Exception e)
            {
                oRespuesta.estado = "ERROR";
                oRespuesta.descripcion = e.Message.ToString();

                LOG.registrarLog("(Output " + random_str + ")[DATA]->[CentroAtencionController.cs / listar_centros_atencion <> json_error: " + JsonConvert.SerializeObject(oRespuesta), "TRANSAC", main_path);
            }
            return oRespuesta;
        }
    }
}
