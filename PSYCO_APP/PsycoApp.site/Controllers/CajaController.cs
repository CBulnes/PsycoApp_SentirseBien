using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.site.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.entities;
using PsycoApp.utilities;
using System.Net.Http;
using Microsoft.CodeAnalysis.FlowAnalysis;

namespace PsycoApp.site.Controllers
{
    public class CajaController : Controller
    {
        private readonly string apiUrl = Helper.GetUrlApi() + "/api/caja"; // URL base de la API
        private string url_registrar_pago = Helper.GetUrlApi() + "/api/caja/registrar_pago";
        private string url_registrar_pago_masivo = Helper.GetUrlApi() + "/api/caja/registrar_pago_masivo";
        private string url_registrar_descuento = Helper.GetUrlApi() + "/api/caja/registrar_descuento";
        private string url_registrar_efectivo = Helper.GetUrlApi() + "/api/caja/registrar_efectivo";
        private string url_aperturar_caja = Helper.GetUrlApi() + "/api/caja/aperturar_caja";
        private string url_cerrar_caja = Helper.GetUrlApi() + "/api/caja/cerrar_caja";
        private string url_listar_pagos_pendientes = Helper.GetUrlApi() + "/api/caja/listar_pagos_pendientes";
        private string url_listar_resumen_caja = Helper.GetUrlApi() + "/api/caja/listar_resumen_caja";

        private string url = "";
        dynamic obj = new System.Dynamic.ExpandoObject();
        private string url_reporte = Helper.GetUrlApi() + "/api/reporte";

        List<ReporteNPS> listaReporteNPS = new List<ReporteNPS>();

        private string fechaYyyyMmDd()
        {
            return DateTime.Now.ToString("yyyy-MM-dd");
        }

