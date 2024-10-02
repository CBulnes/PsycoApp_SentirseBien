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
    public class RegistroCitasController : Controller
    {
        private string url_centros_atencion = Helper.GetUrlApi() + "/api/centroatencion/listar_centros";
        private string url_lista_psicologos = Helper.GetUrlApi() + "/api/psicologo/listar_psicologos_combo";
        private string url_registrar_cita = Helper.GetUrlApi() + "/api/cita/registrar_cita";
        private string url_disponibilidad_doctor = Helper.GetUrlApi() + "/api/cita/disponibilidad_doctor";
        private string url_citas_usuario = Helper.GetUrlApi() + "/api/cita/citas_usuario";

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

        [HttpPost]
        //[AllowAnonymous]
        //[ResponseCache(NoStore = true, Duration = 0)]
        public async Task<RespuestaUsuario> RegistrarCita(Cita model)
        {
            string res = "";
            model.id_usuario = Convert.ToInt32(HttpContext.Session.GetInt32("id_usuario"));

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
        public async Task<List<Cita>> CitasUsuario()
        {
            int id_usuario = Convert.ToInt32(HttpContext.Session.GetInt32("id_usuario"));
            List<Cita> lista = new List<Cita>();
            string res = "";
            try
            {
                url = url_citas_usuario + "/" + id_usuario;
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
