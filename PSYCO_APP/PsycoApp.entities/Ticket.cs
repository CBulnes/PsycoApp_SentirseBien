using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class Ticket
    {
        public int id_ticket { get; set; } = 0;
        public string codigo { get; set; } = "";
        public int id_usuario { get; set; } = 0;
        public string estado { get; set; } = "";
    }
}
