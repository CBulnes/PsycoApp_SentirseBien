using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.site.Models
{
    public class ProductosYPacientesViewModel
    {
        public IEnumerable<PsycoApp.site.Models.Producto> Productos { get; set; }
        public IEnumerable<PsycoApp.site.Models.Paciente> Pacientes { get; set; }
        public dynamic DynamicData { get; set; }
    }
}
