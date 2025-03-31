using PsycoApp.entities.DTO.DtoResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.DA.Interfaces
{
    public interface IPaqueteDA
    {
        List<PaqueteDTO> Listar(int pagina, int tamanoPagina, ref int totalReg);
        Task Grabar(PaqueteDTO paquete);
        Task Actualizar(PaqueteDTO paquete);
        Task<PaqueteDTO> ObtenerPorId(int Id);
        Task<int> Eliminar(int id);
        Task<int> Activar(int id);
    }
}
