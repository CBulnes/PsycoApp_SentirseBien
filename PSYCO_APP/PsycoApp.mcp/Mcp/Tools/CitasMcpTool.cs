using ModelContextProtocol.Server;
using PsycoApp.mcp.Models;
using PsycoApp.mcp.Services;
using System.ComponentModel;
namespace PsycoApp.mcp.Mcp.Tools
{
    [McpServerToolType]
    public class CitasMcpTool
    {
        private readonly CitasMcpService _service;

        public CitasMcpTool(CitasMcpService service)
        {
            _service = service;
        }

        [McpServerTool, Description("Insertar Cita")]
        public Task<AgendarCitaResponse> AgendarCita(AgendarCitaRequest request)
        {
            return _service.AgendarCita(request);
        }
    }
}
