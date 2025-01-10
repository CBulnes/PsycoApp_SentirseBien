using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.entities;
using PsycoApp.utilities;
using Microsoft.AspNetCore.Http;
using System.Net.Http;
using PsycoApp.site.Models;
using System.Drawing.Printing;
using System.Reflection;

namespace PsycoApp.site.Controllers.Mantenimiento
{
    public class PacienteController : Controller
    {
        private readonly string apiUrl = Helper.GetUrlApi()+ "/api/paciente"; // URL base de la API

        [Route("Mantenimiento/Paciente")]
        public async Task<IActionResult> Index(int pageNumber = 1, int pageSize = 10, string search = "")
        {
            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
            {
                // Construir la URL para la API dependiendo de si hay un término de búsqueda
                string url = string.IsNullOrEmpty(search) ?
                    $"{apiUrl}/listar/{pageNumber}/{pageSize}" :
                    $"{apiUrl}/buscar?nombre={search}&pageNumber={pageNumber}&pageSize={pageSize}";

                var pacientes = await GetFromApiAsync<List<PsycoApp.entities.Paciente>>(url);
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
                obj.vista = "HOME";
                obj.call_center_invitado = Helper.GetCallCenterInvitado();

                var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.Paciente>>
                {
                    Model = pacientesViewModel,
                    DynamicData = obj
                };

                // Devolver la vista con los datos del paginado y la lista de pacientes
                ViewBag.PageNumber = pageNumber;
                ViewBag.PageSize = pageSize;
                ViewBag.Search = search; // Pasar el término de búsqueda a la vista

                return View("~/Views/Mantenimiento/Paciente/Index.cshtml", viewModelContainer);
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }
        // POST: Paciente/Buscar
        [Route("/Mantenimiento/Paciente/Buscar")]
        [HttpPost]
        public async Task<IActionResult> Buscar(string nombre, int pageNumber = 1, int pageSize = 10)
        {
            string url = $"{apiUrl}/buscar?nombre={nombre}&pageNumber={pageNumber}&pageSize={pageSize}";
            var pacientes = await GetFromApiAsync<List<entities.Paciente>>(url);

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
            obj.vista = "HOME";
            var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.Paciente>>
            {
                Model = pacientes.Select(p => new PsycoApp.site.Models.Paciente
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
                }).ToList(),
                DynamicData = obj
            };

            ViewBag.PageNumber = pageNumber;
            ViewBag.PageSize = pageSize;
            ViewBag.NombreBuscado = nombre; // Guardamos el término de búsqueda
                                            //return RedirectToAction("Index", new { pageNumber, pageSize, search = nombre });
            return PartialView("~/Views/Mantenimiento/Paciente/_PacienteTabla.cshtml", viewModelContainer.Model);
        }


        // POST: Paciente/Buscar
        [Route("/Mantenimiento/Paciente/BuscarPacienteCita")]
        [HttpPost]
        public async Task<IActionResult> BuscarPacienteCita(string nombre, int pageNumber = 1, int pageSize = 10)
        {
            string url = $"{apiUrl}/buscar?nombre={nombre}&pageNumber={pageNumber}&pageSize={pageSize}";
            var pacientes = await GetFromApiAsync<List<entities.Paciente>>(url);

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
            obj.vista = "HOME";
            var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.Paciente>>
            {
                Model = pacientes.Select(p => new PsycoApp.site.Models.Paciente
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
                }).ToList(),
                DynamicData = obj
            };

            ViewBag.PageNumber = pageNumber;
            ViewBag.PageSize = pageSize;
            ViewBag.NombreBuscado = nombre; // Guardamos el término de búsqueda
                                            //return RedirectToAction("Index", new { pageNumber, pageSize, search = nombre });
            return PartialView("~/Views/Mantenimiento/Paciente/_PacienteTablaCita.cshtml", viewModelContainer.Model);
        }
        [Route("Mantenimiento/Paciente/Agregar")]
        // POST: Paciente/Agregar
        [HttpPost]
        public async Task<IActionResult> Agregar([FromBody] Models.Paciente paciente)
        {
            if (ModelState.IsValid)
            {
                string url = $"{apiUrl}/agregar";
                var response = await PostToApiAsync(url, paciente);
                if (response.IsSuccessStatusCode)
                {
                    return Ok(new { message = "Paciente guardado correctamente" });
                }
                return StatusCode((int)response.StatusCode, "Error al agregar paciente.");
            }
            return BadRequest("Modelo no válido.");
        }

        //[HttpPost]
        //public async Task<IActionResult> Agregar([FromBody] dynamic data)
        //{
        //    try
        //    {
        //        // Obtener el objeto "paciente" desde el JSON
        //        var pacienteJson = data.paciente.ToString();
        //        var paciente = JsonConvert.DeserializeObject<PsycoApp.site.Models.Paciente>(pacienteJson);

