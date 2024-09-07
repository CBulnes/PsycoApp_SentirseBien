using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class RespuestaContraseña
    {
        public bool iguales { get; set; } = true;
        public bool mayusc { get; set; } = true;
        public bool minusc { get; set; } = true;
        public bool numeros { get; set; } = true;
        public bool especial { get; set; } = true;
    }
}
