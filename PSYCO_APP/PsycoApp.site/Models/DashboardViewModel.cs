using System;
using System.Collections.Generic;

namespace PsycoApp.site.Models
{
    public class DashboardViewModel
    {
        public dynamic DynamicData { get; set; }
        public string NombreUsuario { get; set; }
        public string NombreSede { get; set; }
        public int TipoUsuario { get; set; }
        public DateTime FechaActual { get; set; }
        public DateTime? FechaAgendaLocal { get; set; }
        public int CitasHoy { get; set; }
        public int CitasConfirmadasHoy { get; set; }
        public int CitasAtendidasHoy { get; set; }
        public int CitasProgramadasHoy { get; set; }
        public int PacientesTotal { get; set; }
        public int PacientesMes { get; set; }
        public decimal IngresosCajaHoy { get; set; }
        public bool CajaAbierta { get; set; }
        public string EstadoCaja { get; set; }
        public IDictionary<string, decimal> IngresosPorFormaPago { get; set; } = new Dictionary<string, decimal>();
        public int EspecialistasDisponibles { get; set; }
        public int EspecialistasTotal { get; set; }
        public int PacientesAtendidos { get; set; }
        public int PacientesCitados { get; set; }
        public int PacientesConfirmados { get; set; }
        public int PacientesPorAtender { get; set; }
        public IList<DashboardCitaViewModel> ProximasCitas { get; set; } = new List<DashboardCitaViewModel>();
        public IList<DashboardActividadViewModel> ActividadReciente { get; set; } = new List<DashboardActividadViewModel>();
        public IList<DashboardDiaViewModel> ActividadSemanal { get; set; } = new List<DashboardDiaViewModel>();
        public bool MostrarCaja { get; set; }
        public bool MostrarPacientesYEspecialistas { get; set; }
        public bool MostrarActividadReciente { get; set; }
        public bool EsEspecialista { get; set; }
        public string UrlAgenda { get; set; }
        public string ErrorCarga { get; set; }
    }

    public class DashboardCitaViewModel
    {
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        public string Hora { get; set; }
        public string Paciente { get; set; }
        public string Especialista { get; set; }
        public string Servicio { get; set; }
        public string Estado { get; set; }
    }

    public class DashboardActividadViewModel
    {
        public string Tipo { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public DateTime Fecha { get; set; }
    }

    public class DashboardDiaViewModel
    {
        public DateTime Fecha { get; set; }
        public int Citas { get; set; }
        public int Pacientes { get; set; }
        public decimal Ingresos { get; set; }
    }
}
