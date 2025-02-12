using PsycoApp.entities.DTO.DtoRequest;
using PsycoApp.entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace PsycoApp.DA.Interfaces
{
    public interface IUsuarioDA
    {
        public Usuario validar_usuario(UsuarioLoginDto usuarioDTO);
        public Usuario actualizar_contraseña(Usuario usuario);
    }
}
