namespace PsycoApp.entities
{
    public class UsuarioEmpresa
    {
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string Usuario { get; set; }
        public string Password { get; set; }
        public int IdTipoUsuario { get; set; }
        public int IdEmpresa { get; set; }
        public int IdSede { get; set; }
    }
}
