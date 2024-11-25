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
    public class RegistroCitasController : Controller
    {
        private string url_centros_atencion = Helper.GetUrlApi() + "/api/centroatencion/listar_centros";
        private string url_lista_psicologos = Helper.GetUrlApi() + "/api/psicologo/listar_psicologos_combo";
        private string url_lista_pacientes = Helper.GetUrlApi() + "/api/paciente/listar_pacientes_combo";
        private string url_registrar_cita = Helper.GetUrlApi() + "/api/cita/registrar_cita";
        private string url_confirmar_cita = Helper.GetUrlApi() + "/api/cita/confirmar_cita";
        private string url_procesar_cita = Helper.GetUrlApi() + "/api/cita/procesar_cita";
        private string url_atender_cita = Helper.GetUrlApi() + "/api/cita/atender_cita";
        private string url_cancelar_cita = Helper.GetUrlApi() + "/api/cita/cancelar_cita";
        private string url_disponibilidad_doctor = Helper.GetUrlApi() + "/api/cita/disponibilidad_doctor";
        private string url_citas_usuario = Helper.GetUrlApi() + "/api/cita/citas_usuario";
        private string url_productos_combo = Helper.GetUrlApi() + "/api/producto/listar_productos_combo";

        private string url = "";
        dynamic obj = new System.Dynamic.ExpandoObject();

        RespuestaCentroAtencion oRespuesta = new RespuestaCentroAtencion();

        public async Task<IActionResult> Index()
        {
            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
            {
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
                obj.id_psicologo = HttpContext.Session.GetInt32("id_psicologo");
                obj.tipo_documento = HttpContext.Session.GetString("tipo_documento");
                obj.num_documento = HttpContext.Session.GetString("num_documento");
                obj.vista = "ATENCION";
                obj.call_center_invitado = Helper.GetCallCenterInvitado();

                var productos = await GetFromApiAsync<List<PsycoApp.entities.Producto>>(url_productos_combo);
                var productosViewModel = productos.Select(p => new PsycoApp.site.Models.Producto
                {
                    Id = p.Id,
                    Nombre = p.Nombre,
                    Alias = p.Alias,
                    Precio = p.Precio,
                    Color = p.Color
                }).ToList();

                var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.Producto>>
                {
                    Model = productosViewModel,
                    DynamicData = obj
                };

                return View("Index", viewModelContainer);
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        private async Task<T> GetFromApiAsync<T>(string url)
        {
            using var client = new HttpClient();
            var response = await client.GetStringAsync(url);
            return JsonConvert.DeserializeObject<T>(response);
        }

        [HttpPost]
        public ActionResult<RespuestaCentroAtencion> listar_centros_atencion(Position oPosition)
        {
            string res = "";
            try
            {
                url = url_centros_atencion + "/" + oPosition.latitud + "/" + oPosition.longitud;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                oRespuesta = JsonConvert.DeserializeObject<RespuestaCentroAtencion>(res);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                oRespuesta.estado = "ERROR";
                oRespuesta.descripcion = "Ocurrió un error obteniendo la lista de centros de atención"; //ex.Message.ToString();
            }
            return oRespuesta;
        }

        [HttpGet]
        public ActionResult<List<entities.Psicologo>> listar_doctores()
        {
            List<entities.Psicologo> lista = new List<entities.Psicologo>();
            string res = "";
            try
            {
                url = url_lista_psicologos;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.Psicologo>>(res);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public ActionResult<List<entities.Paciente>> listar_pacientes()
        {
            List<entities.Paciente> lista = new List<entities.Paciente>();
            string res = "";
            try
            {
                url = url_lista_pacientes;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.Paciente>>(res);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                lista.Clear();
            }
            return lista;
        }

        [HttpPost]
        //[AllowAnonymous]
        //[ResponseCache(NoStore = true, Duration = 0)]
        public async Task<RespuestaUsuario> RegistrarCita(Cita model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_registrar_cita;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar la cita.";
            }
            return res_;
        }

        [HttpPost]
        public async Task<RespuestaUsuario> ConfirmarCita(Cita model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_confirmar_cita;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al confirmar la cita.";
            }
            return res_;
        }

        [HttpPost]
        public async Task<RespuestaUsuario> ProcesarCita(Cita model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_procesar_cita;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al procesar la cita.";
            }
            return res_;
        }

        [HttpPost]
        public async Task<RespuestaUsuario> AtenderCita(Cita model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_atender_cita;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al atender la cita.";
            }
            return res_;
        }

        [HttpPost]
        public async Task<RespuestaUsuario> CancelarCita(Cita model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_cancelar_cita;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al cancelar la cita.";
            }
            return res_;
        }

        [HttpGet]
        //[AllowAnonymous]
        //[ResponseCache(NoStore = true, Duration = 0)]
        public async Task<List<Cita>> DisponibilidadDoctor(int id_doctor, string fecha)
        {
            List<Cita> lista = new List<Cita>();
            string res = "";
            try
            {
                url = url_disponibilidad_doctor + "/" + id_doctor + "/" + fecha;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<Cita>>(res);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        //[AllowAnonymous]
        //[ResponseCache(NoStore = true, Duration = 0)]
        public async Task<List<Cita>> CitasUsuario(int idPaciente, int idDoctor)
        {
            int id_usuario = Convert.ToInt32(HttpContext.Session.GetInt32("id_usuario"));
            List<Cita> lista = new List<Cita>();
            string res = "";
            try
            {
                url = url_citas_usuario + "/" + id_usuario + "/" + idPaciente + "/" + idDoctor;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<Cita>>(res);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

    }
}
