using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using PsycoApp.site.Models;
using IBM.Cloud.SDK.Core.Authentication.Iam;
using IBM.Watson.Assistant.v2;
using IBM.Watson.Assistant.v2.Model;
using IBM.Cloud.SDK.Core.Http.Exceptions;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System.IO;
using PsycoApp.entities;
using PsycoApp.utilities;
using Microsoft.AspNetCore.Hosting;
using System.Drawing;

namespace PsycoApp.site.Controllers
{
    public class HomeController : Controller
    {
        private string url_menu = Helper.GetUrlApi() + "/api/menu";
        private string url_punto_visita = Helper.GetUrlApi() + "/api/puntovisitado";
        private string url_encuesta = Helper.GetUrlApi() + "/api/encuesta";
        private string url_visita = Helper.GetUrlApi() + "/api/visita";
        private string url = "";

        RespuestaMenu oRespuesta = new RespuestaMenu();
        RespuestaPuntoVisitado oRespuestaPV = new RespuestaPuntoVisitado();
        RespuestaArchivos oRespuestaA = new RespuestaArchivos();
        Menu oMenu = new Menu();
        dynamic obj = new System.Dynamic.ExpandoObject();

        private IHostingEnvironment Environment;

        public HomeController(IHostingEnvironment _environment)
        {
            Environment = _environment;
        }

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
                obj.vista = "HOME";
                obj.call_center_invitado = Helper.GetCallCenterInvitado();

                string vista = "";
                if (obj.id_tipousuario == 1) //admin
                {
                    vista = "IndexAdmin";
                }
                if (obj.id_tipousuario == 2) //cliente
                {
                    vista = "Index";
                }
                if (obj.id_tipousuario == 3) //doctor
                {
                    vista = "IndexDoctor";
                }
                var viewModelContainer = new ViewModelContainer<List<PsycoApp.site.Models.Paciente>>
                {
                    DynamicData = obj
                };
                return View(vista, viewModelContainer);
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }

        [HttpPost]
        public ActionResult send_message(InputModel input)
        {
            ErrorResponseModel error_rspns = new ErrorResponseModel();

            string api_key = Helper.GetApiKey();
            string version = Helper.GetVersion();
            string url_asistente = Helper.GetUrlAsistente();
            string assistant_id = Helper.GetIdAsistente();

            dynamic obj_response = new System.Dynamic.ExpandoObject();
            string msg = input.message;

            if (msg == "hola")
            {
                //validar si tiene test asignado
            }
            if (msg == "Cuestionario 1")
            {
                //quiere iniciar test 1 (aun no confirmado)
            }
            if (msg == "Tpregunta1")
            {
                //confirma inicio test 1
            }

            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
            {
                try
                {
                    IamAuthenticator authenticator = new IamAuthenticator(
                        apikey: api_key
                    );

                    AssistantService assistant = new AssistantService(version, authenticator);
                    assistant.SetServiceUrl(url_asistente);

                    //assistant.DisableSslVerification(true);

                    var result = assistant.CreateSession(
                        assistantId: assistant_id
                    );

                    //Console.WriteLine(result.Response);
                    string sessionId = result.Result.SessionId;

                    var resultM = assistant.Message(
                    assistantId: assistant_id,
                    sessionId: sessionId,
                    input: new MessageInput()
                    {
                        Text = msg
                    });
                    Console.WriteLine(resultM.Response);

                    var resultF = assistant.DeleteSession(
                        assistantId: assistant_id,
                        sessionId: sessionId
                    );
                    Console.WriteLine(resultF.Response);

                    obj_response = resultM.Response;
                }
                catch (ServiceResponseException e)
                {
                    error_rspns.error = e.Message;
                    obj_response = error_rspns;
                }
                catch (Exception e)
                {
                    error_rspns.error = e.Message;
                    obj_response = error_rspns;
                }

                //return Json(obj_response);
            }
            else
            {
                error_rspns.error = "Session";
                obj_response = error_rspns;

                //return Json(obj_response);
            }
            return Json(obj_response);
        }

