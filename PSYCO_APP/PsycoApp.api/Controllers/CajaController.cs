using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.BL;
using PsycoApp.DA;
using PsycoApp.entities;
using PsycoApp.utilities;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CajaController : ControllerBase
    {
        private readonly IWebHostEnvironment _host;
        private string main_path;

        public CajaController(IWebHostEnvironment host)
        {
            this._host = host;
            main_path = _host.ContentRootPath;
        }

        CajaBL cajaBL = new CajaBL();
        RandomUtilities ru = new RandomUtilities();

        string res = "";
        string random_str = "";

        [HttpPost("registrar_pago")]
        public RespuestaUsuario RegistrarPago([FromBody] Pago oPago)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();
            try
            {
                res_ = cajaBL.registrar_pago(oPago, main_path, random_str);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al registrar el pago";
                res_.estado = false;
            }
            return res_;
        }

        [HttpGet("listar_pagos_pendientes/{id_paciente}")]
        public List<PagosPendientes> listar_pagos_pendientes(int id_paciente)
        {
            List<PagosPendientes> lista = new List<PagosPendientes>();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = cajaBL.listar_pagos_pendientes(id_paciente);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("listar_cuadre_caja/{usuario}/{pagina}/{tamanoPagina}")]
        public List<CuadreCaja> listar_cuadre_caja(string usuario, int pagina = 1, int tamanoPagina = 100)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = cajaBL.listar_cuadre_caja(usuario, pagina, tamanoPagina);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("listar_resumen_caja/{usuario}/{mes}/{anio}")]
        public List<CuadreCaja> listar_resumen_caja(string usuario, int mes = -1, int anio = -1)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = cajaBL.listar_resumen_caja(usuario, mes, anio);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

    }
}
