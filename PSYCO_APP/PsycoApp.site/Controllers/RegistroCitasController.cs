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
        private readonly string apiUrl = Helper.GetUrlApi() + "/api/paciente"; // URL base de la API

        private string url_centros_atencion = Helper.GetUrlApi() + "/api/centroatencion/listar_centros";
        private string url_lista_psicologos = Helper.GetUrlApi() + "/api/psicologo/listar_psicologos_combo";
        private string url_lista_psicologos_dinamico = Helper.GetUrlApi() + "/api/paciente/listar_pacientes_combo_dinamico";
        
        private string url_lista_pacientes = Helper.GetUrlApi() + "/api/paciente/listar_pacientes_combo";
        private string url_registrar_cita = Helper.GetUrlApi() + "/api/cita/registrar_cita";
        private string url_confirmar_cita = Helper.GetUrlApi() + "/api/cita/confirmar_cita";
        private string url_atender_cita = Helper.GetUrlApi() + "/api/cita/atender_cita";
        private string url_cancelar_cita = Helper.GetUrlApi() + "/api/cita/cancelar_cita";
        private string url_actualizar_servicio = Helper.GetUrlApi() + "/api/cita/actualizar_servicio";
        private string url_pago_gratuito = Helper.GetUrlApi() + "/api/cita/pago_gratuito";
        private string url_disponibilidad_doctor = Helper.GetUrlApi() + "/api/cita/disponibilidad_doctor";
        private string url_horarios_doctor = Helper.GetUrlApi() + "/api/cita/horarios_doctor";
        private string url_citas_usuario = Helper.GetUrlApi() + "/api/cita/citas_usuario";
        private string url_historial = Helper.GetUrlApi() + "/api/cita/historial";
        private string url_productos_combo = Helper.GetUrlApi() + "/api/producto/listar_productos_combo";
        private string url_combo_sedes_x_usuario = Helper.GetUrlApi() + "/api/psicologo/listar_sedes_x_usuario_combo";
        private string url_combo_sedes = Helper.GetUrlApi() + "/api/psicologo/listar_sedes";
        private string url_fechas_semana = Helper.GetUrlApi() + "/api/cita/dias_x_semana_mes";

        private string url = "";
        dynamic obj = new System.Dynamic.ExpandoObject();

        RespuestaCentroAtencion oRespuesta = new RespuestaCentroAtencion();

        public async Task<IActionResult> Index()
        {
            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
            {
                string urlPaciente = string.IsNullOrEmpty("") ?
                 $"{apiUrl}/listar/{1}/{10}" :
                 $"{apiUrl}/buscar?nombre={""}&pageNumber={1}&pageSize={10}";

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
                obj.id_sede = HttpContext.Session.GetInt32("id_sede"); 
                obj.vista = "ATENCION";
                obj.call_center_invitado = Helper.GetCallCenterInvitado();

                var productos = await GetFromApiAsync<List<PsycoApp.entities.Producto>>(url_productos_combo);
                var productosViewModel = productos.Select(p => new PsycoApp.site.Models.Producto
                {
                    Id = p.Id,
                    Nombre = p.Nombre,
                    Alias = p.Alias,
                    Precio = p.Precio,
                    Color = p.Color,
                    NumSesiones = p.NumSesiones
                }).ToList();

                var pacientes = await GetFromApiAsync<List<PsycoApp.entities.Paciente>>(urlPaciente);
                var pacientesViewModel = pacientes.Select(p => new PsycoApp.site.Models.Paciente
                {
                    Id = p.Id,
                    Nombre = p.Nombre,
                    Apellido = p.Apellido,
                    DocumentoNumero = p.DocumentoNumero,
                    Estado = p.Estado,
                    DocumentoTipo = p.DocumentoTipo,
                    EstadoCivil = p.EstadoCivil,
                    FechaNacimiento = p.FechaNacimiento,
                    Sexo = p.Sexo,
                    Telefono = p.Telefono
                }).ToList();
                var productosYPacientesViewModel = new ProductosYPacientesViewModel
                {
                    Productos = productosViewModel,
                    Pacientes = pacientesViewModel,
                    DynamicData = obj
                };
                //var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.Producto>>
                //{
                //    Model = productosViewModel,
                //    DynamicData = obj
                //};

                return View("Index", productosYPacientesViewModel);
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

        [HttpGet]
        public ActionResult<List<entities.Paciente>> listar_pacientes_dinamico(int page = 1, string filtro = "", int pageSize = 10)
        {
            List<entities.Paciente> listaPacientes = new List<entities.Paciente>();
            try
            {
                string apiUrl = url_lista_psicologos_dinamico + $"?page={page}&pageSize={pageSize}&search={filtro}";
                var res =  ApiCaller.consume_endpoint_method(apiUrl, null, "GET");

                listaPacientes = JsonConvert.DeserializeObject<List<entities.Paciente>>(res);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                listaPacientes.Clear(); // Limpiar en caso de error
            }

            return (listaPacientes); // Retorna los pacientes como JSON
        }
        [HttpPost]
        //[AllowAnonymous]
        //[ResponseCache(NoStore = true, Duration = 0)]
        public async Task<RespuestaUsuario> RegistrarCita(Cita model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));
            //model.id_sede = Convert.ToInt32(HttpContext.Session.GetInt32("id_sede"));

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
        public async Task<RespuestaUsuario> ActualizarServicio(int id_cita, int id_servicio)
        {
            string res = "";

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_actualizar_servicio + "/" + id_cita + "/" + id_servicio;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al actualizar el servicio.";
            }
            return res_;
        }

        [HttpGet]
        public async Task<RespuestaUsuario> RegistrarPagoGratuito(int id_cita)
        {
            string res = "";
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_pago_gratuito + "/" + id_cita;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al registrar el pago gratuito.";
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
        public async Task<List<Cita>> ListarHorariosDoctor(string inicio, string fin, int id_doctor)
        {
            List<Cita> lista = new List<Cita>();
            string res = "";
            try
            {
                url = url_horarios_doctor + "/" + inicio + "/" + fin + "/" + id_doctor;
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
        public async Task<List<Cita>> CitasUsuario(int idPaciente, int idDoctor, int idSede, string tipoVista)
        {
            int id_usuario = Convert.ToInt32(HttpContext.Session.GetInt32("id_usuario"));
            List<Cita> lista = new List<Cita>();
            string res = "";
            try
            {
                url = url_citas_usuario + "/" + id_usuario + "/" + idPaciente + "/" + idDoctor + "/" + idSede;
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
        public async Task<Historial> Historial(int idCita, int idPaciente)
        {
            Historial historial = new Historial();
            string res = "";

            try
            {
                url = url_historial + "/" + idCita + "/" + idPaciente;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                historial = JsonConvert.DeserializeObject<Historial>(res);
            }
            catch (Exception)
            {
                historial = new Historial();
            }
            return historial;
        }

        [HttpGet]
        public ActionResult<List<entities.Sede>> listar_sedes_x_usuario(int id_doc)
        {
            int id_sede = Convert.ToInt32(HttpContext.Session.GetInt32("id_sede"));
            List<entities.Sede> lista = new List<entities.Sede>();
            string res = "";
            try
            {
                url = url_combo_sedes_x_usuario + "/" + id_doc;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.Sede>>(res);

                //if (id_sede > 0) lista.Clear();
                //if (lista.Count == 1) HttpContext.Session.SetInt32("id_sede", lista[0].Id);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public ActionResult<RespuestaUsuario> guardar_sede_sesion(int id_sede)
        {
            var res = new RespuestaUsuario();
            try
            {
                HttpContext.Session.SetInt32("id_sede", id_sede);
                res.estado = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                res.estado = false;
                res.descripcion = "Ocurrió un error al guardar la sede";
            }
            return res;
        }

        [HttpGet]
        public ActionResult<List<entities.Sede>> listar_sedes()
        {
            List<entities.Sede> lista = new List<entities.Sede>();
            string res = "";
            try
            {
                url = url_combo_sedes;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.Sede>>(res);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public ActionResult<List<entities.Semana>> ver_fechas_por_semana(int mes, int año, int semana)
        {
            List<entities.Semana> lista = new List<entities.Semana>();
            string res = "";
            try
            {
                url = url_fechas_semana + "/" + semana + "/" + mes + "/" + año;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.Semana>>(res);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                lista.Clear();
            }
            return lista;
        }

    }
}
