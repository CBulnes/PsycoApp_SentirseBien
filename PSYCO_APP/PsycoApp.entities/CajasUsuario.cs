using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class CajasUsuario
    {
        public int id_caja { get; set; }
        public int id_usuario { get; set; }
        public string nombre_usuario { get; set; }
        public DateTime fecha { get; set; }
        public DateTime? fecha_apertura { get; set; }
        public DateTime? fecha_cierre { get; set; }
        public string estado { get; set; }

    }
}
