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
    public class PuntoVisitadoController : ControllerBase
    {
        private readonly IWebHostEnvironment _host;
        private string main_path;

        public PuntoVisitadoController(IWebHostEnvironment host)
        {
            this._host = host;
            main_path = _host.ContentRootPath;
        }

        PuntoVisitadoBL puntoVisitadoBL = new PuntoVisitadoBL();
        RandomUtilities ru = new RandomUtilities();

        RespuestaPuntoVisitado oRespuesta = new RespuestaPuntoVisitado();
        List<PuntoVisitado> lista = new List<PuntoVisitado>();

        string random_str = "";

        // GET api/values
        [HttpGet("{año}/{mes}/{tipo}")]
        public ActionResult<RespuestaPuntoVisitado> Get(int año, int mes, string tipo)
        {
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                LOG.registrarLog("(Input " + random_str + ")[DATA]->[PuntoVisitadoController.cs / " + tipo + " <> json: " + JsonConvert.SerializeObject(null), "TRANSAC", main_path);

                if (tipo == "puntos_visitados")
                {
                    lista = puntoVisitadoBL.listar_puntos_visitados(año, mes, main_path, random_str);
                } else if (tipo == "visitas")
                {
                    lista = puntoVisitadoBL.listar_visitas(año, mes, main_path, random_str);
                } else if (tipo == "encuestas")
                {
                    lista = puntoVisitadoBL.listar_encuestas(año, mes, main_path, random_str);
                }
                oRespuesta.data = lista;

                // vlidar si hay error
                if (lista.Count > 0 && lista[0].validacion != "OK")
                {
                    oRespuesta.estado = "ERROR";
                    oRespuesta.descripcion = lista[0].validacion;
                }

                LOG.registrarLog("(Output " + random_str + ")[DATA]->[PuntoVisitadoController.cs / " + tipo + " <> json: " + JsonConvert.SerializeObject(oRespuesta), "TRANSAC", main_path);
            }
            catch (Exception e)
            {
                oRespuesta.estado = "ERROR";
                oRespuesta.descripcion = e.Message.ToString();

                LOG.registrarLog("(Output " + random_str + ")[DATA]->[PuntoVisitadoController.cs / " + tipo + " <> json_error: " + JsonConvert.SerializeObject(oRespuesta), "TRANSAC", main_path);
            }
            return oRespuesta;
        }
    }
}