        [HttpPost]
        public ActionResult inactivar_sesion()
        {
            string res = "OK";
            try
            {
                HttpContext.Session.Clear();
            }
            catch (Exception ex)
            {
                res = ex.Message.ToString();
            }

            return Content(res);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        [HttpPost]
        public ActionResult cerrar_sesion()
        {
            string res = "OK";
            try
            {
                HttpContext.Session.Clear();
            }
            catch (Exception ex)
            {
                res = ex.Message.ToString();
            }

            return Content(res);
        }

        [HttpGet]
        public ActionResult<List<Menu>> listar_menu()
        {
            List<Menu> menu = new List<Menu>();
            try
            {
                //string id_usuario = Convert.ToInt32(HttpContext.Session.GetInt32("id_usuario")).ToString();
                //string id_tipousuario = Convert.ToInt32(HttpContext.Session.GetInt32("id_tipousuario")).ToString();

                //url = url_menu + "/" + id_usuario + "/" + id_tipousuario;
                //res = ApiCaller.consume_endpoint_method(url, null, "GET");
                //oRespuesta = JsonConvert.DeserializeObject<RespuestaMenu>(res);

                string tipo_usuario = HttpContext.Session.GetString("tipousuario");

                menu.Add(new Menu { nombre_opcion = "Inicio", ruta_opcion = "/Home" });

                if (tipo_usuario == "ADMIN" || tipo_usuario == "ADMINISTRADOR")
                {
                    //menu.Add(new Menu { nombre_opcion = "Mantenimiento", ruta_opcion = "Mantenimiento" });
                    menu.Add(new Menu { nombre_opcion = "Reportes", ruta_opcion = "/Reportes" });
                    menu.Add(new Menu { nombre_opcion = "Psicologos", ruta_opcion = "/Mantenimiento/Psicologo" });
                    menu.Add(new Menu { nombre_opcion = "Pacientes", ruta_opcion = "/Mantenimiento/Paciente" });
                }
                else if (tipo_usuario == "CLIENTE")
                {
                    menu.Add(new Menu { nombre_opcion = "Registro de citas", ruta_opcion = "RegistroCitas" });
                }
                else if (tipo_usuario == "DOCTOR" || tipo_usuario == "ESPECIALISTA")
                {
                    menu.Add(new Menu { nombre_opcion = "Historial de citas", ruta_opcion = "HistorialCitas" });
                }
            }
            catch (Exception ex)
            {
                menu.Clear();
            }
            return menu;
        }

        [HttpGet]
        public ActionResult<int> validar_flag_chat()
        {
            int flag_chat = 0;
            try
            {
                flag_chat = Convert.ToInt32(HttpContext.Session.GetInt32("flag_chat"));
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                flag_chat = -1;
            }
            return flag_chat;
        }

        [HttpGet]
        public ActionResult<string> deshabilitar_flag_chat()
        {
            string rpta = "";
            try
            {
                HttpContext.Session.SetInt32("flag_chat", 0);
                rpta = "OK";
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                rpta = "Ocurrió un error deshabilitando el flag_chat";
            }
            return rpta;
        }

        [HttpPost]
        public ActionResult<string> registrar_punto_visitado(Visita visita)
        {
            string rpta = "";
            try
            {
                url = url_visita + "/registrar_punto_visitado";
                obj = (dynamic)visita;

                rpta = ApiCaller.consume_endpoint_method(url, obj, "PUT");
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                rpta = "Ocurrió un error registrando la visita";
            }
            return rpta;
        }

        [HttpGet]
        public ActionResult<RespuestaPuntoVisitado> listar_puntos_visitados(InputVisita oInputVisita)
        {
            string res = "";
            try
            {
                int año = oInputVisita.año;
                int mes = oInputVisita.mes;
                string tipo = oInputVisita.tipo;
                url = url_punto_visita + "/" + año + "/" + mes + "/" + tipo;

                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                oRespuestaPV = JsonConvert.DeserializeObject<RespuestaPuntoVisitado>(res);
            }
            catch (Exception ex)
            {
                oRespuestaPV.estado = "ERROR";
                oRespuestaPV.descripcion = ex.Message.ToString();
            }
            return oRespuestaPV;
        }

        [HttpGet]
        public ActionResult<RespuestaArchivos> listar_archivos()
        {
            try
            {
                string dni = HttpContext.Session.GetString("num_documento");

                List<Archivo> oListaArchivos = new List<Archivo>();

                DirectoryInfo d = new DirectoryInfo("wwwroot/data");
                FileInfo[] Files = d.GetFiles();
                int i = 1;
                foreach (FileInfo file in Files)
                {
                    string nombre_archivo = file.Name.ToString();
                    if (nombre_archivo.IndexOf(dni) != -1)
                    {
                        Archivo oArchivo = new Archivo();
                        oArchivo.orden = i;
                        oArchivo.nombre = nombre_archivo;
                        oArchivo.ruta = "/data/" + nombre_archivo;
                        oListaArchivos.Add(oArchivo);
                        i++;
                    }
                }

                oRespuestaA.data = oListaArchivos;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                oRespuestaA.estado = "ERROR";
                oRespuestaA.descripcion = "Ocurrió un error listando sus recibos";
            }
            return oRespuestaA;
        }

        [HttpPost]
        public ActionResult<RespuestaUsuario> registrar_puntuacion(Puntuacion oPuntuacion)
        {
            string res = "";
            RespuestaUsuario rpta = new RespuestaUsuario();
            try
            {
                url = url_encuesta + "/registrar_puntuacion";
                obj = (dynamic)oPuntuacion;

                res = ApiCaller.consume_endpoint_method(url, obj, "POST");

                if (res == "OK")
                {
                    rpta.estado = true;
                } else
                {
                    rpta.estado = false;
                    rpta.descripcion = res;
                }
            }
            catch (Exception ex)
            {
                rpta.estado = false;
                rpta.descripcion = "Ocurrió un error registrando la encuesta";
            }
            return rpta;
        }

        [HttpGet]
        public ActionResult<List<string>> listar_articulos()
        {
            List<string> oListaArticulos = new List<string>();
            try
            {
                DirectoryInfo d = new DirectoryInfo("wwwroot/articulos");
                FileInfo[] Files = d.GetFiles();

                foreach (FileInfo file in Files)
                {
                    oListaArticulos.Add(file.Name.ToString().Replace(".html", ""));
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                oListaArticulos.Clear();
            }
            return oListaArticulos;
        }

        [HttpPost]
        public ActionResult<string> redireccionar(InputVisita oInputVisita)
        {
            if (oInputVisita.tipo == "REGISTRO")
            {
                return RedirectToAction("Index", "Registro");
            }
            else //LOGIN
            {
                return RedirectToAction("Index", "Login");
            }
        }

        [HttpPost]
        public async Task<ActionResult> SubirImagen(IFormFile file, int orden) //List<IFormFile> postedFiles
        {
            var response = new RespuestaUsuario();
            response.estado = true;
            try
            {
                if (file != null && file.Length > 0)
                {
                    var flag_file = false;
                    var type_ = Path.GetExtension(file.FileName);
                    //var fileNameWE = Path.GetFileNameWithoutExtension(file.FileName);
                    string fileNameWE = "s00" + orden;
                    var fileName = "";

                    string[] formatos_permitidos = { ".jpg", ".jpeg", ".png" };

                    if (!formatos_permitidos.Contains(type_.ToLower()))
                    {
                        response.estado = false;
                        response.descripcion = "El archivo cargado no está en el formato requerido (JPG, PNG).";
                        return Json(response);
                    }
                    else
                    {
                        using (var ms = new MemoryStream())
                        {
                            file.CopyTo(ms);
                            var binData = ms.ToArray();

                            // validar imagenes
                            if (type_.ToLower() == ".jpg" || type_.ToLower() == ".jpeg" || type_.ToLower() == ".png")
                            {
                                flag_file = true;
                            }

                            Bitmap image = new Bitmap(ms);
                            int width = image.Width;
                            int height = image.Height;

                            if (width != 1100 && height != 500)
                            {
                                response.estado = false;
                                response.descripcion = "Las dimensiones de la imagen deben ser: 1100px de largo y 500px de ancho.";
                                return Json(response);
                            }
                        }
                    }

                    if (flag_file)
                    {
                        fileName = (fileNameWE + (type_ == ".jpg" ? type_ : ".jpg")).ToLower();

                        string wwwPath = this.Environment.WebRootPath;
                        string dir = Path.Combine(this.Environment.WebRootPath, "images/carrousel");
                        string filePath = Path.Combine(dir, Path.GetFileName(fileName));

                        if (!Directory.Exists(dir))
                        {
                            Directory.CreateDirectory(dir);
                        }
                        using (Stream fileStream = new FileStream(filePath, FileMode.Create))
                        {
                            await file.CopyToAsync(fileStream);
                        }

                        //foreach (IFormFile postedFile in postedFiles)
                        //{
                        //    string fileName = Path.GetFileName(postedFile.FileName);
                        //    using (FileStream stream = new FileStream(Path.Combine(path, fileName), FileMode.Create))
                        //    {
                        //        postedFile.CopyTo(stream);
                        //        uploadedFiles.Add(fileName);
                        //        ViewBag.Message += string.Format("<b>{0}</b> uploaded.<br />", fileName);
                        //    }
                        //}
                    }
                    else //si el formato no es correcto
                    {
                        response.estado = false;
                        response.descripcion = "El formato del archivo cargado no es el correcto.";
                    }
                }
                else //si no tiene archivo cargado
                {
                    response.estado = false;
                    response.descripcion = "Error al cargar el archivo.";
                }
            }
            catch (Exception e)
            {
                response.estado = false;
                response.descripcion = "Ocurrió un error cargando el archivo.";
            }
            return Json(response);
        }
    }

}
