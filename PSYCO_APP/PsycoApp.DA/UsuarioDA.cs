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
                SqlCommand cmd = new SqlCommand(Procedures.sp_validar_usuario, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = usuario.email;
                cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = usuario.password;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    usuario.id_usuario = Convert.ToInt32(row["id_usuario"]);
                    usuario.nombres = Convert.ToString(row["nombres"]);
                    usuario.apellidos = Convert.ToString(row["apellidos"]);
                    usuario.id_tipousuario = Convert.ToInt32(row["id_tipousuario"]);
                    usuario.tipousuario = Convert.ToString(row["tipousuario"]);                    
                    usuario.tipo_documento = Convert.ToString(row["tipo_documento"]);
                    usuario.num_documento = Convert.ToString(row["num_documento"]);
                    usuario.validacion = Convert.ToString(row["validacion"]);
                    usuario.test_actual = Convert.ToInt32(row["test_actual"]);
                }
            }
            catch (Exception e)
            {
                usuario.validacion = "Ocurrió un error al validar sus credenciales";
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
        public List<Usuario> listar_doctores()
        {
            List<Usuario> lista = new List<Usuario>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_doctores, cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    Usuario usuario = new Usuario();
                    usuario.id_usuario = Convert.ToInt32(row["id_usuario"]);
                    usuario.nombres = Convert.ToString(row["nombres"]);
                    lista.Add(usuario);
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            cn.Close();
            return lista;
        }

    }
}
