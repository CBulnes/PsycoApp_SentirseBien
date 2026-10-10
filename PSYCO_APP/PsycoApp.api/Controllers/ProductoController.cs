using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using System.Collections.Generic;
using System;
using PsycoApp.entities;
using PsycoApp.DA;
using PsycoApp.api.Security;

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
            if (!TryResolveEmpresa(id_empresa, out var empresaAutorizada))
                return Forbid();
            List<entities.Producto> lista = new List<entities.Producto>();
            try
            {
                lista = _productoBL.listar_productos_combo(empresaAutorizada);
            }
            catch (Exception)
            {
                lista.Clear();
            }
            return lista;
        }

        [HttpGet("empresa/{id_empresa}/listar")]
        public ActionResult<List<entities.Producto>> listar_empresa(int id_empresa)
        {
            if (!TryResolveEmpresa(id_empresa, out var empresaAutorizada)) return Forbid();
            return _productoBL.listar_mantenimiento(empresaAutorizada);
        }

        [HttpPost("empresa/{id_empresa}/guardar")]
        public ActionResult<int> guardar(int id_empresa, [FromBody] entities.Producto producto)
        {
            if (!EsAdministradorEmpresa()) return Forbid();
            if (!TryResolveEmpresa(id_empresa, out var empresaAutorizada)) return Forbid();
            if (producto == null || string.IsNullOrWhiteSpace(producto.Nombre) || producto.Nombre.Length > 100 || !decimal.TryParse(producto.Precio, System.Globalization.NumberStyles.Number, System.Globalization.CultureInfo.InvariantCulture, out var precio) || precio < 0 || producto.NumSesiones < 0)
                return BadRequest("Los datos del producto no son válidos.");
            return _productoBL.guardar(producto, empresaAutorizada);
        }

        [HttpPost("empresa/{id_empresa}/eliminar/{id}")]
        public ActionResult eliminar(int id_empresa, int id)
        {
            if (!EsAdministradorEmpresa()) return Forbid();
            if (!TryResolveEmpresa(id_empresa, out var empresaAutorizada)) return Forbid();
            if (id <= 0) return BadRequest("Producto inválido.");
            if (_productoBL.eliminar(id, empresaAutorizada)) return Ok();
            return NotFound();
        }

        private bool TryResolveEmpresa(int empresaSolicitada, out int empresaAutorizada)
        {
            if (TenantContext.IsGlobalAdministrator(User))
            {
                empresaAutorizada = empresaSolicitada;
                return empresaAutorizada > 0;
            }

            if (!TenantContext.TryGetIntClaim(User, "id_empresa", out empresaAutorizada) || empresaAutorizada <= 0)
                return false;

            return empresaSolicitada <= 0 || empresaSolicitada == empresaAutorizada;
        }

        private bool EsAdministradorEmpresa()
        {
            return TenantContext.IsGlobalAdministrator(User) || TenantContext.IsCompanyAdministrator(User);
        }
    }
}
