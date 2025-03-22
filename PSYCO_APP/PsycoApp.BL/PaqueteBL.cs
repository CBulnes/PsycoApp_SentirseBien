using AutoMapper;
using Microsoft.Extensions.Configuration;
using PsycoApp.BL.Interfaces;
using PsycoApp.DA;
using PsycoApp.DA.Interfaces;
using PsycoApp.entities;
using PsycoApp.entities.DTO.DtoResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.BL
{
    public class PaqueteBL : IPaquete
    {
        private readonly IMapper _mapper;
        private readonly IPaqueteDA _paqueteDA;
        public IConfiguration _configuration;

        public PaqueteBL(IConfiguration configuration, IMapper mapper, IPaqueteDA paqueteDA)
        {
            _mapper = mapper;
            _paqueteDA = paqueteDA;
            _configuration = configuration;
        }

        public List<PaqueteDTO> Listar(int pagina, int tamanoPagina)
        {
            return _paqueteDA.Listar(pagina, tamanoPagina);
        }
    }
}
