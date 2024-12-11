using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using PsycoApp.entities;
using PsycoApp.DA.SQLConnector;
using PsycoApp.utilities;

namespace PsycoApp.DA
{
    public class PsicologoDA
    {
        private readonly SqlConnection _connection;
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        public PsicologoDA()
        {
            _connection = cn;
        }

        public Psicologo BuscarPsicologoId(int id)
        {
            Psicologo psicologo = null;

            using (var command = new SqlCommand(Procedures.obtener_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", id);

                _connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        psicologo = new Psicologo
                        {
                            Id = (int)reader["Id"],
                            Nombre = (string)reader["Nombre"],
                            Apellido = (string)reader["Apellido"],
                            FechaNacimiento = (DateTime)reader["FechaNacimiento"],
                            DocumentoTipo = (string)reader["DocumentoTipo"],
                            DocumentoNumero = (string)reader["DocumentoNumero"],
                            Telefono = (string)reader["Telefono"],
                            Especialidad = (int)reader["Especialidad"],
                            Distrito = (string)reader["Distrito"],
                            Direccion = (string)reader["Direccion"],
                            Estado = (string)reader["Estado"],
                            Refrigerio = (string)reader["Refrigerio"],
                            InicioLabores = (string)reader["InicioLabores"],
                            FinLabores = (string)reader["FinLabores"],
                            IdSedePrincipal = (int)reader["IdSedePrincipal"],
                            IdSedeSecundaria = (int)reader["IdSedeSecundaria"]
                        };
                    }
                }
                _connection.Close();
            }

            return psicologo;
        }

