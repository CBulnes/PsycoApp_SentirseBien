namespace PsycoApp.entities
{
    public class RegistroSaasEmpresa
    {
        public string Empresa { get; set; }
        public string Sede { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string Usuario { get; set; }
        public string Password { get; set; }
        public int IdEmpresa { get; set; }
        public int IdSede { get; set; }
        public int IdUsuario { get; set; }
    }
}
