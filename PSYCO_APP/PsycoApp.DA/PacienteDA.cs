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
                            Apellido = (string)reader["Apellido"],
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
                            Apellido = (string)reader["Apellido"],
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
                            Apellido = reader.GetString(2),
                            FechaNacimiento = reader.GetDateTime(3),
                            DocumentoTipo = reader.GetString(4),
                            DocumentoNumero = reader.GetString(5),
                            Telefono = reader.GetString(6),
                            EstadoCivil = reader.GetString(7),
                            Sexo = reader.GetString(8),
                            Estado = reader.GetString(9)
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
                command.Parameters.AddWithValue("@Apellido", paciente.Apellido);
                command.Parameters.AddWithValue("@FechaNacimiento", paciente.FechaNacimiento);
                command.Parameters.AddWithValue("@DocumentoTipo", paciente.DocumentoTipo);
                command.Parameters.AddWithValue("@DocumentoNumero", paciente.DocumentoNumero);
                command.Parameters.AddWithValue("@Telefono", paciente.Telefono);
                command.Parameters.AddWithValue("@EstadoCivil", paciente.EstadoCivil);
                command.Parameters.AddWithValue("@Sexo", paciente.Sexo);
                command.Parameters.AddWithValue("@Estado", paciente.Estado == null ? "1" : paciente.Estado);

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
                command.Parameters.AddWithValue("@Apellido", paciente.Apellido);
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
        
        public List<entities.Paciente> listar_pacientes_combo()
        {
            List<entities.Paciente> lista = new List<entities.Paciente>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_pacientes_combo, cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    entities.Paciente item = new entities.Paciente();
                    item.Id = Convert.ToInt32(row["id_paciente"]);
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

        public List<entities.Paciente> listar_pacientes_combo_dinamico(int page, int pageSize, string search, int sede)
        {
            List<entities.Paciente> lista = new List<entities.Paciente>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_pacientes_combo_dinamico, cn); // Procedimiento almacenado modificado
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Page", page);
                cmd.Parameters.AddWithValue("@PageSize", pageSize); // Se agrega pageSize
                cmd.Parameters.AddWithValue("@Search", search ?? string.Empty);
                cmd.Parameters.AddWithValue("@IdSede", sede);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    entities.Paciente item = new entities.Paciente();
                    item.Id = Convert.ToInt32(row["id_paciente"]);
                    item.Nombre = Convert.ToString(row["nombres"]);
                    item.id_sede = Convert.ToInt32(row["id_sede"]);
                    lista.Add(item);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                lista.Clear(); // Limpiar en caso de error
            }
            finally
            {
                cn.Close();
            }
            return lista;
        }

    }
}
