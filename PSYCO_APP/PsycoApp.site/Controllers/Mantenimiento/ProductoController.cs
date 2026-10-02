using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.site.Models;
using PsycoApp.utilities;

namespace PsycoApp.site.Controllers.Mantenimiento
{
    public class ProductoController : Controller
    {
        private readonly string apiUrl = Helper.GetUrlApi() + "/api/producto";

        [Route("Mantenimiento/Producto")]
        public async Task<IActionResult> Index()
        {
            var idTipoUsuario = HttpContext.Session.GetInt32("id_tipousuario");
            var idEmpresa = HttpContext.Session.GetInt32("id_empresa");
            if (string.IsNullOrEmpty(HttpContext.Session.GetString("nombres")))
                return RedirectToAction("Index", "Login");
            if (idTipoUsuario != 1 || !idEmpresa.HasValue || idEmpresa.Value <= 0)
                return Forbid();

            using var client = new HttpClient();
            var json = await client.GetStringAsync($"{apiUrl}/empresa/{idEmpresa.Value}/listar");
            var productos = JsonConvert.DeserializeObject<List<PsycoApp.entities.Producto>>(json) ?? new List<PsycoApp.entities.Producto>();
            dynamic dynamicData = new System.Dynamic.ExpandoObject();
            dynamicData.nombres = HttpContext.Session.GetString("nombres");
            dynamicData.apellidos = HttpContext.Session.GetString("apellidos");
            dynamicData.id_tipousuario = idTipoUsuario;
            dynamicData.id_usuario = HttpContext.Session.GetInt32("id_usuario");
            dynamicData.id_sede = HttpContext.Session.GetInt32("id_sede");
            dynamicData.id_psicologo = HttpContext.Session.GetInt32("id_psicologo");
            dynamicData.tipo_documento = HttpContext.Session.GetString("tipo_documento");
            dynamicData.num_documento = HttpContext.Session.GetString("num_documento");
            dynamicData.path = $"{Request.Scheme}://{Request.Host}{Request.PathBase}";
            dynamicData.call_center = Helper.GetCallCenter();
            dynamicData.whatsapp = Helper.GetWhatsapp();
            dynamicData.vista = "MANTENIMIENTO";
            dynamicData.call_center_invitado = Helper.GetCallCenterInvitado();
            return View("~/Views/Mantenimiento/Producto/Index.cshtml", new ProductosMantenimientoViewModel { Productos = productos, DynamicData = dynamicData });
        }

        [HttpPost]
        [Route("Mantenimiento/Producto/Guardar")]
        public async Task<IActionResult> Guardar([FromBody] PsycoApp.entities.Producto producto)
        {
            var idTipoUsuario = HttpContext.Session.GetInt32("id_tipousuario");
            var idEmpresa = HttpContext.Session.GetInt32("id_empresa");
            if (idTipoUsuario != 1 || !idEmpresa.HasValue || idEmpresa.Value <= 0)
                return Forbid();
            if (producto == null) return BadRequest("Producto inválido.");

            using var client = new HttpClient();
            var content = new StringContent(JsonConvert.SerializeObject(producto), Encoding.UTF8, "application/json");
            var response = await client.PostAsync($"{apiUrl}/empresa/{idEmpresa.Value}/guardar", content);
            var body = await response.Content.ReadAsStringAsync();
            return StatusCode((int)response.StatusCode, body);
        }

        [HttpPost]
        [Route("Mantenimiento/Producto/Eliminar/{id}")]
        public async Task<IActionResult> Eliminar(int id)
        {
            var idTipoUsuario = HttpContext.Session.GetInt32("id_tipousuario");
            var idEmpresa = HttpContext.Session.GetInt32("id_empresa");
            if (idTipoUsuario != 1 || !idEmpresa.HasValue || idEmpresa.Value <= 0)
                return Forbid();

            using var client = new HttpClient();
            var response = await client.PostAsync($"{apiUrl}/empresa/{idEmpresa.Value}/eliminar/{id}", null);
            var body = await response.Content.ReadAsStringAsync();
            return StatusCode((int)response.StatusCode, body);
        }
    }
}
