using System;
using System.Collections.Generic;

namespace PsycoApp.site.Models
{
    public class Producto
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Alias { get; set; }
        public string Precio { get; set; }
        public string Color { get; set; }
    }
}