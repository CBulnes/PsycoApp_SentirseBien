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
using Microsoft.Extensions.Caching.Memory;
using System.Drawing.Printing;

namespace PsycoApp.site.Controllers
{
    public class RegistroCitasController : Controller
    {
        private readonly string apiUrl = Helper.GetUrlApi() + "/api/paciente"; // URL base de la API
        private readonly IMemoryCache _cache;
        private string url_centros_atencion = Helper.GetUrlApi() + "/api/centroatencion/listar_centros";
        private string url_lista_psicologos = Helper.GetUrlApi() + "/api/psicologo/listar_psicologos_combo";
        private string url_lista_usuarios_caja = Helper.GetUrlApi() + "/api/psicologo/listar_usuarios_caja_combo";
        private string url_lista_psicologos_dinamico = Helper.GetUrlApi() + "/api/paciente/listar_pacientes_combo_dinamico";
        
        private string url_lista_pacientes = Helper.GetUrlApi() + "/api/paciente/listar_pacientes_combo";
        private string url_registrar_informe_adicional = Helper.GetUrlApi() + "/api/cita/informe_adicional";
        private string url_registrar_cita = Helper.GetUrlApi() + "/api/cita/registrar_cita";
        private string url_actualizar_citas_paquete = Helper.GetUrlApi() + "/api/cita/actualizar_citas_paquete";
        private string url_confirmar_cita = Helper.GetUrlApi() + "/api/cita/confirmar_cita";
        private string url_atender_cita = Helper.GetUrlApi() + "/api/cita/atender_cita";
        private string url_cancelar_cita = Helper.GetUrlApi() + "/api/cita/cancelar_cita";
        private string url_actualizar_servicio = Helper.GetUrlApi() + "/api/cita/actualizar_servicio";
        private string url_pago_gratuito = Helper.GetUrlApi() + "/api/cita/pago_gratuito";
        private string url_disponibilidad_doctor = Helper.GetUrlApi() + "/api/cita/disponibilidad_doctor";
        private string url_horarios_doctor = Helper.GetUrlApi() + "/api/cita/horarios_doctor";
        private string url_citas_usuario = Helper.GetUrlApi() + "/api/cita/citas_usuario";
        private string url_citas_x_paquete = Helper.GetUrlApi() + "/api/cita/citas_por_paquete";
        private string url_historial = Helper.GetUrlApi() + "/api/cita/historial";
        private string url_productos_combo = Helper.GetUrlApi() + "/api/producto/listar_productos_combo";
        private string url_combo_sedes_x_usuario = Helper.GetUrlApi() + "/api/psicologo/listar_sedes_x_usuario_combo";
        private string url_combo_sedes = Helper.GetUrlApi() + "/api/psicologo/listar_sedes";
        private string url_fechas_semana = Helper.GetUrlApi() + "/api/cita/dias_x_semana_mes";

        private string url = "";
        dynamic obj = new System.Dynamic.ExpandoObject();

