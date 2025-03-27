using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System;
using PsycoApp.entities.DTO.DtoResponse;
using AutoMapper;
using PsycoApp.BL.Interfaces;
using PsycoApp.entities.DTO.DtoRequest;
using PsycoApp.BL;
using System.Threading.Tasks;
using Microsoft.Extensions.Options;
using PsycoApp.DA;

namespace PsycoApp.api.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class PaqueteController : Controller
    {
        private readonly IPaquete _paqueteBL;
        private readonly IMapper _mapper;
        private IManejoJwt manejoJwt;
        public PaqueteController(IPaquete paqueteBL, IMapper mapper, IManejoJwt manejoJwt)
        {
            _paqueteBL = paqueteBL;
            _mapper = mapper;
            this.manejoJwt = manejoJwt;
        }

        [HttpGet("listar")]
        public ActionResult<PaquetePageDTO> Listar([FromQuery] PaquetePageParamDTO paquetePageParamDTO)
        {
            try
            {
                int vartotalReg = 0;
                var paquetes = _paqueteBL.Listar(paquetePageParamDTO.pagina, paquetePageParamDTO.tamanoPagina, ref vartotalReg);
                var paquetesDTO = _mapper.Map<List<PaqueteDTO>>(paquetes);
                return new PaquetePageDTO
                {
                    Paquetes = paquetesDTO,
                    totalReg = vartotalReg
                };
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("grabar")]
        public async Task<IActionResult> grabar([FromBody] PaqueteDTO paquete)
        {
            try
            {
                PaqueteDTO res = new PaqueteDTO(); 
                if (paquete.Id == 0)
                {
                    res = await  _paqueteBL.Grabar(paquete);
                }
                else
                {
                    res =  await _paqueteBL.Actualizar(paquete);
                }
                    return Ok(res);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete("eliminar/{id}")]
        public async Task<IActionResult> eliminar(int id)
        {
            try
            {
                var idR = await _paqueteBL.Eliminar(id);

                if (idR > 0)
                    return Ok(new { mensaje = "El paquete se eliminó correctamente.", id = idR });

                return NotFound($"No se encontró el paquete con Id {id}");
            }
            catch (Exception ex)
            {
                return BadRequest(new { mensaje = "Error al eliminar el paquete.", error = ex.Message });
            }
        }

    }
}
