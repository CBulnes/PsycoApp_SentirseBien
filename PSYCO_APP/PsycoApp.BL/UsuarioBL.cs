using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.BL.Interfaces;
using PsycoApp.DA;
using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using PsycoApp.utilities;

namespace PsycoApp.BL
{
    public class UsuarioBL : IUsuarioBL
    {
        UsuarioDA usuarioDA = new UsuarioDA();

        public Usuario validar_usuario(Usuario usuario)
        {
            return usuarioDA.validar_usuario(usuario);
        }
        public Usuario actualizar_contraseña(Usuario usuario)
        {
            return usuarioDA.actualizar_contraseña(usuario);
        }

        #region "version react"
        public async Task<Respuesta<Usuario>> LoginV2(LoginDto request)
        {
            var respuesta = await usuarioDA.LoginV2(request);
            return respuesta;
        }
        #endregion

    }
}
