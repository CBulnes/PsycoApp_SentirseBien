using PsycoApp.BL;
using PsycoApp.entities;
using PsycoApp.mcp.Models;
using PsycoApp.utilities;

namespace PsycoApp.mcp.Services
{
    public class CitasMcpService
    {
        private readonly PacienteBL _pacienteBL;
        private readonly PsicologoBL _doctorBL;
        private readonly CitaBL _citaBL;
        private string main_path;
        public CitasMcpService(
            PacienteBL pacienteBL,
            PsicologoBL doctorBL,
            CitaBL citaBL,
            string main_path)
        {
            _pacienteBL = pacienteBL;
            _doctorBL = doctorBL;
            _citaBL = citaBL;
            this.main_path = main_path;
        }

        public async Task<AgendarCitaResponse> AgendarCita(AgendarCitaRequest req)
        {
            RandomUtilities ru = new RandomUtilities();

            string random_str = ru.RandomString(8) + "|" + ru.CurrentDate();
            // 1️⃣ Paciente
            var paciente = _pacienteBL.listar_pacientes_combo_dinamico(1,10,req.Dni,req.IdSede);
            var objPac = paciente.FirstOrDefault();
            if (objPac == null)
                return Fail("Paciente no encontrado");

            // 2️⃣ Doctor
            var doctores = _doctorBL.listar_psicologos_combo();

            doctores = doctores.Where(x => x.Sedes.Contains(req.IdSede.ToString())).ToList();
            var doctor = doctores.FirstOrDefault(d =>
                d.Nombre.Contains(req.Especialista, StringComparison.OrdinalIgnoreCase));

            if (doctor == null)
                return Fail("Especialista no encontrado");

            // 3️⃣ Servicio (local)
            var servicio = ServiciosCatalogo.Obtener(req.Servicio);
            if (servicio == null)
                return Fail("Servicio no válido");

            // 4️⃣ Disponibilidad
            var horario = await _citaBL.disponibilidad_doctor(
                doctor.Id,
                req.Fecha,
                main_path,
                random_str
            );
            //.Any(h => h.hora_cita.StartsWith(req.Hora) && h.estado == "DISPONIBLE");
            var disponible = horario.Any(h =>
                h.hora_cita.StartsWith(req.Hora) &&
                h.estado == "DISPONIBLE"
            );
            if (!disponible)
                return Fail("Horario no disponible");

            // 5️⃣ Construir cita
            var cita = new Cita
            {
                id_paciente = objPac.Id,
                dni_paciente = req.Dni,
                paciente = objPac.Nombre,
                id_doctor_asignado = doctor.Id,
                doctor_asignado = doctor.Nombre,
                id_servicio = servicio.Id,
                nombre_servicio = servicio.Nombre,
                fecha_cita = req.Fecha,
                hora_cita = req.Hora + ":00",
                tipo_cita = req.Modalidad,
                id_sede = req.IdSede,
                monto_pactado = servicio.Precio,
                monto_pendiente = servicio.Precio
            };

            // 6️⃣ Registrar
            var idCita = _citaBL.registrar_cita(cita,main_path,random_str);

            return new AgendarCitaResponse
            {
                Success = true,
                Mensaje = "Cita registrada correctamente",
                estado = idCita.estado
            };
        }

        private AgendarCitaResponse Fail(string msg)
            => new() { Success = false, Mensaje = msg };
    }

}
