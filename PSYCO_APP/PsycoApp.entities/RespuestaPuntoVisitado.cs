using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class RespuestaPuntoVisitado
    {
        public string estado { get; set; } = "OK";
        public string descripcion { get; set; } = "";
        public List<PuntoVisitado> data { get; set; } = null;
        //public List<PuntoVisitado>? data { get; set; } = null;
    }
}
