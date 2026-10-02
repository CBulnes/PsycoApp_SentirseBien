using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using System.Collections.Generic;
using System;
using PsycoApp.entities;
using PsycoApp.DA;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductoController : ControllerBase
    {

        ProductoBL _productoBL = new ProductoBL();

        [HttpGet("listar_productos_combo")]
        public ActionResult<List<entities.Producto>> listar_productos_combo(int id_empresa = 1)
        {
            List<entities.Producto> lista = new List<entities.Producto>();
            try
            {
                lista = _productoBL.listar_productos_combo(id_empresa);
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("empresa/{id_empresa}/listar")]
        public ActionResult<List<entities.Producto>> listar_empresa(int id_empresa)
        {
            if (id_empresa <= 0) return BadRequest("Empresa inválida.");
            return _productoBL.listar_mantenimiento(id_empresa);
        }

        [HttpPost("empresa/{id_empresa}/guardar")]
        public ActionResult<int> guardar(int id_empresa, [FromBody] entities.Producto producto)
        {
            if (id_empresa <= 0 || producto == null || string.IsNullOrWhiteSpace(producto.Nombre) || producto.Nombre.Length > 100 || !decimal.TryParse(producto.Precio, System.Globalization.NumberStyles.Number, System.Globalization.CultureInfo.InvariantCulture, out var precio) || precio < 0 || producto.NumSesiones < 0)
                return BadRequest("Los datos del producto no son válidos.");
            return _productoBL.guardar(producto, id_empresa);
        }

        [HttpPost("empresa/{id_empresa}/eliminar/{id}")]
        public ActionResult eliminar(int id_empresa, int id)
        {
            if (id_empresa <= 0 || id <= 0) return BadRequest("Producto o empresa inválidos.");
            if (_productoBL.eliminar(id, id_empresa)) return Ok();
            return NotFound();
        }
    }
}