        [Route("Caja")]
        public async Task<IActionResult> Index(int pageNumber = 1, int pageSize = 10, string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1, int id_cita = 0)
        {
            if (fecha == "")
            {
                fecha = fechaYyyyMmDd();
            }
            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
            {
                var usuario = Convert.ToString(HttpContext.Session.GetString("login"));
                usuario = string.IsNullOrEmpty(usuario) ? "-" : usuario;
                // Construir la URL para la API dependiendo de si hay un término de búsqueda
                string url = $"{apiUrl}/listar_cuadre_caja/{usuario}/{pageNumber}/{pageSize}/{fecha}/{buscar_por}/{sede}/{id_usuario}/{id_cita}";

                var registros = await GetFromApiAsync<List<PsycoApp.entities.CuadreCaja>>(url);
                var pacientesViewModel = registros.Select(p => new PsycoApp.site.Models.CuadreCaja
                {
                    paciente = p.paciente,
                    sede = p.sede,
                    fecha_transaccion = p.fecha_transaccion,
                    estado_cita = p.estado_cita,
                    servicio = p.servicio,
                    forma_pago = p.forma_pago,
                    detalle_transferencia = p.detalle_transferencia,
                    importe = p.importe,
                    usuario = p.usuario,
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
                obj.id_sede = HttpContext.Session.GetInt32("id_sede");
                obj.id_psicologo = HttpContext.Session.GetInt32("id_psicologo");
                obj.tipo_documento = HttpContext.Session.GetString("tipo_documento");
                obj.num_documento = HttpContext.Session.GetString("num_documento");
                obj.id_sede = HttpContext.Session.GetInt32("id_sede");
                obj.vista = "CAJA";

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
        public async Task<IActionResult> Buscar(int pageNumber = 1, int pageSize = 10, string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1, int id_cita = 0)
        {
            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
            {
                var usuario = Convert.ToString(HttpContext.Session.GetString("login"));
                usuario = string.IsNullOrEmpty(usuario) ? "-" : usuario;
                string url = $"{apiUrl}/listar_cuadre_caja/{usuario}/{pageNumber}/{pageSize}/{fecha}/{buscar_por}/{sede}/{id_usuario}/{id_cita}";

                var registros = await GetFromApiAsync<List<PsycoApp.entities.CuadreCaja>>(url);

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
                obj.id_sede = HttpContext.Session.GetInt32("id_sede");
                obj.id_psicologo = HttpContext.Session.GetInt32("id_psicologo");
                obj.tipo_documento = HttpContext.Session.GetString("tipo_documento");
                obj.num_documento = HttpContext.Session.GetString("num_documento");
                obj.vista = "CAJA";

                var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.CuadreCaja>>
                {
                    Model = registros.Select(p => new PsycoApp.site.Models.CuadreCaja
                    {
                        paciente = p.paciente,
                        sede = p.sede,
                        fecha_transaccion = p.fecha_transaccion,
                        estado_cita = p.estado_cita,
                        servicio = p.servicio,
                        forma_pago = p.forma_pago,
                        detalle_transferencia = p.detalle_transferencia,
                        importe = p.importe,
                        usuario = p.usuario,
                        estado_orden = p.estado_orden
                    }).ToList(),
                    DynamicData = obj
                };

                ViewBag.PageNumber = pageNumber;
                ViewBag.PageSize = pageSize;

                return PartialView("~/Views/Caja/_CajaTabla.cshtml", viewModelContainer.Model);
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        [HttpGet]
        public ActionResult<List<ReporteNPS>> reporte_nps(InputVisita oInputReporte)
        {
            string res = "";
            try
            {
                url = url_reporte + "/reporte_nps/" + oInputReporte.año + "/" + oInputReporte.mes;

                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                listaReporteNPS = JsonConvert.DeserializeObject<List<ReporteNPS>>(res);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                //oRespuestaPV.descripcion = ex.Message.ToString();
            }
            return listaReporteNPS;
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

        [HttpPost]
        public async Task<RespuestaUsuario> RegistrarPagoMasivo(PagoMasivo model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_registrar_pago_masivo;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar los pagos.";
            }
            return res_;
        }

        [HttpPost]
        public async Task<RespuestaUsuario> RegistrarDescuento(Pago model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_registrar_descuento;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar el descuento.";
            }
            return res_;
        }

        [HttpPost]
        public async Task<RespuestaUsuario> RegistrarEfectivoDiario(EfectivoDiario model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_registrar_efectivo;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar el efectivo.";
            }
            return res_;
        }

        [HttpPost]
        public async Task<RespuestaUsuario> AperturarCaja(CajaNuevo model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_aperturar_caja;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al aperturar la caja.";
            }
            return res_;
        }

        [HttpPost]
        public async Task<RespuestaUsuario> CerrarCaja(CajaNuevo model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_cerrar_caja;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al cerrar la caja.";
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
        public async Task<List<entities.ListaEfectivoDiario>> ListarEfectivoDiario()
        {
            List<entities.ListaEfectivoDiario> lista = new List<entities.ListaEfectivoDiario>();
            string res = "";
            string usuario = Convert.ToString(HttpContext.Session.GetString("login"));
            usuario = string.IsNullOrEmpty(usuario) ? "-" : usuario;
            try
            {
                url = Endpoints.apiUrl + "/api" + Endpoints.Caja.url_listar_efectivo_diario + "/" + usuario;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.ListaEfectivoDiario>>(res);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public async Task<List<entities.CuadreCaja>> ListarResumenCajaPorUsuario(string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1)
        {
            if (fecha == "")
            {
                fecha = fechaYyyyMmDd();
            }

            List<entities.CuadreCaja> lista = new List<entities.CuadreCaja>();
            string res = "";
            string usuario = Convert.ToString(HttpContext.Session.GetString("login"));
            usuario = string.IsNullOrEmpty(usuario) ? "-" : usuario;
            try
            {
                url = Endpoints.apiUrl + "/api" + Endpoints.Caja.url_resumen_caja_x_usuario + "/" + usuario + "/" + fecha + "/" + buscar_por + "/" + sede + "/" + id_usuario;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.CuadreCaja>>(res);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public async Task<List<entities.CuadreCaja>> ListarResumenCajaPorFormaPago(string fecha = "", int buscar_por = 1, int sede = -1, int id_usuario = -1)
        {
            if (fecha == "")
            {
                fecha = fechaYyyyMmDd();
            }

            List<entities.CuadreCaja> lista = new List<entities.CuadreCaja>();
            string res = "";
            string usuario = Convert.ToString(HttpContext.Session.GetString("login"));
            usuario = string.IsNullOrEmpty(usuario) ? "-" : usuario;
            try
            {
                url = Endpoints.apiUrl + "/api" + Endpoints.Caja.url_resumen_caja_x_forma_pago + "/" + usuario + "/" + fecha + "/" + buscar_por + "/" + sede + "/" + id_usuario;
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
