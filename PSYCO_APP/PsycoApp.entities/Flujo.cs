using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class Flujo
    {
        public int id_flujo { get; set; } = 0;
        public int id_usuario { get; set; } = 0;
        public string tipo { get; set; } = "";
        public string remitente { get; set; } = "";
        public string contenido_texto { get; set; } = "";
        public string contenido_html { get; set; } = "";
        public int habilitado { get; set; } = 0;
    }
}
