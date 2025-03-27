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

        public async Task<PaqueteDTO> Actualizar(PaqueteDTO paquete)
        {
             await _paqueteDA.Actualizar(paquete);
            return paquete;
        }

        public async Task<int> Eliminar(int id)
        {
            return await _paqueteDA.Eliminar(id);
        }

        public async Task<PaqueteDTO> Grabar(PaqueteDTO paquete)
        {
             await _paqueteDA.Grabar(paquete);
            return paquete;
        }

        public List<PaqueteDTO> Listar(int pagina, int tamanoPagina, ref int totalReg)
        {
            return _paqueteDA.Listar(pagina, tamanoPagina,ref totalReg);
        }
    }
}
