using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class Menu
    {
        public string nombre_categoria { get; set; } = "";
        public string nombre_opcion { get; set; } = "";
        public string ruta_opcion { get; set; } = "";
        public string acceso_directo { get; set; } = "";

        public string icono { get; set; } = "";
        public string id_opcion { get; set; } = "";
        public string opcion { get; set; } = "";
        public string asignado { get; set; } = "";
        public string validacion { get; set; } = "";
    }
}
