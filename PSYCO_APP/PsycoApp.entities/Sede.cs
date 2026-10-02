using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class Sede
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public bool Estado { get; set; } = true;
        public string Centro { get; set; }
        public int IdEmpresa { get; set; }
    }
}