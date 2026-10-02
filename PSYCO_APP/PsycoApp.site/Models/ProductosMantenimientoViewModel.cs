using System.Collections.Generic;

namespace PsycoApp.site.Models
{
    public class ProductosMantenimientoViewModel
    {
        public IEnumerable<PsycoApp.entities.Producto> Productos { get; set; }
        public dynamic DynamicData { get; set; }
    }
}
