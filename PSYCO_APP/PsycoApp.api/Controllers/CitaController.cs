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
using PsycoApp.api.Security;

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
        EmpresaSedeBL empresaSedeBL = new EmpresaSedeBL();
        RandomUtilities ru = new RandomUtilities();

        string res = "";
        string random_str = "";

        private bool TryGetTenantSede(out int idSede)
        {
            if (TenantContext.IsGlobalAdministrator(User))
            {
                idSede = 0;
                return true;
            }

            return TenantContext.TryGetIntClaim(User, "id_sede", out idSede) && idSede > 0;
        }

        private bool CanUseSede(int requestedSede, int tenantSede)
        {
            return TenantContext.IsGlobalAdministrator(User) || requestedSede <= 0 || requestedSede == tenantSede;
        }

        private bool CitaAccesible(int idCita, int idSede)
        {
            return TenantContext.IsGlobalAdministrator(User) || (idCita > 0 && citaBL.CitaPerteneceASede(idCita, idSede));
        }

        private bool PaqueteAccesible(int idPaquete, int idSede)
        {
            return TenantContext.IsGlobalAdministrator(User) || (idPaquete > 0 && citaBL.PaquetePerteneceASede(idPaquete, idSede));
        }

        private bool PacienteYDoctorAccesibles(int idPaciente, int idDoctor, int idSede)
        {
            return citaBL.PacientePerteneceASede(idPaciente, idSede) && citaBL.DoctorPerteneceASede(idDoctor, idSede);
        }

        private bool DoctorPerteneceASede(int idDoctor, int idSede)
        {
            return idSede <= 0 || citaBL.DoctorPerteneceASede(idDoctor, idSede);
        }

        // POST api/values
        [HttpPost("registrar_cita")]
        public RespuestaUsuario PostRegistrar([FromBody] Cita oCita)
        {
            RespuestaUsuario res_ = new RespuestaUsuario();
            if (oCita == null || !TryGetTenantSede(out var tenantSede) || !CanUseSede(oCita.id_sede, tenantSede))
            {
                res_.descripcion = "La sede de la cita no está autorizada.";
                res_.estado = false;
                return res_;
            }
            var empresaActiva = TenantContext.IsGlobalAdministrator(User) ||
                (TenantContext.TryGetIntClaim(User, "id_empresa", out var empresa) && empresaSedeBL.SedePerteneceEmpresaActiva(oCita.id_sede, empresa));
            if (oCita.id_sede <= 0 || !citaBL.SedeActiva(oCita.id_sede) || !empresaActiva)
            {
                res_.descripcion = "La sede de la cita no es válida.";
                res_.estado = false;
                return res_;
            }
            if (oCita.id_cita > 0 && !TenantContext.IsGlobalAdministrator(User) && !CitaAccesible(oCita.id_cita, tenantSede))
            {
                res_.descripcion = "El borrador no pertenece a la sede autorizada.";
                res_.estado = false;
                return res_;
            }
            if (!TenantContext.IsGlobalAdministrator(User))
                oCita.id_sede = tenantSede;
            var primerDoctor = 0;
            if (oCita.fechas_adicionales != null && oCita.fechas_adicionales.Count > 0 &&
                (oCita.fechas_adicionales[0] == null || !int.TryParse(oCita.fechas_adicionales[0].especialista, out primerDoctor)))
            {
                res_.descripcion = "El profesional asignado no es válido.";
                res_.estado = false;
                return res_;
            }
            else if (oCita.fechas_adicionales != null && oCita.fechas_adicionales.Count > 0)
            {
                oCita.id_doctor_asignado = primerDoctor;
            }
            if (!PacienteYDoctorAccesibles(oCita.id_paciente, oCita.id_doctor_asignado, oCita.id_sede) ||
                (oCita.fechas_adicionales != null && oCita.fechas_adicionales.Any(f => !int.TryParse(f.especialista, out var doctor) || !citaBL.DoctorPerteneceASede(doctor, oCita.id_sede))) ||
                (!TenantContext.IsGlobalAdministrator(User) && oCita.id_paquete.GetValueOrDefault() > 0 && !PaqueteAccesible(oCita.id_paquete.Value, oCita.id_sede)))
            {
                res_.descripcion = "El paciente o el profesional no pertenece a la sede autorizada.";
                res_.estado = false;
                return res_;
            }

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
            if (oCita == null || !TryGetTenantSede(out var sede) || !CitaAccesible(oCita.id_cita, sede))
                return new RespuestaUsuario { estado = false, descripcion = "La cita no pertenece a la sede autorizada." };
            if (!TenantContext.IsGlobalAdministrator(User) && oCita.id_paquete.GetValueOrDefault() > 0 && !PaqueteAccesible(oCita.id_paquete.Value, sede))
                return new RespuestaUsuario { estado = false, descripcion = "El paquete no pertenece a la sede autorizada." };
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
            if (lista == null || !TryGetTenantSede(out var sede) || (!TenantContext.IsGlobalAdministrator(User) && lista.Any(c => !int.TryParse(Convert.ToString(c.id_cita), out var id) || !CitaAccesible(id, sede))))
                return new RespuestaUsuario { estado = false, descripcion = "Una o más citas no pertenecen a la sede autorizada." };
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
            if (oCita == null || !TryGetTenantSede(out var sede) || !CitaAccesible(oCita.id_cita, sede))
                return new RespuestaUsuario { estado = false, descripcion = "La cita no pertenece a la sede autorizada." };
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
            if (oCita == null || !TryGetTenantSede(out var sede) || !CitaAccesible(oCita.id_cita, sede))
                return new RespuestaUsuario { estado = false, descripcion = "La cita no pertenece a la sede autorizada." };
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
            if (oCita == null || !TryGetTenantSede(out var sede) || !CitaAccesible(oCita.id_cita, sede))
                return new RespuestaUsuario { estado = false, descripcion = "La cita no pertenece a la sede autorizada." };
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
            if (!TryGetTenantSede(out var sede) || !CitaAccesible(id_cita, sede))
                return new RespuestaUsuario { estado = false, descripcion = "La cita no pertenece a la sede autorizada." };
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
            if (!TryGetTenantSede(out var sede) || !CitaAccesible(id_cita, sede))
                return new RespuestaUsuario { estado = false, descripcion = "La cita no pertenece a la sede autorizada." };
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
            if (oCita == null || !TryGetTenantSede(out var sede) || !DoctorPerteneceASede(oCita.id_doctor_asignado, sede) ||
                !TenantContext.IsGlobalAdministrator(User) &&
                (!TenantContext.TryGetIntClaim(User, System.Security.Claims.ClaimTypes.NameIdentifier, out var usuarioClaim) || usuarioClaim != oCita.id_usuario))
                return new RespuestaUsuario { estado = false, descripcion = "El usuario o profesional no pertenece a la sede autorizada." };
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

        [HttpGet("disponibilidad_doctor/{id_doctor}/{fecha}/{servicio}")]
        public async Task<List<Cita>> disponibilidad_doctor(int id_doctor, string fecha, int servicio)
        {
            List<Cita> lista = new List<Cita>();
            if (!TryGetTenantSede(out var sede) || !DoctorPerteneceASede(id_doctor, sede))
                return lista;
            try
            {
                lista = await citaBL.disponibilidad_doctor(id_doctor, fecha, servicio);
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
            if (!TryGetTenantSede(out var sede) || !CanUseSede(id_sede, sede))
                return lista;
            if (!TenantContext.IsGlobalAdministrator(User))
            {
                if (!TenantContext.TryGetIntClaim(User, System.Security.Claims.ClaimTypes.NameIdentifier, out var usuarioClaim) || usuarioClaim != id_usuario)
                    return lista;
                id_sede = sede;
                if (id_paciente > 0 && !citaBL.PacientePerteneceASede(id_paciente, sede))
                    return lista;
                if (id_doctor > 0 && !citaBL.DoctorPerteneceASede(id_doctor, sede))
                    return lista;
            }
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
        public async Task<List<Cita>> citas_por_paquete(int id_paquete)
        {
            List<Cita> lista = new List<Cita>();
            if (!TryGetTenantSede(out var sede) || !PaqueteAccesible(id_paquete, sede))
                return lista;
            try
            {
                lista = await citaBL.citas_por_paquete(id_paquete);
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
            if (!TryGetTenantSede(out var sede) || !CitaAccesible(id_cita, sede) ||
                !TenantContext.IsGlobalAdministrator(User) && !citaBL.PacientePerteneceASede(id_paciente, sede))
                return historial;

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
            if (!TryGetTenantSede(out var sede) || !DoctorPerteneceASede(id_doctor, sede))
                return lista;
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

        [HttpGet("citas_doctor/{usuario}/{inicio}/{fin}/{id_estado}/{id_doctor}/{ver_sin_reserva}/{sede}/{idPaciente}")]
        public List<Cita> citas_doctor(string usuario, string inicio, string fin, int id_estado, int id_doctor, int ver_sin_reserva, int sede, int idPaciente)
        {
            List<Cita> lista = new List<Cita>();
            if (!TryGetTenantSede(out var sedeClaim) || !CanUseSede(sede, sedeClaim))
                return lista;
            if (!TenantContext.IsGlobalAdministrator(User))
            {
                sede = sedeClaim;
                if (id_doctor > 0 && !citaBL.DoctorPerteneceASede(id_doctor, sedeClaim) ||
                    idPaciente > 0 && !citaBL.PacientePerteneceASede(idPaciente, sedeClaim))
                    return lista;
            }
            try
            {
                lista = citaBL.citas_doctor(usuario, inicio, fin, id_estado, id_doctor, ver_sin_reserva, sede, idPaciente);
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
            if (!TryGetTenantSede(out var sede) || !TenantContext.IsGlobalAdministrator(User) &&
                (!TenantContext.TryGetIntClaim(User, System.Security.Claims.ClaimTypes.NameIdentifier, out var usuarioClaim) || usuarioClaim != id_usuario))
                return lista;
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

        [HttpGet("historial_pago_cita/{id_cita}/{id_sede}")]
        public List<entities.CuadreCaja> historial_pago_cita(int id_cita, int id_sede)
        {
            List<entities.CuadreCaja> lista = new List<entities.CuadreCaja>();
            if (!TenantContext.IsGlobalAdministrator(User) && !TenantContext.IsCompanyAdministrator(User) && !User.IsInRole("3"))
                return lista;
            if (!TryGetTenantSede(out var sede) || !CanUseSede(id_sede, sede) || !CitaAccesible(id_cita, sede))
                return lista;
            if (!TenantContext.IsGlobalAdministrator(User))
                id_sede = sede;
            try
            {
                lista = historialBL.historial_pago_cita(id_cita, id_sede);
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
            if (oHistorial == null || !TryGetTenantSede(out var sede) ||
                !TenantContext.IsGlobalAdministrator(User) &&
                (!CitaAccesible(oHistorial.id_cita, sede) || !citaBL.PacientePerteneceASede(oHistorial.id_paciente, sede) || !citaBL.DoctorPerteneceASede(oHistorial.id_doctor, sede)))
                return new RespuestaUsuario { estado = false, descripcion = "La cita, paciente o profesional no pertenece a la sede autorizada." };
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
