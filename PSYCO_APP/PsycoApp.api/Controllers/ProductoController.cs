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
        public ActionResult<List<entities.Producto>> listar_productos_combo()
        {
            List<entities.Producto> lista = new List<entities.Producto>();
            try
            {
                lista = _productoBL.listar_productos_combo();
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            return lista;
        }
    }
}
