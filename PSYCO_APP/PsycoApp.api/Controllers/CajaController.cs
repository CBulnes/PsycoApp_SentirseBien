using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.BL;
using PsycoApp.BL.Interfaces;
using PsycoApp.DA;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CajaController : ControllerBase
    {
        private readonly ICajaBL cajaBL;

        public CajaController(ICajaBL cajaBL)
        {
            this.cajaBL = cajaBL;
        }

        [HttpPost("registrar_pago")]
        public RespuestaUsuario RegistrarPago([FromBody] Pago oPago)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = cajaBL.registrar_pago(oPago, "", "");
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
        public List<ResumenCajaUsuario> resumen_caja_x_usuario(string usuario, string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1)
        {
            List<ResumenCajaUsuario> lista = new List<ResumenCajaUsuario>();
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
        public List<ResumenCajaFormaPago> resumen_caja_x_forma_pago(string usuario, string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1)
        {
            List<ResumenCajaFormaPago> lista = new List<ResumenCajaFormaPago>();
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

        #region "version react"
        [HttpGet("listarCaja")]
        public async Task<IActionResult> GetList([FromQuery] ListCajaDto request)
        {
            var respuesta = await cajaBL.GetList(request);
            return Ok(respuesta);
        }
        #endregion

    }
}
