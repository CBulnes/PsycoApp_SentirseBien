using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.site.Models;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.entities;
using PsycoApp.utilities;
using Microsoft.AspNetCore.Http;
using System.Net.Http;
using System.Security.Policy;

namespace PsycoApp.site.Controllers.Mantenimiento
{
    public class PsicologoController : Controller
    {
        private readonly string apiUrl = Helper.GetUrlApi() + "/api/psicologo";
        private readonly string apiUrlUbigeo = Helper.GetUrlApi() + "/api/ubigeo";
        private string url_horarios_psicologo = Helper.GetUrlApi() + "/api/psicologo/horarios_psicologo";
        private string url_vacaciones_psicologo = Helper.GetUrlApi() + "/api/psicologo/vacaciones_psicologo";
        private string url_guardar_horarios_psicologo = Helper.GetUrlApi() + "/api/psicologo/guardar_horarios_psicologo";
        private string url_guardar_vacaciones_psicologo = Helper.GetUrlApi() + "/api/psicologo/guardar_vacaciones_psicologo";

        [Route("Mantenimiento/Psicologo")]
        public async Task<IActionResult> Index(int pageNumber = 1, int pageSize = 100)
        {
            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("nombres") as string))
            {
                string url = $"{apiUrl}/listar/{pageNumber}/{pageSize}";
                var psicologos = await GetFromApiAsync<List<PsycoApp.entities.Psicologo>>(url);
                var psicologosViewModel = psicologos.Select(p => new PsycoApp.site.Models.Psicologo
                {
                    Id = p.Id,
                    Nombre = p.Nombre,
                    Apellido = p.Apellido,
                    DocumentoNumero = p.DocumentoNumero,
                    Estado = p.Estado,
                    DocumentoTipo = p.DocumentoTipo,
                    Especialidad = p.Especialidad,
                    FechaNacimiento = p.FechaNacimiento,
                    Direccion = p.Direccion,
                    Distrito = p.Distrito,
                    Telefono = p.Telefono,
                    Refrigerio = p.Refrigerio,
                    Sedes = p.Sedes
                    //Estudios = p.Estudios.Select(q => new PsycoApp.site.Models.Estudio
                    //{
                    //    Id = q.Id,
                    //    IdPsicologo = q.IdPsicologo,
                    //    GradoAcademico = q.GradoAcademico,
                    //    Institucion = q.Institucion,
                    //    Carrera = q.Carrera
                    //}).ToList()
                }).ToList();

                url = $"{apiUrlUbigeo}/listar";
                var ubigeos = await GetFromApiAsync<List<PsycoApp.entities.Ubigeo>>(url);
                var ubigeosViewModel = ubigeos.Select(p => new PsycoApp.site.Models.Ubigeo
                {
                    Id = p.Id,
                    CodUbigeo = p.CodUbigeo,
                    Departamento = p.Departamento,
                    Provincia = p.Provincia,
                    Distrito = p.Distrito
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
                obj.id_sede = HttpContext.Session.GetInt32("id_sede");
                obj.id_psicologo = HttpContext.Session.GetInt32("id_psicologo");
                obj.tipo_documento = HttpContext.Session.GetString("tipo_documento");
                obj.num_documento = HttpContext.Session.GetString("num_documento");
                obj.vista = "PSICOLOGO";

                obj.ubigeos = ubigeosViewModel;
                if (obj.id_sede == 1) //La molina
                {
                    psicologos = psicologos.Where(x => x.IdSedePrincipal == 1 || x.IdSedeSecundaria == 1 || x.IdSedeSecundaria2 == 1).ToList();
                }
                else if (obj.id_sede == 2) //Surco
                {
                    psicologos = psicologos.Where(x => x.IdSedePrincipal == 2 || x.IdSedeSecundaria == 2 || x.IdSedeSecundaria2 == 2).ToList();
                }
                else if (obj.id_sede == 3) //Miraflores
                {
                    psicologos = psicologos.Where(x => x.IdSedePrincipal == 3 || x.IdSedeSecundaria == 3 || x.IdSedeSecundaria2 == 3).ToList();
                }
                psicologosViewModel = psicologos.Select(p => new PsycoApp.site.Models.Psicologo
                {
                    Id = p.Id,
                    Nombre = p.Nombre,
                    Apellido = p.Apellido,
                    DocumentoNumero = p.DocumentoNumero,
                    Estado = p.Estado,
                    DocumentoTipo = p.DocumentoTipo,
                    Especialidad = p.Especialidad,
                    FechaNacimiento = p.FechaNacimiento,
                    Direccion = p.Direccion,
                    Distrito = p.Distrito,
                    Telefono = p.Telefono,
                    Refrigerio = p.Refrigerio,
                    Sedes = p.Sedes
                    //Estudios = p.Estudios.Select(q => new PsycoApp.site.Models.Estudio
                    //{
                    //    Id = q.Id,
                    //    IdPsicologo = q.IdPsicologo,
                    //    GradoAcademico = q.GradoAcademico,
                    //    Institucion = q.Institucion,
                    //    Carrera = q.Carrera
                    //}).ToList()
                }).ToList();
                var viewModelContainer = new ViewModelContainer<IEnumerable<PsycoApp.site.Models.Psicologo>>
                {
                    Model = psicologosViewModel,
                    DynamicData = obj
                };

                ViewBag.PageNumber = pageNumber;
                ViewBag.PageSize = pageSize;

                if (obj.id_tipousuario == 1 || obj.id_tipousuario == 3) //admin
                {
                    return View("~/Views/Mantenimiento/Psicologo/Index.cshtml", viewModelContainer);
                }
                else //cliente
                {
                    return RedirectToAction("Index", "Home");
                }
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
        }


        [Route("/Mantenimiento/Psicologo/Buscar")]
        [HttpPost]
        public async Task<IActionResult> Buscar(string nombre, int sede = -1)
        {
            string url = $"{apiUrl}/buscar?nombre={nombre}";
            var psicologos = await GetFromApiAsync<List<entities.Psicologo>>(url);
            if (sede == 1) //La molina
            {
                psicologos = psicologos.Where(x => x.IdSedePrincipal == 1 || x.IdSedeSecundaria == 1 || x.IdSedeSecundaria2 == 1).ToList();
            } else if (sede == 2) //Surco
            {
                psicologos = psicologos.Where(x => x.IdSedePrincipal == 2 || x.IdSedeSecundaria == 2 || x.IdSedeSecundaria2 == 2).ToList();
            }
            else if (sede == 3) //Miraflores
            {
                psicologos = psicologos.Where(x => x.IdSedePrincipal == 3 || x.IdSedeSecundaria == 3 || x.IdSedeSecundaria2 == 3).ToList();
            }
            
            return Json(psicologos);
        }

        [Route("Mantenimiento/Psicologo/Agregar")]
        [HttpPost]
        public async Task<IActionResult> Agregar([FromBody] Models.Psicologo psicologo)
        {
            if (ModelState.IsValid)
            {
                string url = $"{apiUrl}/agregar";
                var response = await PostToApiAsync(url, psicologo);
                if (response.IsSuccessStatusCode)
                {
                    return Ok(new { message = "Psicólogo guardado correctamente" });
                }
                return StatusCode((int)response.StatusCode, "Error al agregar psicólogo.");
            }
            return BadRequest("Modelo no válido.");
        }

        [Route("/Mantenimiento/Psicologo/Editar")]
        [HttpPost]
        public async Task<IActionResult> Editar([FromBody] entities.Psicologo psicologo)
        {
            if (ModelState.IsValid)
            {
                string url = $"{apiUrl}/actualizar";
                var response = await PutToApiAsync(url, psicologo);
                if (response.IsSuccessStatusCode)
                {
                    return Ok(new { message = "Psicólogo editado correctamente" });
                }
                return StatusCode((int)response.StatusCode, "Error al editar psicólogo.");
            }
            return BadRequest("Modelo no válido.");
        }

        [Route("/Mantenimiento/Psicologo/Eliminar")]
        [HttpPost]
        public async Task<IActionResult> Eliminar(int id, string estado)
        {
            string url = $"{apiUrl}/eliminar/{id}";
            var response = await DeleteFromApiAsync(url);
            if (response.IsSuccessStatusCode)
            {
                return Ok(new { message = "Psicólogo " + (estado == "1" ? "deshabilitado" : "habilitado") + " correctamente" });
            }
            return StatusCode((int)response.StatusCode, "Error al " + (estado == "1" ? "deshabilitar" : "habilitar") + " psicólogo.");
        }

        [Route("/Mantenimiento/Psicologo/Get/{id}")]
        [HttpGet]
        public async Task<IActionResult> GetPsicologo(int id)
        {
            try
            {
                string url = $"{apiUrl}/BuscarId/{id}";
                var psicologo = await GetFromApiAsync<PsycoApp.entities.Psicologo>(url);

                if (psicologo == null)
                {
                    return NotFound("Psicólogo no encontrado.");
                }

                return Json(psicologo);
            }
            catch (Exception ex)
            {
                return BadRequest($"Error al obtener el psicólogo: {ex.Message}");
            }
        }

        private async Task<T> GetFromApiAsync<T>(string url)
        {
            using var client = new HttpClient();
            var response = await client.GetStringAsync(url);
            return JsonConvert.DeserializeObject<T>(response);
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

        [Route("/Mantenimiento/Psicologo/horarios_psicologo/{id}/{inicio}/{fin}/{dias}")]
        [HttpGet]
        public ActionResult<List<entities.Horario>> horarios_psicologo(int id, string inicio, string fin, string dias)
        {
            List<entities.Horario> lista = new List<entities.Horario>();
            string res = "";
            try
            {
                string url = url_horarios_psicologo + "/" + id + "/" + inicio + "/" + fin + "/" + dias;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.Horario>>(res);
            }
            catch (Exception ex)
            {
             
                lista.Clear();
            }
            return lista;
        }

        [Route("/Mantenimiento/Psicologo/vacaciones_psicologo/{id}/{inicio}/{fin}/{año}")]
        [HttpGet]
        public ActionResult<List<entities.Horario>> vacaciones_psicologo(int id, string inicio, string fin, int año)
        {
            List<entities.Horario> lista = new List<entities.Horario>();
            string res = "";
            try
            {
                string url = url_vacaciones_psicologo + "/" + id + "/" + inicio + "/" + fin + "/" + año;
                res = ApiCaller.consume_endpoint_method(url, null, "GET");
                lista = JsonConvert.DeserializeObject<List<entities.Horario>>(res);
            }
            catch (Exception ex)
            {
             
                lista.Clear();
            }
            return lista;
        }

        [Route("/Mantenimiento/Psicologo/GuardarHorarios")]
        [HttpPost]
        public ActionResult<RespuestaUsuario> GuardarHorarios([FromBody] List<entities.Horario> lista)
        {
            var res = new RespuestaUsuario();
            string restring = "";
            try
            {
                string url = url_guardar_horarios_psicologo;
                restring = ApiCaller.consume_endpoint_method(url, lista, "POST");
                res = JsonConvert.DeserializeObject<RespuestaUsuario>(restring);
            }
            catch (Exception ex)
            {
                res.estado = false;
                res.descripcion = "Ocurrió un error al guardar los horarios.";
            }
            return res;
        }

        [Route("/Mantenimiento/Psicologo/GuardarVacaciones")]
        [HttpPost]
        public ActionResult<RespuestaUsuario> GuardarVacaciones([FromBody] List<entities.Horario> lista)
        {
            var res = new RespuestaUsuario();
            string restring = "";
            try
            {
                string url = url_guardar_vacaciones_psicologo;
                restring = ApiCaller.consume_endpoint_method(url, lista, "POST");
                res = JsonConvert.DeserializeObject<RespuestaUsuario>(restring);
            }
            catch (Exception ex)
            {
                res.estado = false;
                res.descripcion = "Ocurrió un error al guardar las vacaciones.";
            }
            return res;
        }

    }
}
