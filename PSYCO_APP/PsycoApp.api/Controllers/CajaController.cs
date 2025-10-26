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

        [HttpPost("registrar_efectivo")]
        public RespuestaUsuario registrar_efectivo([FromBody] EfectivoDiario oPago)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();
            try
            {
                res_ = cajaBL.registrar_efectivo(oPago, main_path, random_str);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al registrar el efectivo";
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

        [HttpGet("listar_cuadre_caja/{usuario}/{pagina}/{tamanoPagina}/{fecha}/{buscar_por}/{sede}/{id_usuario}/{id_cita}")]
        public List<CuadreCaja> listar_cuadre_caja(string usuario, int pagina = 1, int tamanoPagina = 100, string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1, int id_cita = 0)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = cajaBL.listar_cuadre_caja(usuario, pagina, tamanoPagina, fecha, buscar_por, sede, id_usuario, id_cita);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("resumen_caja_x_usuario/{usuario}/{fecha}/{buscar_por}/{sede}/{id_usuario}")]
        public List<CuadreCaja> resumen_caja_x_usuario(string usuario, string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = cajaBL.resumen_caja_x_usuario(usuario, fecha, buscar_por, sede, id_usuario);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("resumen_caja_x_forma_pago/{usuario}/{fecha}/{buscar_por}/{sede}/{id_usuario}")]
        public List<CuadreCaja> resumen_caja_x_forma_pago(string usuario, string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1)
        {
            List<CuadreCaja> lista = new List<CuadreCaja>();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = cajaBL.resumen_caja_x_forma_pago(usuario, fecha, buscar_por, sede, id_usuario);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("listar_efectivo_diario/{usuario}")]
        public List<ListaEfectivoDiario> listar_efectivo_diario(string usuario)
        {
            List<ListaEfectivoDiario> lista = new List<ListaEfectivoDiario>();
            try
            {
                lista = cajaBL.listar_efectivo_diario(usuario);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

    }
}