        public List<Estudio> BuscarEstudiosPsicologo(int idPsicologo)
        {
            var estudios = new List<Estudio>();
            using (var command = new SqlCommand(Procedures.listar_estudios_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@IdPsicologo", idPsicologo);
                _connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        estudios.Add(new Estudio
                        {
                            Id = reader.GetInt32(0),
                            IdPsicologo = reader.GetInt32(1),
                            GradoAcademico = reader.GetInt32(2),
                            Institucion = reader.GetInt32(3),
                            Carrera = reader.GetInt32(4)
                        });
                    }
                }
                _connection.Close();
            }
            return estudios;
        }

        public List<Psicologo> BuscarPsicologo(string nombre)
        {
            var psicologos = new List<Psicologo>();

            using (var command = new SqlCommand(Procedures.buscar_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Nombre", nombre);

                _connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var psicologo = new Psicologo
                        {
                            Id = (int)reader["Id"],
                            Nombre = (string)reader["Nombre"],
                            Apellido = (string)reader["Apellido"],
                            FechaNacimiento = (DateTime)reader["FechaNacimiento"],
                            DocumentoTipo = (string)reader["DocumentoTipo"],
                            DocumentoNumero = (string)reader["DocumentoNumero"],
                            Telefono = (string)reader["Telefono"],
                            Refrigerio = (string)reader["Refrigerio"],
                            Especialidad = (int)reader["Especialidad"],
                            Direccion = (string)reader["Direccion"],
                            Distrito = (string)reader["Distrito"],
                            Estado = (string)reader["Estado"]
                        };
                        psicologos.Add(psicologo);
                    }
                }
                _connection.Close();
            }

            return psicologos;
        }

        public List<Psicologo> ListarPsicologos(int pagina, int tamanoPagina)
        {
            var psicologos = new List<Psicologo>();

            using (var command = new SqlCommand(Procedures.listar_psicologos_paginado, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Pagina", pagina);
                command.Parameters.AddWithValue("@TamanoPagina", tamanoPagina);

                _connection.Open();

                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        psicologos.Add(new Psicologo
                        {
                            Id = reader.GetInt32(0),
                            Nombre = reader.GetString(1),
                            Apellido = reader.GetString(2),
                            FechaNacimiento = reader.GetDateTime(3),
                            DocumentoTipo = reader.GetString(4),
                            DocumentoNumero = reader.GetString(5),
                            Telefono = reader.GetString(6),
                            Refrigerio = reader.GetString(7),
                            Especialidad = reader.GetInt32(8),
                            Direccion = reader.GetString(9),
                            Distrito = reader.GetString(10),
                            Estado = reader.GetString(11)
                        });
                    }
                }

                _connection.Close();
            }

            return psicologos;
        }

        public void AgregarPsicologo(Psicologo psicologo)
        {
            DataTable dtEstudios = Helper.ToDataTable(psicologo.Estudios);
            using (var command = new SqlCommand(Procedures.agregar_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Nombre", psicologo.Nombre);
                command.Parameters.AddWithValue("@Apellido", psicologo.Apellido);
                command.Parameters.AddWithValue("@FechaNacimiento", psicologo.FechaNacimiento);
                command.Parameters.AddWithValue("@DocumentoTipo", psicologo.DocumentoTipo);
                command.Parameters.AddWithValue("@DocumentoNumero", psicologo.DocumentoNumero);
                command.Parameters.AddWithValue("@Telefono", psicologo.Telefono);
                command.Parameters.AddWithValue("@Refrigerio", psicologo.Refrigerio);
                command.Parameters.AddWithValue("@InicioLabores", psicologo.InicioLabores);
                command.Parameters.AddWithValue("@FinLabores", psicologo.FinLabores);
                command.Parameters.AddWithValue("@IdSedePrincipal", psicologo.IdSedePrincipal);
                command.Parameters.AddWithValue("@IdSedeSecundaria", psicologo.IdSedeSecundaria);
                command.Parameters.AddWithValue("@Especialidad", psicologo.Especialidad);
                command.Parameters.AddWithValue("@Direccion", psicologo.Direccion);
                command.Parameters.AddWithValue("@Distrito", psicologo.Distrito);
                command.Parameters.AddWithValue("@Estado", psicologo.Estado);
                command.Parameters.AddWithValue("@EstudiosPsicologo", dtEstudios);

                _connection.Open();
                command.ExecuteNonQuery();
                _connection.Close();
            }
        }

        public void ActualizarPsicologo(Psicologo psicologo)
        {
            DataTable dtEstudios = Helper.ToDataTable(psicologo.Estudios);
            using (var command = new SqlCommand(Procedures.actualizar_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Id", psicologo.Id);
                command.Parameters.AddWithValue("@Nombre", psicologo.Nombre);
                command.Parameters.AddWithValue("@Apellido", psicologo.Apellido);
                command.Parameters.AddWithValue("@FechaNacimiento", psicologo.FechaNacimiento);
                command.Parameters.AddWithValue("@DocumentoTipo", psicologo.DocumentoTipo);
                command.Parameters.AddWithValue("@DocumentoNumero", psicologo.DocumentoNumero);
                command.Parameters.AddWithValue("@Telefono", psicologo.Telefono);
                command.Parameters.AddWithValue("@Refrigerio", psicologo.Refrigerio);
                command.Parameters.AddWithValue("@InicioLabores", psicologo.InicioLabores);
                command.Parameters.AddWithValue("@FinLabores", psicologo.FinLabores);
                command.Parameters.AddWithValue("@IdSedePrincipal", psicologo.IdSedePrincipal);
                command.Parameters.AddWithValue("@IdSedeSecundaria", psicologo.IdSedeSecundaria);
                command.Parameters.AddWithValue("@Especialidad", psicologo.Especialidad);
                command.Parameters.AddWithValue("@Direccion", psicologo.Direccion);
                command.Parameters.AddWithValue("@Distrito", psicologo.Distrito);
                command.Parameters.AddWithValue("@Estado", psicologo.Estado);
                command.Parameters.AddWithValue("@EstudiosPsicologo", dtEstudios);

                _connection.Open();
                command.ExecuteNonQuery();
                _connection.Close();
            }
        }

        public void EliminarPsicologo(int id)
        {
            using (var command = new SqlCommand(Procedures.eliminar_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", id);

                _connection.Open();
                command.ExecuteNonQuery();
                _connection.Close();
            }
        }

        public List<entities.Psicologo> listar_psicologos_combo()
        {
            List<entities.Psicologo> lista = new List<entities.Psicologo>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_psicologos_combo, cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    entities.Psicologo item = new entities.Psicologo();
                    item.Id = Convert.ToInt32(row["id_psicologo"]);
                    item.Nombre = Convert.ToString(row["nombres"]);
                    lista.Add(item);
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            cn.Close();
            return lista;
        }

        public List<entities.Sede> listar_sedes_x_usuario_combo(int id_usuario)
        {
            List<entities.Sede> lista = new List<entities.Sede>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.listar_sedes_x_usuario, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_usuario", id_usuario);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    entities.Sede item = new entities.Sede();
                    item.Id = Convert.ToInt32(row["Id_Sede"]);
                    item.Nombre = Convert.ToString(row["Nombre"]);
                    lista.Add(item);
                }
            }
            catch (Exception e)
            {
                lista.Clear();
            }
            cn.Close();
            return lista;
        }

        public List<entities.Sede> listar_sedes_combo()
        {
            List<entities.Sede> lista = new List<entities.Sede>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.listar_sedes_combo, cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    entities.Sede item = new entities.Sede();
                    item.Id = Convert.ToInt32(row["Id_Sede"]);
                    item.Nombre = Convert.ToString(row["Nombre"]);
                    lista.Add(item);
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
