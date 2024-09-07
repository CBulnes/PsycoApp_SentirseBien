using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class HistorialPaciente
    {
        public int id_historial { get; set; } = 0;
        public int id_paciente { get; set; } = 0;
        public string nota { get; set; } = "";
        public string recomendacion { get; set; } = "";
        public string medicina { get; set; } = "";
        public int id_doctor { get; set; } = 0;
        public string doctor { get; set; } = "";
        public string fecha_registro { get; set; } = "";
        public string hora_registro { get; set; } = "";
        public string cuestionarios { get; set; } = "";
        public int id_cita { get; set; } = 0;
    }
}
