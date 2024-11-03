using PsycoApp.DA;
using PsycoApp.entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.BL
{
    public class ProductoBL
    {
        private readonly ProductoDA _productoDA;

        public ProductoBL()
        {
            _productoDA = new ProductoDA();
        }

        public List<entities.Producto> listar_productos_combo()
        {
            return _productoDA.listar_productos_combo();
        }
    }
}
