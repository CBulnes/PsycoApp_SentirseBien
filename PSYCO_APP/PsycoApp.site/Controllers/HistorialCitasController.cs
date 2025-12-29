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

namespace PsycoApp.site.Controllers
{
    public class HistorialCitasController : Controller
    {
        private readonly string url_citas_doctor = Helper.GetUrlApi() + "/api/cita/citas_doctor";
        private readonly string url_historial_usuario = Helper.GetUrlApi() + "/api/cita/historial_usuario";
        private readonly string url_historial_pago_cita = Helper.GetUrlApi() + "/api/cita/historial_pago_cita";
        private readonly string url_registrar_historial = Helper.GetUrlApi() + "/api/cita/registrar_historial";
        private readonly string url_registrar_estado_cuestionario = Helper.GetUrlApi() + "/api/cita/registrar_estado_cuestionario";

        private string url = "";
        dynamic obj = new System.Dynamic.ExpandoObject();

        RespuestaCentroAtencion oRespuesta = new RespuestaCentroAtencion();

        public IActionResult Index()
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
                obj.id_sede = HttpContext.Session.GetInt32("id_sede");
                obj.id_psicologo = HttpContext.Session.GetInt32("id_psicologo");
                obj.tipo_documento = HttpContext.Session.GetString("tipo_documento");
                obj.num_documento = HttpContext.Session.GetString("num_documento");
                obj.vista = "ATENCION";
                obj.call_center_invitado = Helper.GetCallCenterInvitado();

                var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.Paciente>>
                {
                    //Model = pacientesViewModel,
                    DynamicData = obj
                };

                return View("Index", viewModelContainer);
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        [HttpGet]
        public async Task<List<Cita>> CitasDoctor(string inicio, string fin, int id_doctor, int id_estado, int ver_sin_reserva, int? idPaciente = null)
        {
            string usuario = HttpContext.Session.GetString("login").ToString();
            int? sede = HttpContext.Session.GetInt32("id_sede");
            List<Cita> lista = new List<Cita>();
            string res = "";
            try
            {
                url = url_citas_doctor + "/" + usuario + "/" + inicio + "/" + fin + "/" + id_estado + "/" + id_doctor +  "/" + ver_sin_reserva + "/" + sede + "/" + idPaciente;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<Cita>>(res);
                //lista = lista.Where(x => Convert.ToDecimal(x.monto_pendiente_.Replace("S/.", "")) > 0).ToList();

                if (idPaciente != -1 && idPaciente != null)
                {
                    lista = lista.Where(x => x.id_paciente == idPaciente).ToList();
                }
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public async Task<List<HistorialPaciente>> HistorialPaciente(int id_usuario)
        {
            List<HistorialPaciente> lista = new List<HistorialPaciente>();
            string res = "";
            try
            {
                url = url_historial_usuario + "/" + id_usuario;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<HistorialPaciente>>(res);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public async Task<List<entities.CuadreCaja>> VerHistorialPagosCita(int id_cita)
        {
            List<entities.CuadreCaja> lista = new List<entities.CuadreCaja>();
            int? id_sede = HttpContext.Session.GetInt32("id_sede");
            string res = "";
            try
            {
                url = url_historial_pago_cita + "/" + id_cita + "/" + id_sede;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.CuadreCaja>>(res);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpPost]
        public async Task<RespuestaUsuario> RegistrarHistorial(HistorialPaciente model)
        {
            model.id_doctor = Convert.ToInt32(HttpContext.Session.GetInt32("id_usuario"));
            RespuestaUsuario res_ = new RespuestaUsuario();
            string res = "";
            try
            {
                url = url_registrar_historial;
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
        public async Task<RespuestaUsuario> RegistrarEstadoCuestionario(HistorialPaciente model)
        {
            model.id_doctor = Convert.ToInt32(HttpContext.Session.GetInt32("id_usuario"));
            RespuestaUsuario res_ = new RespuestaUsuario();
            string res = "";
            try
            {
                url = url_registrar_estado_cuestionario;
                obj = (dynamic)model;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error atendiendo su solicitud.";
            }
            return res_;
        }

    }
}
