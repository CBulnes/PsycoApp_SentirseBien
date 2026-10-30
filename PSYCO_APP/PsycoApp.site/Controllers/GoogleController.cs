using System;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using PsycoApp.entities;
using PsycoApp.site.Models;
using PsycoApp.utilities;

namespace PsycoApp.site.Controllers
{
    public class GoogleController : Controller
    {
        private readonly IConfiguration configuration;
        public GoogleController(IConfiguration configuration) { this.configuration = configuration; }
        private bool Enabled => configuration.GetValue<bool>("Authentication:Google:Enabled") &&
            !string.IsNullOrWhiteSpace(configuration["Authentication:Google:ClientId"]);

        // Obtain a short-lived nonce before starting the Google popup.
        [HttpPost, ValidateAntiForgeryToken]
        public IActionResult ChallengeNonce()
        {
            if (!Enabled) return StatusCode(503);
            var nonce = Convert.ToHexString(RandomNumberGenerator.GetBytes(32));
            HttpContext.Session.SetString("google_nonce", nonce);
            HttpContext.Session.SetString("google_nonce_time", DateTimeOffset.UtcNow.ToUnixTimeSeconds().ToString());
            return Json(new { nonce });
        }

        [HttpPost, ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(string credential, bool link = false)
        {
            if (!Enabled) return StatusCode(503);
            // Nonce is only a request correlation check here. The API verifies signature,
            // issuer, audience, expiration and verified email before using any identity.
            if (!ConsumeNonce(credential)) return BadRequest("La solicitud caducÃ³. Vuelve a intentarlo.");
            if (link && !HttpContext.Session.GetInt32("id_usuario").HasValue) return Unauthorized();
            try
            {
                using var response = await Send(link ? "link" : "login", new GoogleCredential { Credential = credential });
                if (!response.IsSuccessStatusCode) return StatusCode((int)response.StatusCode, "No se pudo completar el acceso con Google.");
                if (link)
                {
                    TempData["GoogleLinked"] = true;
                    return Json(new { redirect = "/Google/Vincular" });
                }
                var result = JsonConvert.DeserializeObject<GoogleAccessResult>(await response.Content.ReadAsStringAsync());
                if (result.NeedsRegistration)
                {
                    HttpContext.Session.SetString("google_pending", credential);
                    HttpContext.Session.SetString("google_pending_time", DateTimeOffset.UtcNow.ToUnixTimeSeconds().ToString());
                    return Json(new { redirect = "/Google/Registro" });
                }
                SignIn(result);
                return Json(new { redirect = "/Home" });
            }
            catch (HttpRequestException) { return StatusCode(503, "No se pudo conectar con el servicio de acceso."); }
        }

        [HttpGet]
        public IActionResult Registro()
        {
            if (!Enabled || Pending() == null) return RedirectToAction("Index", "Login");
            return View(new GoogleRegistrationViewModel());
        }

        [HttpPost, ValidateAntiForgeryToken]
        public async Task<IActionResult> Registro(GoogleRegistrationViewModel model)
        {
            var credential = Pending();
            if (!Enabled || credential == null) return RedirectToAction("Index", "Login");
            if (!ModelState.IsValid) return View(model);
            try
            {
                using var response = await Send("register", new GoogleRegistration
                {
                    Credential = credential, Empresa = model.Empresa, Sede = model.Sede,
                    Nombres = model.Nombres, Apellidos = model.Apellidos
                });
                if (response.IsSuccessStatusCode)
                {
                    var result = JsonConvert.DeserializeObject<GoogleAccessResult>(await response.Content.ReadAsStringAsync());
                    SignIn(result);
                    HttpContext.Session.Remove("google_pending");
                    HttpContext.Session.Remove("google_pending_time");
                    return RedirectToAction("Index", "Home");
                }
                ModelState.AddModelError("", "No se pudo crear tu espacio. Si ya tienes una cuenta, ingresa normalmente y vincula Google.");
            }
            catch (HttpRequestException) { ModelState.AddModelError("", "No se pudo conectar. IntÃ©ntalo nuevamente."); }
            return View(model);
        }

        [HttpGet]
        public IActionResult Vincular()
        {
            if (!HttpContext.Session.GetInt32("id_usuario").HasValue) return RedirectToAction("Index", "Login");
            ViewBag.Completado = TempData["GoogleLinked"] is bool completed && completed;
            return View();
        }

        private string Pending() => Fresh("google_pending_time") ? HttpContext.Session.GetString("google_pending") : null;
        private bool Fresh(string key) => long.TryParse(HttpContext.Session.GetString(key), out var time) &&
            DateTimeOffset.UtcNow.ToUnixTimeSeconds() - time is >= 0 and <= 300;

        private bool ConsumeNonce(string credential)
        {
            var expected = HttpContext.Session.GetString("google_nonce");
            var fresh = Fresh("google_nonce_time");
            HttpContext.Session.Remove("google_nonce");
            HttpContext.Session.Remove("google_nonce_time");
            if (!fresh || string.IsNullOrEmpty(expected) || string.IsNullOrEmpty(credential) || credential.Length > 12000) return false;
            try
            {
                var parts = credential.Split('.');
                if (parts.Length != 3) return false;
                var encoded = parts[1].Replace('-', '+').Replace('_', '/');
                encoded = encoded.PadRight((encoded.Length + 3) / 4 * 4, '=');
                var payload = Newtonsoft.Json.Linq.JObject.Parse(Encoding.UTF8.GetString(Convert.FromBase64String(encoded)));
                return payload["nonce"]?.Type == Newtonsoft.Json.Linq.JTokenType.String && payload.Value<string>("nonce") == expected;
            }
            catch (Exception ex) when (ex is FormatException || ex is JsonException) { return false; }
        }

        private async Task<HttpResponseMessage> Send(string action, object payload)
        {
            using var client = ApiCaller.CreateHttpClient();
            using var content = new StringContent(JsonConvert.SerializeObject(payload), Encoding.UTF8, "application/json");
            return await client.PostAsync(Helper.GetUrlApi().TrimEnd('/') + "/api/google/" + action, content);
        }

        private void SignIn(GoogleAccessResult result)
        {
            var u = result.User;
            if (u == null || string.IsNullOrWhiteSpace(result.Token) || u.id_empresa <= 0 || u.id_sede <= 0)
                throw new InvalidOperationException("Respuesta de acceso incompleta.");
            HttpContext.Session.Clear();
            HttpContext.Session.SetString("jwt", result.Token);
            HttpContext.Session.SetString("email", u.email ?? "");
            HttpContext.Session.SetString("login", u.login ?? "");
            HttpContext.Session.SetInt32("id_usuario", u.id_usuario);
            HttpContext.Session.SetInt32("id_empresa", u.id_empresa);
            HttpContext.Session.SetInt32("id_sede", u.id_sede);
            HttpContext.Session.SetString("nombre_sede", result.Sede ?? "");
            HttpContext.Session.SetString("nombres", u.nombres ?? "");
            HttpContext.Session.SetString("apellidos", u.apellidos ?? "");
            HttpContext.Session.SetInt32("id_tipousuario", u.id_tipousuario);
            HttpContext.Session.SetString("tipousuario", u.tipousuario ?? "");
            HttpContext.Session.SetInt32("id_psicologo", u.id_psicologo);
            HttpContext.Session.SetString("tipo_documento", u.tipo_documento ?? "");
            HttpContext.Session.SetString("num_documento", u.num_documento ?? "");
            HttpContext.Session.SetInt32("test_actual", u.test_actual);
            HttpContext.Session.SetInt32("flag_chat", 1);
        }
    }
}