        RespuestaCentroAtencion oRespuesta = new RespuestaCentroAtencion();
        public RegistroCitasController(IMemoryCache cache)
        {
            _cache = cache;
        }
        public async Task<IActionResult> Index()
        {
            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
            {
                //string urlPaciente = string.IsNullOrEmpty("") ?
                // $"{apiUrl}/listar/{1}/{10}" :
                // $"{apiUrl}/buscar?nombre={""}&pageNumber={1}&pageSize={10}";

                var id_sedes = HttpContext.Session.GetInt32("id_sede");
                // Construir la URL para la API dependiendo de si hay un término de búsqueda
                string urlPaciente = string.IsNullOrEmpty("") ?
                   //$"{apiUrl}/listar/{pageNumber}/{pageSize}" :
                   $"{apiUrl}/listarSede/{1}/{10}/{id_sedes}" :
                    $"{apiUrl}/buscar?nombre={""}&pageNumber={1}&pageSize={10}&sede={id_sedes}";
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
                    Nombre = p.Nombre.Trim().ToUpper(),
                    Apellido = p.Apellido.Trim().ToUpper(),
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
            try
            {
                using var client = new HttpClient();
                var response = await client.GetStringAsync(url);
                return JsonConvert.DeserializeObject<T>(response);
            }
            catch (Exception ex)
            {
                var msg = ex.Message.ToString();
                throw;
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
               
                oRespuesta.estado = "ERROR";
                oRespuesta.descripcion = "Ocurrió un error obteniendo la lista de centros de atención"; //ex.Message.ToString();
            }
            return oRespuesta;
        }

        [HttpGet]
        public ActionResult<List<entities.Psicologo>> listar_doctores(int filtrar_por_sede)
        {
            List<entities.Psicologo> lista = new List<entities.Psicologo>();
            string res = "";
            try
            {
                url = url_lista_psicologos;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.Psicologo>>(res);

                if (filtrar_por_sede == 1)
                {
                    var id_sede = HttpContext.Session.GetInt32("id_sede");
                    lista = lista.Where(x => x.Sedes.Contains(id_sede.ToString())).ToList();
                }
            }
            catch (Exception ex)
            {
             
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public ActionResult<List<entities.Usuario>> listar_usuarios_caja(int filtrar_por_sede)
        {
            List<entities.Usuario> lista = new List<entities.Usuario>();
            string res = "";
            try
            {
                url = url_lista_usuarios_caja;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.Usuario>>(res);

                if (filtrar_por_sede == 1)
                {
                    var id_sede = HttpContext.Session.GetInt32("id_sede");
                    lista = lista.Where(x => x.sedes.Contains(id_sede.ToString())).ToList();
                }
            }
            catch (Exception ex)
            {
              
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public ActionResult<List<entities.Paciente>> listar_pacientes()
        {
            var id_sede = HttpContext.Session.GetInt32("id_sede");
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
           
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public async Task<List<entities.Paciente>> listar_pacientes_dinamico(int page = 1, string filtro = "", int pageSize = 10, bool IdBusqueda = false)
        {
            var id_sede = HttpContext.Session.GetInt32("id_sede");

            List<entities.Paciente> listaPacientes = new List<entities.Paciente>();
            string cacheKey = $"pacientes_{page}_{pageSize}_{filtro}_{id_sede}";

            // 🔥 Si existe en cache → retornar directamente
            if (_cache.TryGetValue(cacheKey, out List<entities.Paciente> pacientesGuardados))
            {
                return pacientesGuardados;
            }
            try
            {
                string apiUrl = url_lista_psicologos_dinamico + $"?page={page}&pageSize={pageSize}&search={(IdBusqueda ? filtro : "*" + filtro + "*")}&sede={id_sede}";

                // 🔥 AQUÍ estaba tu error → faltaba el await
                string res = await ApiCaller.consume_endpoint_method_async(apiUrl, null, "GET");

                listaPacientes = JsonConvert.DeserializeObject<List<entities.Paciente>>(res);

                foreach (var obj in listaPacientes)
                {
                    obj.Nombre = obj.Nombre.Trim().ToUpper();
                }
                // 🧠 Guardar en memoria por 1 minuto (puedes cambiarlo)
                _cache.Set(cacheKey, listaPacientes, TimeSpan.FromMinutes(1));
            }
            catch (Exception ex)
            {
              
                listaPacientes.Clear();
            }

            return listaPacientes;
        }


        [HttpPost]
        public async Task<RespuestaUsuario> AgregarInforme(Cita model)
        {
            string res = "";
            model.usuario = Convert.ToString(HttpContext.Session.GetString("login"));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_registrar_informe_adicional;
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
        public async Task<RespuestaUsuario> ActualizarCitasPaquete(List<Subcita> citas)
        {
            string res = "";
            citas.ForEach(x => x.usuario = Convert.ToString(HttpContext.Session.GetString("login")));

            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                url = url_actualizar_citas_paquete;
                obj = (dynamic)citas;
                res = ApiCaller.consume_endpoint_method(url, obj, "POST");
                res_ = JsonConvert.DeserializeObject<RespuestaUsuario>(res);
            }
            catch (Exception)
            {
                res_.estado = false;
                res_.descripcion = "Ocurrió un error al actualizar las citas.";
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
        public async Task<List<Cita>> DisponibilidadDoctor(int id_doctor, string fecha, int servicio)
        {
            List<Cita> lista = new List<Cita>();

            try
            {
                string url = $"{url_disponibilidad_doctor}/{id_doctor}/{fecha}/{servicio}";

                // 🔥 Debe ser await OBLIGATORIO
                string res = await ApiCaller.consume_endpoint_method_async(url, null, "GET");

                lista = JsonConvert.DeserializeObject<List<Cita>>(res);
            }
            catch
            {
                lista.Clear();
            }

            return lista;
        }


        [HttpGet]
        public async Task<List<Cita>> ListarHorariosDoctor(string inicio, string fin, int id_doctor)
        {
            List<Cita> lista = new List<Cita>();

            try
            {
                string url = $"{url_horarios_doctor}/{inicio}/{fin}/{id_doctor}";

                // 🔥 Debe ser await
                string res = await ApiCaller.consume_endpoint_method_async(url, null, "GET");

                lista = JsonConvert.DeserializeObject<List<Cita>>(res);
            }
            catch
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
            var id_sede = HttpContext.Session.GetInt32("id_sede");
            List<Cita> lista = new List<Cita>();
            string res = "";
            try
            {
                url = url_citas_usuario + "/" + id_usuario + "/" + idPaciente + "/" + idDoctor + "/" + id_sede;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<Cita>>(res).Where(x => x.id_sede == id_sede).ToList();
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet]
        public async Task<List<Cita>> ObtenerCitasPorPaquete(int idPaquete)
        {
            List<Cita> lista = new List<Cita>();
            string res = "";
            try
            {
                url = url_citas_x_paquete + "/" + idPaquete;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<Cita>>(res).ToList();
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
        public async Task<List<Models.CuadreCaja>> HistorialPago(int id_cita = 0,string fecha="")
        {
            List<Models.CuadreCaja> historial = new List<Models.CuadreCaja>();
            string res = "";

            var usuario = Convert.ToString(HttpContext.Session.GetString("login"));
            usuario = string.IsNullOrEmpty(usuario) ? "-" : usuario;
            
            string apiUrl = Helper.GetUrlApi() + "/api/caja"; // URL base de la API
            string url = $"{apiUrl}/listar_cuadre_caja/{usuario}/{1}/{100}/{fecha}/{1}/{-1}/{-1}/{id_cita}";
            
            var registros = await GetFromApiAsync<List<PsycoApp.entities.CuadreCaja>>(url);
            historial = registros.Select(p => new PsycoApp.site.Models.CuadreCaja
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
             
                lista.Clear();
            }
            return lista;
        }

    }
}
