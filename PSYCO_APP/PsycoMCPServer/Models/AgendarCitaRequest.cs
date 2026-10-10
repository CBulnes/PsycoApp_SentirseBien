namespace PsycoMCPServer.Models
{
       public class AgendarCitaRequest
    {
        public string Dni { get; set; } = string.Empty;
        public string Especialista { get; set; } = string.Empty;
        public string Servicio { get; set; } = string.Empty;
        public string Fecha { get; set; } = string.Empty;   // YYYY-MM-DD
        public string Hora { get; set; } = string.Empty;    // HH:mm
        public string Modalidad { get; set; } = string.Empty;
        public int IdSede { get; set; }
    }

}