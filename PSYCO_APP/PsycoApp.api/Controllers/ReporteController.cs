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
    public class ReporteController : ControllerBase
    {
        private readonly IWebHostEnvironment _host;
        private string main_path;

        public ReporteController(IWebHostEnvironment host)
        {
            this._host = host;
            main_path = _host.ContentRootPath;
        }

        ReporteBL reporteBL = new ReporteBL();
        RandomUtilities ru = new RandomUtilities();

        List<ReporteNPS> lista = new List<ReporteNPS>();
        string random_str = "";

        // GET api/values
        [HttpGet("reporte_nps/{año}/{mes}")]
        public ActionResult<List<ReporteNPS>> Get(int año, int mes)
        {
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                LOG.registrarLog("(Input " + random_str + ")[DATA]->[ReporteController.cs / reporte_nps <> año/mes: " + año + "/" + mes, "TRANSAC", main_path);

                lista = reporteBL.reporte_nps(año, mes, main_path, random_str);

                LOG.registrarLog("(Output " + random_str + ")[DATA]->[ReporteController.cs / reporte_nps <> json: " + JsonConvert.SerializeObject(lista), "TRANSAC", main_path);
            }
            catch (Exception e)
            {
              
                LOG.registrarLog("(Output " + random_str + ")[DATA]->[ReporteController.cs / reporte_nps <> json_error: " + JsonConvert.SerializeObject(lista), "TRANSAC", main_path);
            }
            return lista;
        }
    }
}
