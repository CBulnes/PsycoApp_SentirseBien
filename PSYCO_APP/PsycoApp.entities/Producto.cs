using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class Producto
    {
        public int Id { get; set; }
        public int Id_empresa { get; set; }
        public string Nombre { get; set; }
        public string Alias { get; set; }
        public string Precio { get; set; }
        public string Color { get; set; }
        public int NumSesiones { get; set; }
        public bool EsEvaluacion { get; set; }
        public string Siglas { get; set; }
        public int Mostrar { get; set; }
    }
}