using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.site.Models;
using PsycoApp.utilities;

namespace PsycoApp.site.Controllers
{
    public class SaaSController : Controller
    {
        private readonly string urlApi;

        public SaaSController()
        {
            urlApi = PsycoApp.utilities.Helper.GetUrlApi();
        }

        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public IActionResult Registro()
        {
            return View(new RegistroSaasViewModel());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Registro(RegistroSaasViewModel modelo)
        {
            if (!ModelState.IsValid)
                return View(modelo);

            var payload = new
            {
                empresa = modelo.Empresa,
                sede = modelo.Sede,
                nombres = modelo.Nombres,
                apellidos = modelo.Apellidos,
                usuario = modelo.Usuario,
                password = modelo.Password
            };

            try
            {
                await ApiCaller.consume_endpoint_method_async(urlApi + "/api/EmpresaSede/registro-prueba", payload, "POST");

                return RedirectToAction(nameof(RegistroCompletado), new { usuario = modelo.Usuario.Trim().ToUpperInvariant() });
            }
            catch
            {
                ModelState.AddModelError(string.Empty, "No se pudo completar el registro. Revisa los datos e inténtalo de nuevo.");
                return View(modelo);
            }
        }

        [HttpGet]
        public IActionResult RegistroCompletado(string usuario)
        {
            ViewBag.Usuario = usuario;
            return View();
        }
    }
}
