using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.entities.Dto;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.DA
{
    public class UsuarioDA
    {
        SqlConnection cn = new SqlConnector().cadConnection_psyco;

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

        #region "version react"
        public async Task<Respuesta<Usuario>> LoginV2(LoginDto request)
        {
            var respuesta = new Respuesta<Usuario>(-1, "Usuario no encontrado o error en la validación");
            var usuario = new Usuario();
            try
            {
                await cn.OpenAsync();

                SqlCommand cmd = new SqlCommand(Procedures.sp_validar_usuario, cn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar).Value = request.usuario;
                cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = request.password;

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    if (reader.HasRows)
                    {
                        while (await reader.ReadAsync())
                        {
                            usuario.id_usuario = Convert.ToInt32(reader["id_usuario"]);
                            usuario.nombres = Convert.ToString(reader["nombres"]);
                            usuario.apellidos = Convert.ToString(reader["apellidos"]);
                            usuario.id_tipousuario = Convert.ToInt32(reader["id_tipousuario"]);
                            usuario.id_psicologo = Convert.ToInt32(reader["id_psicologo"]);
                            usuario.tipousuario = Convert.ToString(reader["tipousuario"]);
                            usuario.tipo_documento = Convert.ToString(reader["tipo_documento"]);
                            usuario.num_documento = Convert.ToString(reader["num_documento"]);
                            usuario.validacion = Convert.ToString(reader["validacion"]);
                            usuario.test_actual = Convert.ToInt32(reader["test_actual"]);
                            usuario.login = Convert.ToString(reader["login"]);
                            usuario.id_sede = Convert.ToInt32(reader["id_sede"]);
                        }
                        if (usuario.id_usuario > 0)
                            respuesta = new Respuesta<Usuario>(0, "Usuario validado correctamente", usuario);
                    }
                }
            }
            catch (Exception e)
            {
                respuesta = new Respuesta<Usuario>(-1, "Error al validar el usuario: " + e.Message);
            }
            finally
            {
                await cn.CloseAsync();
            }
            return respuesta;
        }
        #endregion
    }
}
