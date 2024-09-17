using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PsycoApp.BL;
using System.Collections.Generic;
using System;
using PsycoApp.entities;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UbigeoController : ControllerBase
    {

        UbigeoBL _ubigeoBL = new UbigeoBL();

        [HttpGet("listar")]
        public ActionResult<List<Ubigeo>> Listar()
        {
            try
            {
                return _ubigeoBL.ListarUbigeos();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
