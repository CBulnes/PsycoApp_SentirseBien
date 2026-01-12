namespace PsycoMCPServer.Models
{
       public class AgendarCitaRequest
    {
        public string Dni { get; set; }
        public string Especialista { get; set; }
        public string Servicio { get; set; }
        public string Fecha { get; set; }   // YYYY-MM-DD
        public string Hora { get; set; }    // HH:mm
        public string Modalidad { get; set; }
        public int IdSede { get; set; }
    }

}