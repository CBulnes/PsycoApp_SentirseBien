using System.ComponentModel.DataAnnotations;

namespace PsycoApp.entities
{
    public class GoogleCredential
    {
        [Required, StringLength(12000)]
        public string Credential { get; set; }
    }

    public class GoogleRegistration : GoogleCredential
    {
        [Required, StringLength(200)] public string Empresa { get; set; }
        [Required, StringLength(100)] public string Sede { get; set; }
        [Required, StringLength(100)] public string Nombres { get; set; }
        [Required, StringLength(100)] public string Apellidos { get; set; }
    }

    public class GoogleAccessResult
    {
        public bool NeedsRegistration { get; set; }
        public Usuario User { get; set; }
        public string Token { get; set; }
        public string Sede { get; set; }
    }
}
