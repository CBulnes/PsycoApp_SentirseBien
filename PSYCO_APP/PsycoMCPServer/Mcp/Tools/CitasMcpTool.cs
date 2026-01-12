using ModelContextProtocol.Server;
using PsycoMCPServer.Models;
using PsycoMCPServer.Services;
using System.ComponentModel;
using System.Text.Json;
namespace PsycoMCPServer.Mcp.Tools
{
    [McpServerToolType]
    public class CitasMcpTool
    {
        private readonly PlanServices _service;

        public CitasMcpTool(PlanServices service)
        {
            _service = service;
        }

        [McpServerTool, Description("Insertar Cita")]
        public async Task<string> AgendarCita(AgendarCitaRequest request)
        {
          Console.Error.WriteLine($"agendar_cita called - dni={request?.Dni} especialista={request?.Especialista} servicio={request?.Servicio} fecha={request?.Fecha} hora={request?.Hora} idSede={request?.IdSede}");
    try
    {
                // Si quieres probar con valor fijo, deja la línea siguiente; 
                // para test final reemplaza por la llamada real al servicio.


                var response = await _service.AgendarCita(request);
                return JsonSerializer.Serialize(response);
            }
    catch (Exception ex)
    {
        Console.Error.WriteLine("AgendarCita Exception: " + ex.ToString());
        return JsonSerializer.Serialize(new { ok = false, error = ex.Message });
    }
            // var response = await _service.AgendarCita(request);
            // return JsonSerializer.Serialize(response);
        }
    }
}
