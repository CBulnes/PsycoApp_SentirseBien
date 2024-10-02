using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class Cita
    {
        public int id_cita { get; set; } = 0;
        public int id_usuario { get; set; } = 0;
        public string usuario { get; set; } = "";
        public int id_estado_cita { get; set; } = 0;
        public string estado { get; set; } = "";
        public string fecha_cita { get; set; } = "";
        public string hora_cita { get; set; } = "";
        public int id_doctor_asignado { get; set; } = 0;
        public string doctor_asignado { get; set; } = "";
        public int id_paciente { get; set; } = 0;
        public string paciente { get; set; } = "";
        public string tipo { get; set; } = "";
    }
}
