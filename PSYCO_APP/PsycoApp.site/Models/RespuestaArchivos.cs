using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.site.Models
{
    public class RespuestaArchivos
    {
        public string estado { get; set; } = "OK";
        public string descripcion { get; set; } = "";
        public List<Archivo> data { get; set; } = null;
    }
}
