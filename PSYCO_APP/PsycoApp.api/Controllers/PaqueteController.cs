using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System;
using PsycoApp.entities.DTO.DtoResponse;
using AutoMapper;
using PsycoApp.BL.Interfaces;
using System.Web.Http;

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
        [Microsoft.AspNetCore.Mvc.HttpGet("listar/{pagina}/{tamanoPagina}")]
        public ActionResult<List<PaqueteDTO>> Listar(int pagina = 1, int tamanoPagina = 100)
        {
            try
            {
                return _paqueteBL.Listar(pagina, tamanoPagina);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
