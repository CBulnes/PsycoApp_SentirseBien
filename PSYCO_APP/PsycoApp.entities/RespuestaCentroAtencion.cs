using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class RespuestaCentroAtencion
    {
        public string estado { get; set; } = "OK";
        public string descripcion { get; set; } = "";
        public List<CentroAtencion> data { get; set; } = null;
    }
}
