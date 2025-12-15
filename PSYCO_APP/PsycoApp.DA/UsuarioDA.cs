using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.utilities;

namespace PsycoApp.DA
{
    public class UsuarioDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        string rpta = "";

        public Usuario validar_usuario(Usuario usuario)
        {
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand("SP_VALIDAR_USUARIO_V2", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario.email;
                cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = usuario.password;
                cmd.Parameters.Add("@id_sede", SqlDbType.VarChar).Value = usuario.id_sede;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    usuario.id_usuario = Convert.ToInt32(row["id_usuario"]);
                    usuario.nombres = Convert.ToString(row["nombres"]);
                    usuario.apellidos = Convert.ToString(row["apellidos"]);
                    usuario.id_tipousuario = Convert.ToInt32(row["id_tipousuario"]);
                    usuario.id_psicologo = Convert.ToInt32(row["id_psicologo"]);
                    usuario.tipousuario = Convert.ToString(row["tipousuario"]);                    
                    usuario.tipo_documento = Convert.ToString(row["tipo_documento"]);
                    usuario.num_documento = Convert.ToString(row["num_documento"]);
                    usuario.validacion = Convert.ToString(row["validacion"]);
                    usuario.test_actual = Convert.ToInt32(row["test_actual"]);
                    usuario.login = Convert.ToString(row["login"]);
                    usuario.id_sede = Convert.ToInt32(row["id_sede"]);
                }
            }
            catch (Exception e)
            {
                usuario.validacion = e.Message;
            }
            cn.Close();
            return usuario;
        }
        public Usuario actualizar_contraseña(Usuario usuario)
        {
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_actualizar_contraseña, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario.email;
                cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = usuario.password;
                cmd.Parameters.Add("@nuevo_password", SqlDbType.VarChar).Value = usuario.nuevo_pass1;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    usuario.validacion = Convert.ToString(row["validacion"]);
                }
            }
            catch (Exception e)
            {
                usuario.validacion = "Ocurrió un error al actualizar la contraseña";
            }
            cn.Close();
            return usuario;
        }

    }
}
