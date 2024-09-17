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
                            FechaNacimiento = (DateTime)reader["FechaNacimiento"],
                            DocumentoTipo = (string)reader["DocumentoTipo"],
                            DocumentoNumero = (string)reader["DocumentoNumero"],
                            Telefono = (string)reader["Telefono"],
                            Especialidad = (int)reader["Especialidad"],
                            Distrito = (string)reader["Distrito"],
                            Direccion = (string)reader["Direccion"],
                            Estado = (string)reader["Estado"]
                        };
                    }
                }
                _connection.Close();
            }

            return psicologo;
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
                            FechaNacimiento = (DateTime)reader["FechaNacimiento"],
                            DocumentoTipo = (string)reader["DocumentoTipo"],
                            DocumentoNumero = (string)reader["DocumentoNumero"],
                            Telefono = (string)reader["Telefono"],
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

        public List<Psicologo> ListarPsicologos()
        {
            var psicologos = new List<Psicologo>();

            using (var command = new SqlCommand(Procedures.listar_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                _connection.Open();

                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        psicologos.Add(new Psicologo
                        {
                            Id = reader.GetInt32(0),
                            Nombre = reader.GetString(1),
                            FechaNacimiento = reader.GetDateTime(2),
                            DocumentoTipo = reader.GetString(3),
                            DocumentoNumero = reader.GetString(4),
                            Telefono = reader.GetString(5),
                            Especialidad = reader.GetInt32(6),
                            Direccion = reader.GetString(7),
                            Distrito = reader.GetString(8),
                            Estado = reader.GetString(9)
                        });
                    }
                }

                _connection.Close();
            }

            return psicologos;
        }

        public void AgregarPsicologo(Psicologo psicologo)
        {
            using (var command = new SqlCommand(Procedures.agregar_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Nombre", psicologo.Nombre);
                command.Parameters.AddWithValue("@FechaNacimiento", psicologo.FechaNacimiento);
                command.Parameters.AddWithValue("@DocumentoTipo", psicologo.DocumentoTipo);
                command.Parameters.AddWithValue("@DocumentoNumero", psicologo.DocumentoNumero);
                command.Parameters.AddWithValue("@Telefono", psicologo.Telefono);
                command.Parameters.AddWithValue("@Especialidad", psicologo.Especialidad);
                command.Parameters.AddWithValue("@Direccion", psicologo.Direccion);
                command.Parameters.AddWithValue("@Distrito", psicologo.Distrito);
                command.Parameters.AddWithValue("@Estado", psicologo.Estado);

                _connection.Open();
                command.ExecuteNonQuery();
                _connection.Close();
            }
        }

        public void ActualizarPsicologo(Psicologo psicologo)
        {
            using (var command = new SqlCommand(Procedures.actualizar_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Id", psicologo.Id);
                command.Parameters.AddWithValue("@Nombre", psicologo.Nombre);
                command.Parameters.AddWithValue("@FechaNacimiento", psicologo.FechaNacimiento);
                command.Parameters.AddWithValue("@DocumentoTipo", psicologo.DocumentoTipo);
                command.Parameters.AddWithValue("@DocumentoNumero", psicologo.DocumentoNumero);
                command.Parameters.AddWithValue("@Telefono", psicologo.Telefono);
                command.Parameters.AddWithValue("@Especialidad", psicologo.Especialidad);
                command.Parameters.AddWithValue("@Direccion", psicologo.Direccion);
                command.Parameters.AddWithValue("@Distrito", psicologo.Distrito);
                command.Parameters.AddWithValue("@Estado", psicologo.Estado);

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
    }
}
