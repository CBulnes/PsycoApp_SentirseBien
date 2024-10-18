using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using PsycoApp.entities;
using PsycoApp.DA.SQLConnector;

namespace PsycoApp.DA
{
    public class PacienteDA
    {
        private readonly SqlConnection _connection;
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        public PacienteDA()
        {
            _connection = cn; // Cambia la cadena de conexión según tu configuración
        }

        public Paciente BuscarPacienteId(int id)
        {
            Paciente paciente = null;

            using (var command = new SqlCommand("sp_obtener_paciente", _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", id);

                _connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        paciente = new Paciente
                        {
                            Id = (int)reader["Id"],
                            Nombre = (string)reader["Nombre"],
                            FechaNacimiento = (DateTime)reader["FechaNacimiento"],
                            DocumentoTipo = (string)reader["DocumentoTipo"],
                            DocumentoNumero = (string)reader["DocumentoNumero"],
                            Telefono = (string)reader["Telefono"],
                            EstadoCivil = (string)reader["EstadoCivil"],
                            Sexo = (string)reader["Sexo"],
                            Estado = (string)reader["Estado"]
                        };
                    }
                }
                _connection.Close();
            }

            return paciente;
        }

        public List<Paciente> BuscarPaciente(string nombre, int pageNumber = 1, int pageSize = 10)
        {
            var pacientes = new List<Paciente>();

            using (var command = new SqlCommand("sp_obtener_paciente_paginado", _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Nombre", nombre);
                command.Parameters.AddWithValue("@NumeroPagina", pageNumber);
                command.Parameters.AddWithValue("@TamanoPagina", pageSize);

                _connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var paciente = new Paciente
                        {
                            Id = (int)reader["Id"],
                            Nombre = (string)reader["Nombre"],
                            FechaNacimiento = (DateTime)reader["FechaNacimiento"],
                            DocumentoTipo = (string)reader["DocumentoTipo"],
                            DocumentoNumero = (string)reader["DocumentoNumero"],
                            Telefono = (string)reader["Telefono"],
                            EstadoCivil = (string)reader["EstadoCivil"],
                            Sexo = (string)reader["Sexo"],
                            Estado = (string)reader["Estado"]
                        };
                        pacientes.Add(paciente);
                    }
                }
                _connection.Close();
            }

            return pacientes;
        }

        public List<Paciente> ListarPacientes(int pagina, int tamanoPagina)
        {
            var pacientes = new List<Paciente>();

            using (var command = new SqlCommand("sp_listar_pacientes_paginado", _connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                // Añadir parámetros para la paginación
                command.Parameters.AddWithValue("@Pagina", pagina);
                command.Parameters.AddWithValue("@TamanoPagina", tamanoPagina);

                _connection.Open();

                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        pacientes.Add(new Paciente
                        {
                            Id = reader.GetInt32(0),
                            Nombre = reader.GetString(1),
                            FechaNacimiento = reader.GetDateTime(2),
                            DocumentoTipo = reader.GetString(3),
                            DocumentoNumero = reader.GetString(4),
                            Telefono = reader.GetString(5),
                            EstadoCivil = reader.GetString(6),
                            Sexo = reader.GetString(7),
                            Estado = reader.GetString(8)
                        });
                    }
                }

                _connection.Close();
            }

            return pacientes;
        }
        public void AgregarPaciente(Paciente paciente)
        {
            using (var command = new SqlCommand("sp_agregar_paciente", _connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Nombre", paciente.Nombre);
                command.Parameters.AddWithValue("@FechaNacimiento", paciente.FechaNacimiento);
                command.Parameters.AddWithValue("@DocumentoTipo", paciente.DocumentoTipo);
                command.Parameters.AddWithValue("@DocumentoNumero", paciente.DocumentoNumero);
                command.Parameters.AddWithValue("@Telefono", paciente.Telefono);
                command.Parameters.AddWithValue("@EstadoCivil", paciente.EstadoCivil);
                command.Parameters.AddWithValue("@Sexo", paciente.Sexo);
                command.Parameters.AddWithValue("@Estado", paciente.Estado);

                _connection.Open();
                command.ExecuteNonQuery();
                _connection.Close();
            }
        }

        public void ActualizarPaciente(Paciente paciente)
        {
            using (var command = new SqlCommand("sp_actualizar_paciente", _connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Id", paciente.Id);
                command.Parameters.AddWithValue("@Nombre", paciente.Nombre);
                command.Parameters.AddWithValue("@FechaNacimiento", paciente.FechaNacimiento);
                command.Parameters.AddWithValue("@DocumentoTipo", paciente.DocumentoTipo);
                command.Parameters.AddWithValue("@DocumentoNumero", paciente.DocumentoNumero);
                command.Parameters.AddWithValue("@Telefono", paciente.Telefono);
                command.Parameters.AddWithValue("@EstadoCivil", paciente.EstadoCivil);
                command.Parameters.AddWithValue("@Sexo", paciente.Sexo);
                command.Parameters.AddWithValue("@Estado", paciente.Estado);

                _connection.Open();
                command.ExecuteNonQuery();
                _connection.Close();
            }
        }

        public void EliminarPaciente(int id)
        {
            using (var command = new SqlCommand("sp_eliminar_paciente", _connection))
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
