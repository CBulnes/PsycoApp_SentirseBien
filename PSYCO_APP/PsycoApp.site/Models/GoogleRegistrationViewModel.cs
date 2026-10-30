using System.ComponentModel.DataAnnotations;

namespace PsycoApp.site.Models
{
    public class GoogleRegistrationViewModel
    {
        [Required, StringLength(200)] public string Empresa { get; set; }
        [Required, StringLength(100)] public string Sede { get; set; }
        [Required, StringLength(100)] public string Nombres { get; set; }
        [Required, StringLength(100)] public string Apellidos { get; set; }
    }
}
