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

namespace PsycoApp.site.Controllers.Mantenimiento
{
    public class PacienteController : Controller
    {
        private readonly string apiUrl = Helper.GetUrlApi()+ "/api/paciente"; // URL base de la API

        [Route("Mantenimiento/Paciente")]
        public async Task<IActionResult> Index()
        {
            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
            {
                string url = $"{apiUrl}/listar"; // Supongamo que esta es la URL de la API para obtener la lista de pacientes.
                var pacientes = await GetFromApiAsync<List<PsycoApp.entities.Paciente>>(url);
                var pacientesViewModel = pacientes.Select(p => new PsycoApp.site.Models.Paciente
                {
                    Id = p.Id,
                    Nombre = p.Nombre,
                    DocumentoNumero= p.DocumentoNumero,
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
                obj.tipo_documento = HttpContext.Session.GetString("tipo_documento");
                obj.num_documento = HttpContext.Session.GetString("num_documento");
                obj.vista = "HOME";
                obj.call_center_invitado = Helper.GetCallCenterInvitado();

                var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.Paciente>>
                {
                    Model = pacientesViewModel, // pacientesViewModel es una lista, pero como IEnumerable es más general, no necesita conversión explícita
                    DynamicData = obj
                };
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
        public async Task<IActionResult> Buscar(string nombre)
        {
            string url = $"{apiUrl}/buscar?nombre={nombre}";
            var pacientes = await GetFromApiAsync<List<entities.Paciente>>(url);
            return Json(pacientes);
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
            string url = $"{apiUrl}/eliminar_paciente/{id}";
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
    }
}
