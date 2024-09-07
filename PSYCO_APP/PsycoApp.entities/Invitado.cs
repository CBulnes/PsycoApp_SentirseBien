using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class Invitado
    {
        public int id_invitado { get; set; } = 0;
        public string linea { get; set; } = "";
        public int id_tipolinea { get; set; } = 0;
    }
}
