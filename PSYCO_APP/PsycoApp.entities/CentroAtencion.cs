using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class CentroAtencion
    {
        public int id_centro_atencion { get; set; } = 0;
        public string centro_atencion { get; set; } = "";
        public string direccion { get; set; } = "";
        public string horario { get; set; } = "";
        public string validacion { get; set; } = "";
    }
}
