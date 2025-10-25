using PsycoApp.DA;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace PsycoApp.BL.Interfaces
{
    public interface IUsuarioBL
    {
        Usuario validar_usuario(Usuario usuario);
        Usuario actualizar_contraseña(Usuario usuario);

        #region "version react"
        Task<Respuesta<Usuario>> LoginV2(LoginDto request);
        #endregion
    }
}