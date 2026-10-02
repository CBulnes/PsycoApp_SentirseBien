using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.entities;
using PsycoApp.site.Models;
using PsycoApp.utilities;

namespace PsycoApp.site.Controllers.Administracion
{
    public class EmpresasController : Controller
    {
        private readonly string _apiUrl = Helper.GetUrlApi() + "/api/EmpresaSede";

        [HttpGet("Administracion/Empresas")]
        public async Task<IActionResult> Index()
        {
            if (!EsAdministradorGlobal())
                return RedirectToAction("Index", "Login");

            try
            {
                var empresas = await GetAsync<List<Empresa>>(_apiUrl + "/empresas");
                var model = new AdminEmpresasViewModel
                {
                    Empresas = empresas,
                    DynamicData = CrearDatosLayout()
                };
                return View("~/Views/Administracion/Empresas/Index.cshtml", model);
            }
            catch (Exception)
            {
                return StatusCode(503, "No se pudieron cargar las empresas. Verifica que la API esté disponible.");
            }
        }

        [HttpGet("Administracion/Empresas/Sedes")]
        public async Task<IActionResult> Sedes(int idEmpresa)
        {
            if (!EsAdministradorGlobal())
                return Unauthorized();

            try
            {
                return Json(await GetAsync<List<Sede>>(_apiUrl + "/empresas/" + idEmpresa + "/sedes"));
            }
            catch (Exception)
            {
                return StatusCode(503, "No se pudieron cargar las sedes. Verifica que la API esté disponible.");
            }
        }

        [HttpPost("Administracion/Empresas/Crear")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Crear([FromBody] Empresa empresa)
        {
            if (!EsAdministradorGlobal())
                return Unauthorized();
            if (empresa == null || string.IsNullOrWhiteSpace(empresa.Nombre) || empresa.Nombre.Trim().Length > 200)
                return BadRequest("Ingresa un nombre de empresa de hasta 200 caracteres.");

            empresa.Nombre = empresa.Nombre.Trim();
            empresa.Estado = true;
            try
            {
                return Ok(await PostAsync<Empresa>(_apiUrl + "/empresas", empresa));
            }
            catch (Exception)
            {
                return StatusCode(503, "No se pudo crear la empresa. Verifica que la API esté disponible.");
            }
        }

        [HttpPost("Administracion/Empresas/CrearSede")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearSede([FromBody] Sede sede)
        {
            if (!EsAdministradorGlobal())
                return Unauthorized();
            if (sede == null || string.IsNullOrWhiteSpace(sede.Nombre) || sede.Nombre.Trim().Length > 200 || sede.IdEmpresa <= 0)
                return BadRequest("Selecciona una empresa e ingresa un nombre de sede válido.");
            if (!string.IsNullOrWhiteSpace(sede.Centro) && sede.Centro.Trim().Length > 100)
                return BadRequest("El centro debe tener como máximo 100 caracteres.");

            sede.Nombre = sede.Nombre.Trim();
            sede.Estado = true;
            try
            {
                return Ok(await PostAsync<Sede>(_apiUrl + "/sedes", sede));
            }
            catch (Exception)
            {
                return StatusCode(503, "No se pudo completar la operación. Verifica que la API esté disponible.");
            }
        }

        [HttpPost("Administracion/Empresas/CrearUsuario")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CrearUsuario([FromBody] UsuarioEmpresa usuario)
        {
            if (!EsAdministradorGlobal())
                return Unauthorized();
            if (usuario == null || string.IsNullOrWhiteSpace(usuario.Nombres)
                || string.IsNullOrWhiteSpace(usuario.Apellidos)
                || string.IsNullOrWhiteSpace(usuario.Usuario)
                || string.IsNullOrWhiteSpace(usuario.Password)
                || usuario.IdEmpresa <= 0 || usuario.IdSede <= 0
                || (usuario.IdTipoUsuario != 1 && usuario.IdTipoUsuario != 3))
                return BadRequest("Completa los datos y selecciona una empresa, sede y rol válidos.");

            try
            {
                using (var client = CrearClienteApi())
                {
                    var json = JsonConvert.SerializeObject(usuario);
                    var content = new System.Net.Http.StringContent(json, Encoding.UTF8, "application/json");
                    var response = await client.PostAsync(_apiUrl + "/usuarios", content);
                    var responseContent = await response.Content.ReadAsStringAsync();
                    if (!response.IsSuccessStatusCode)
                        return StatusCode((int)response.StatusCode, responseContent.Trim('"'));

                    return Content(responseContent, "application/json");
                }
            }
            catch (Exception)
            {
                return StatusCode(503, "No se pudo crear el usuario. Verifica que la API esté disponible.");
            }
        }

        private bool EsAdministradorGlobal()
        {
            return HttpContext.Session.GetInt32("id_usuario").HasValue
                && HttpContext.Session.GetInt32("id_tipousuario") == 20;
        }

        private dynamic CrearDatosLayout()
        {
            dynamic data = new ExpandoObject();
            data.path = $"{Request.Scheme}://{Request.Host}{Request.PathBase}";
            data.call_center = Helper.GetCallCenter();
            data.horario_atencion = Helper.GetHorario();
            data.whatsapp = Helper.GetWhatsapp();
            data.nombres = HttpContext.Session.GetString("nombres");
            data.apellidos = HttpContext.Session.GetString("apellidos");
            data.id_usuario = HttpContext.Session.GetInt32("id_usuario");
            data.id_tipousuario = HttpContext.Session.GetInt32("id_tipousuario");
            data.id_sede = 0;
            data.id_psicologo = HttpContext.Session.GetInt32("id_psicologo");
            data.tipo_documento = HttpContext.Session.GetString("tipo_documento");
            data.num_documento = HttpContext.Session.GetString("num_documento");
            data.vista = "EMPRESAS";
            data.call_center_invitado = Helper.GetCallCenterInvitado();
            return data;
        }

        private async Task<T> GetAsync<T>(string url)
        {
            using (var client = CrearClienteApi())
            {
                var response = await client.GetAsync(url);
                response.EnsureSuccessStatusCode();
                var json = await response.Content.ReadAsStringAsync();
                return JsonConvert.DeserializeObject<T>(json);
            }
        }

        private async Task<T> PostAsync<T>(string url, object value)
        {
            using (var client = CrearClienteApi())
            {
                var json = JsonConvert.SerializeObject(value);
                var response = await client.PostAsync(url, new System.Net.Http.StringContent(json, Encoding.UTF8, "application/json"));
                response.EnsureSuccessStatusCode();
                return JsonConvert.DeserializeObject<T>(await response.Content.ReadAsStringAsync());
            }
        }

        private System.Net.Http.HttpClient CrearClienteApi()
        {
            return new System.Net.Http.HttpClient();
        }
    }
}
