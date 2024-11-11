using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.site.Models;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.entities;
using PsycoApp.utilities;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Http;
using System.Net.Http;

namespace PsycoApp.site.Controllers
{
    public class CajaController : Controller
    {
        private readonly string apiUrl = Helper.GetUrlApi() + "/api/caja"; // URL base de la API
        private string url_registrar_pago = Helper.GetUrlApi() + "/api/caja/registrar_pago";
        private string url_listar_pagos_pendientes = Helper.GetUrlApi() + "/api/caja/listar_pagos_pendientes";
        private string url_listar_resumen_caja = Helper.GetUrlApi() + "/api/caja/listar_resumen_caja";

        private string url = "";
        dynamic obj = new System.Dynamic.ExpandoObject();

        [Route("Caja")]
        public async Task<IActionResult> Index(int pageNumber = 1, int pageSize = 10)
        {
            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
            {
                var usuario = Convert.ToString(HttpContext.Session.GetString("login"));
                // Construir la URL para la API dependiendo de si hay un término de búsqueda
                string url = $"{apiUrl}/listar_cuadre_caja/{usuario}/{pageNumber}/{pageSize}";

                var registros = await GetFromApiAsync<List<PsycoApp.entities.CuadreCaja>>(url);
                var pacientesViewModel = registros.Select(p => new PsycoApp.site.Models.CuadreCaja
                {
                    paciente = p.paciente,
                    fecha_transaccion = p.fecha_transaccion,
                    estado_cita = p.estado_cita,
                    servicio = p.servicio,
                    forma_pago = p.forma_pago,
                    detalle_transferencia = p.detalle_transferencia,
                    importe = p.importe,
                    estado_orden = p.estado_orden
                }).ToList();

                dynamic obj = new System.Dynamic.ExpandoObject();
                string path = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.PathBase}";
                obj.path = path;
                obj.call_center = Helper.GetCallCenter();
                obj.horario_atencion = Helper.GetHorario();
                obj.whatsapp = Helper.GetWhatsapp();
                obj.nombres = HttpContext.Session.GetString("nombres");
                obj.apellidos = HttpContext.Session.GetString("apellidos");
                obj.id_usuario = HttpContext.Session.GetInt32("id_usuario");
                obj.id_tipousuario = HttpContext.Session.GetInt32("id_tipousuario");
                obj.tipo_documento = HttpContext.Session.GetString("tipo_documento");
                obj.num_documento = HttpContext.Session.GetString("num_documento");
                obj.vista = "HOME";
                obj.call_center_invitado = Helper.GetCallCenterInvitado();

                var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.CuadreCaja>>
                {
                    Model = pacientesViewModel,
                    DynamicData = obj
                };

                // Devolver la vista con los datos del paginado y la lista de pacientes
                ViewBag.PageNumber = pageNumber;
                ViewBag.PageSize = pageSize;

                return View("~/Views/Caja/Index.cshtml", viewModelContainer);
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        [Route("/Caja/Buscar")]
        [HttpPost]
        public async Task<IActionResult> Buscar(int pageNumber = 1, int pageSize = 10)
        {
            var usuario = Convert.ToString(HttpContext.Session.GetString("login"));
            string url = $"{apiUrl}/listar_cuadre_caja?usuario={usuario}&pageNumber={pageNumber}&pageSize={pageSize}";
            var registros = await GetFromApiAsync<List<entities.CuadreCaja>>(url);

            dynamic obj = new System.Dynamic.ExpandoObject();
            string path = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.PathBase}";
            obj.path = path;
            obj.call_center = Helper.GetCallCenter();
            obj.horario_atencion = Helper.GetHorario();
            obj.whatsapp = Helper.GetWhatsapp();
            obj.nombres = HttpContext.Session.GetString("nombres");
            obj.apellidos = HttpContext.Session.GetString("apellidos");
            obj.id_usuario = HttpContext.Session.GetInt32("id_usuario");
            obj.id_tipousuario = HttpContext.Session.GetInt32("id_tipousuario");
            obj.tipo_documento = HttpContext.Session.GetString("tipo_documento");
            obj.num_documento = HttpContext.Session.GetString("num_documento");
            obj.vista = "HOME";
            var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.CuadreCaja>>
            {
                Model = registros.Select(p => new PsycoApp.site.Models.CuadreCaja
                {
                    paciente = p.paciente,
                    fecha_transaccion = p.fecha_transaccion,
                    estado_cita = p.estado_cita,
                    servicio = p.servicio,
                    forma_pago = p.forma_pago,
                    detalle_transferencia = p.detalle_transferencia,
                    importe = p.importe,
                    estado_orden = p.estado_orden
                }).ToList(),
                DynamicData = obj
            };

            ViewBag.PageNumber = pageNumber;
            ViewBag.PageSize = pageSize;
            return PartialView("~/Views/Caja/_PacienteTabla.cshtml", viewModelContainer.Model);
        }

        private async Task<T> GetFromApiAsync<T>(string url)
        {
            using var client = new HttpClient();
            var response = await client.GetStringAsync(url);
            return JsonConvert.DeserializeObject<T>(response);
        }

        [HttpPost]
        public async Task<RespuestaUsuario> RegistrarPago(Pago model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_registrar_pago;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar el pago.";
            }
            return res_;
        }

        [HttpGet]
        public async Task<List<PagosPendientes>> ListarPagosPendientes(int idPaciente)
        {
            List<PagosPendientes> lista = new List<PagosPendientes>();
            string res = "";
            try
            {
                url = url_listar_pagos_pendientes + "/" + idPaciente;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<PagosPendientes>>(res);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public async Task<List<entities.CuadreCaja>> ListarResumenCaja(int mes, int anio)
        {
            List<entities.CuadreCaja> lista = new List<entities.CuadreCaja>();
            string res = "";
            string usuario = Convert.ToString(HttpContext.Session.GetString("login"));
            try
            {
                url = url_listar_resumen_caja + "/" + usuario + "/" + mes + "/" + anio;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.CuadreCaja>>(res);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

    }
}
