using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class PuntoVisitado
    {
        public int orden { get; set; } = 0;
        public int num_mes { get; set; } = 0;
        public string mes { get; set; } = "";
        public string tipo { get; set; } = "";
        public string visitante { get; set; } = "";
        public int total { get; set; } = 0;
        public string validacion { get; set; } = "OK";
    }
}