        //        if (paciente == null)
        //        {
        //            return BadRequest("El modelo no es válido. JSON no pudo ser deserializado.");
        //        }

        //        if (ModelState.IsValid)
        //        {
        //            string url = $"{apiUrl}/agregar_paciente";
        //            var response = await PostToApiAsync(url, paciente);
        //            if (response.IsSuccessStatusCode)
        //            {
        //                return Ok(new { message = "Paciente guardado correctamente" });
        //            }
        //            return StatusCode((int)response.StatusCode, "Error al agregar paciente.");
        //        }
        //        return BadRequest("Modelo no válido.");
        //    }
        //    catch (Exception ex)
        //    {
        //        return BadRequest($"Error al procesar los datos: {ex.Message}");
        //    }
        //}
        [Route("/Mantenimiento/Paciente/Editar")]
        // POST: Paciente/Editar
        [HttpPost]
        public async Task<IActionResult> Editar([FromBody] entities.Paciente paciente)
        {
            if (ModelState.IsValid)
            {
                string url = $"{apiUrl}/actualizar";
                var response = await PutToApiAsync(url, paciente);
                if (response.IsSuccessStatusCode)
                {
                    return Ok(new { message = "Paciente editado correctamente" });
                }
                return StatusCode((int)response.StatusCode, "Error al editar paciente.");
            }
            return BadRequest("Modelo no válido.");
        }
        [Route("/Mantenimiento/Paciente/Eliminar")]
        // POST: Paciente/Eliminar
        [HttpPost]
        public async Task<IActionResult> Eliminar(int id)
        {
            string url = $"{apiUrl}/eliminar/{id}";
            var response = await DeleteFromApiAsync(url);
            if (response.IsSuccessStatusCode)
            {
                return Ok(new { message = "Paciente eliminado correctamente" });
            }
            return StatusCode((int)response.StatusCode, "Error al eliminar paciente.");
        }

        private async Task<T> GetFromApiAsync<T>(string url)
        {
            using var client = new HttpClient();
            var response = await client.GetStringAsync(url);
            return JsonConvert.DeserializeObject<T>(response);
        }
        [Route("/Mantenimiento/Paciente/Get/{id}")]
        [HttpGet]
        public async Task<IActionResult> GetPaciente(int id)
        {
            try
            {
                string url = $"{apiUrl}/BuscarId/{id}"; // URL de la API para obtener el paciente por ID
                var paciente = await GetFromApiAsync<PsycoApp.entities.Paciente>(url);

                if (paciente == null)
                {
                    return NotFound("Paciente no encontrado.");
                }

                return Json(paciente); // Devuelve los detalles del paciente como JSON
            }
            catch (Exception ex)
            {
                return BadRequest($"Error al obtener el paciente: {ex.Message}");
            }
        }

        private async Task<HttpResponseMessage> PostToApiAsync<T>(string url, T data)
        {
            using var client = new HttpClient();
            var content = new StringContent(JsonConvert.SerializeObject(data), System.Text.Encoding.UTF8, "application/json");
            return await client.PostAsync(url, content);
        }

        private async Task<HttpResponseMessage> PutToApiAsync<T>(string url, T data)
        {
            using var client = new HttpClient();
            var content = new StringContent(JsonConvert.SerializeObject(data), System.Text.Encoding.UTF8, "application/json");
            return await client.PutAsync(url, content);
        }

        private async Task<HttpResponseMessage> DeleteFromApiAsync(string url)
        {
            using var client = new HttpClient();
            return await client.DeleteAsync(url);
        }

        [Route("Mantenimiento/Paciente/CargarPacientesModal")]
        [HttpGet]
        public async Task<IActionResult> CargarPacientesModal(int pageNumber = 1, int pageSize = 10, string search = "")
        {
            try
            {
                // Construir la URL para llamar a la API según el término de búsqueda
                string url = string.IsNullOrEmpty(search)
                    ? $"{apiUrl}/listar/{pageNumber}/{pageSize}"
                    : $"{apiUrl}/buscar?nombre={search}&pageNumber={pageNumber}&pageSize={pageSize}";

                // Obtener la lista de pacientes desde la API
                var pacientes = await GetFromApiAsync<List<PsycoApp.entities.Paciente>>(url);

                // Mapear los pacientes de entidad a ViewModel si es necesario
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

                // Devolver la vista parcial con los datos
                return PartialView("~/Views/Mantenimiento/Paciente/_PacienteTabla.cshtml", pacientesViewModel);
            }
            catch (Exception ex)
            {
                // Manejo de errores
                return BadRequest($"Error al cargar pacientes: {ex.Message}");
            }
        }

    }
}
