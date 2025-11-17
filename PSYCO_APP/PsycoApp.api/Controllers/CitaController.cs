using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.BL;
using PsycoApp.DA;
using PsycoApp.entities;
using PsycoApp.utilities;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CitaController : ControllerBase
    {
        private readonly IWebHostEnvironment _host;
        private string main_path;

        public CitaController(IWebHostEnvironment host)
        {
            this._host = host;
            main_path = _host.ContentRootPath;
        }

        CitaBL citaBL = new CitaBL();
        HistorialBL historialBL = new HistorialBL();
        RandomUtilities ru = new RandomUtilities();

        string res = "";
        string random_str = "";

        // POST api/values
        [HttpPost("registrar_cita")]
        public RespuestaUsuario PostRegistrar([FromBody] Cita oCita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();
            try
            {
                res_ = citaBL.registrar_cita(oCita, main_path, random_str);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al registrar la cita";
                res_.estado = false;
            }
            return res_;
        }

        [HttpPost("informe_adicional")]
        public RespuestaUsuario RegistrarInforme([FromBody] Cita oCita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = citaBL.registrar_informe(oCita);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al registrar el informe";
                res_.estado = false;
            }
            return res_;
        }

        [HttpPost("actualizar_citas_paquete")]
        public RespuestaUsuario ActualizarCitasPaquete([FromBody] List<Subcita> lista)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = citaBL.actualizar_citas_paquete(lista);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al actualizar las citas";
                res_.estado = false;
            }
            return res_;
        }

        [HttpPost("confirmar_cita")]
        public RespuestaUsuario PostConfirmar([FromBody] Cita oCita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();
            try
            {
                res_ = citaBL.confirmar_cita(oCita, main_path, random_str);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al confirmar la cita";
                res_.estado = false;
            }
            return res_;
        }

        [HttpPost("atender_cita")]
        public RespuestaUsuario PostAtender([FromBody] Cita oCita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();
            try
            {
                res_ = citaBL.atender_cita(oCita, main_path, random_str);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al atender la cita";
                res_.estado = false;
            }
            return res_;
        }

        [HttpPost("cancelar_cita")]
        public RespuestaUsuario PostCancelar([FromBody] Cita oCita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();
            try
            {
                res_ = citaBL.cancelar_cita(oCita, main_path, random_str);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al cancelar la cita";
                res_.estado = false;
            }
            return res_;
        }

        [HttpGet("actualizar_servicio/{id_cita}/{id_servicio}")]
        public RespuestaUsuario ActualizarServicio(int id_cita, int id_servicio)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = citaBL.actualizar_servicio(id_cita, id_servicio);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al actualizar el servicio.";
                res_.estado = false;
            }
            return res_;
        }

        [HttpGet("pago_gratuito/{id_cita}")]
        public RespuestaUsuario PagoGratuito(int id_cita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            try
            {
                res_ = citaBL.pago_gratuito(id_cita);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al registrar el pago gratuito.";
                res_.estado = false;
            }
            return res_;
        }

        [HttpPost("registrar_cuestionario")]
        public RespuestaUsuario Post2([FromBody] Cita oCita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                res_ = citaBL.registrar_cuestionario(oCita, main_path, random_str);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al registrar la cita";
                res_.estado = false;
            }
            return res_;
        }

        [HttpGet("disponibilidad_doctor/{id_doctor}/{fecha}")]
        public async Task<List<Cita>> disponibilidad_doctor(int id_doctor, string fecha)
        {
            List<Cita> lista = new List<Cita>();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = await citaBL.disponibilidad_doctor(id_doctor, fecha, main_path, random_str);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("citas_usuario/{id_usuario}/{id_paciente}/{id_doctor}/{id_sede}")]
        public List<Cita> citas_usuario(int id_usuario, int id_paciente, int id_doctor, int id_sede)
        {
            List<Cita> lista = new List<Cita>();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                lista = citaBL.citas_usuario(id_usuario, id_paciente, id_doctor, id_sede, main_path, random_str);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("citas_por_paquete/{id_paquete}")]
        public List<Cita> citas_por_paquete(int id_paquete)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                lista = citaBL.citas_por_paquete(id_paquete);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("historial/{id_cita}/{id_paciente}")]
        public async Task<Historial> historial(int id_cita, int id_paciente)
        {
            Historial historial = new Historial();
            historial.historial1 = new List<HistorialCita>();
            historial.historial2 = new List<HistorialPaciente>();

            try
            {
                historial.historial1 = await citaBL.historial_cita(id_cita);
                historial.historial2 = await citaBL.historial_paciente(id_paciente);
            }
            catch (Exception)
            {
                historial = new Historial();
            }
            return historial;
        }

        [HttpGet("horarios_doctor/{inicio}/{fin}/{id_doctor}")]
        public List<Cita> horarios_doctor(string inicio, string fin, int id_doctor)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                lista = citaBL.horarios_doctor(inicio, fin, id_doctor);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("citas_doctor/{usuario}/{inicio}/{fin}/{id_estado}/{id_doctor}/{ver_sin_reserva}")]
        public List<Cita> citas_doctor(string usuario, string inicio, string fin, int id_estado, int id_doctor, int ver_sin_reserva)
        {
            List<Cita> lista = new List<Cita>();
            try
            {
                lista = citaBL.citas_doctor(usuario, inicio, fin, id_estado, id_doctor, ver_sin_reserva);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("historial_usuario/{id_usuario}")]
        public List<HistorialPaciente> historial_usuario(int id_usuario)
        {
            List<HistorialPaciente> lista = new List<HistorialPaciente>();
            try
            {
                lista = historialBL.listar_historial(id_usuario);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpPost("registrar_historial")]
        public RespuestaUsuario RegistrarHistorial([FromBody] HistorialPaciente oHistorial)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                res_ = historialBL.registrar_historial(oHistorial);
            }
            catch (Exception)
            {
                res_.descripcion = "Ocurrió un error al registrar la información.";
                res_.estado = false;
            }
            return res_;
        }

        [HttpGet("dias_x_semana_mes/{semana}/{mes}/{año}")]
        public List<entities.Semana> dias_x_semana_mes(int semana, int mes, int año)
        {
            List<entities.Semana> res_ = new List<entities.Semana>();
            random_str = ru.RandomString(8) + "|" + ru.CurrentDate();

            try
            {
                res_ = citaBL.dias_x_semana_mes(semana, mes, año);
            }
            catch (Exception)
            {
                res_.Clear();
            }
            return res_;
        }

    }
}
