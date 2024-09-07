using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.DA;
using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.utilities;

namespace PsycoApp.BL
{
    public class UsuarioBL
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
        public List<Usuario> listar_doctores()
        {
            return usuarioDA.listar_doctores();
        }

    }
}
