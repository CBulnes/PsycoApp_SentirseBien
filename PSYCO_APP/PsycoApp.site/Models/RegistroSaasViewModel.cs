using System.ComponentModel.DataAnnotations;

namespace PsycoApp.site.Models
{
    public class RegistroSaasViewModel
    {
        [Required(ErrorMessage = "Indica el nombre de la empresa.")]
        [StringLength(200)]
        public string Empresa { get; set; }

        [Required(ErrorMessage = "Indica el nombre de la sede principal.")]
        [StringLength(200)]
        public string Sede { get; set; }

        [Required(ErrorMessage = "Indica los nombres del administrador.")]
        [StringLength(100)]
        public string Nombres { get; set; }

        [Required(ErrorMessage = "Indica los apellidos del administrador.")]
        [StringLength(100)]
        public string Apellidos { get; set; }

        [Required(ErrorMessage = "Indica un usuario para iniciar sesión.")]
        [StringLength(50)]
        [RegularExpression("^[\\p{L}]+$", ErrorMessage = "El usuario debe contener solo letras, sin espacios.")]
        public string Usuario { get; set; }

        [Required(ErrorMessage = "Indica una contraseña.")]
        [StringLength(50, MinimumLength = 6, ErrorMessage = "La contraseña debe tener entre 6 y 50 caracteres.")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required(ErrorMessage = "Confirma la contraseña.")]
        [Compare(nameof(Password), ErrorMessage = "Las contraseñas no coinciden.")]
        [DataType(DataType.Password)]
        public string ConfirmarPassword { get; set; }
    }
}
