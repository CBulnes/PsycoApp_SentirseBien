using System;
using System.Collections.Generic;
using System.Security.Claims;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using PsycoApp.entities;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ConfigController : ControllerBase
    {
        private readonly IWebHostEnvironment _host;
        private string main_path;

        public ConfigController(IWebHostEnvironment host)
        {
            this._host = host;
            main_path = _host.ContentRootPath;
        }

        ConfigBL configBL = new ConfigBL();

        [HttpGet("obtener_configuracion")]
        public List<Configuracion> ObtenerConfiguracion()
        {
            List<Configuracion> lista = new List<Configuracion>();
            try
            {
                lista = configBL.obtener_configuracion();
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpPut("actualizar_valor")]
        public ActionResult ActualizarValor([FromBody] Configuracion conf)
        {
            if (User.FindFirst(ClaimTypes.Role)?.Value != "20")
            {
                return Forbid();
            }

            if (conf == null || string.IsNullOrWhiteSpace(conf.ConfigKey) || conf.ConfigValue == null)
            {
                return BadRequest("La configuración no es válida.");
            }

            try
            {
                configBL.actualizar_valor(conf.ConfigKey, conf.ConfigValue);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

    }
}
