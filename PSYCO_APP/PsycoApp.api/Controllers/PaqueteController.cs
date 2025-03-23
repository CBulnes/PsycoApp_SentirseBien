using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System;
using PsycoApp.entities.DTO.DtoResponse;
using AutoMapper;
using PsycoApp.BL.Interfaces;
using System.Web.Http;
using PsycoApp.entities.DTO.DtoRequest;

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
        [AllowAnonymous]
        [Microsoft.AspNetCore.Mvc.HttpGet("listar")]
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
    }
}
