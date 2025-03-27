using PsycoApp.DA.Interfaces;
using PsycoApp.DA.SQLConnector;
using PsycoApp.entities.DTO.DtoResponse;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Linq.Expressions;

namespace PsycoApp.DA
{
    public class PaqueteDA :IPaqueteDA
    {
        private readonly SqlConnection _connection;
        string rpta = "";
        public PaqueteDA()
        {
            var sqlConnector = new SqlConnectorMicrosoft();
            _connection = sqlConnector.GetConnection();
        }

        public async Task Actualizar(PaqueteDTO paquete)
        {
            using (var command = new SqlCommand("sp_ActualizarPaquete", _connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Id", paquete.Id);
                command.Parameters.AddWithValue("@Nombre", paquete.Nombre);
                command.Parameters.AddWithValue("@Precio", paquete.Precio);
                command.Parameters.AddWithValue("@Color", paquete.Color);
                command.Parameters.AddWithValue("@EsEvaluacion", paquete.EsEvaluacion);
                command.Parameters.AddWithValue("@NumSesiones", paquete.NumSesiones);
                command.Parameters.AddWithValue("@Siglas", paquete.Siglas);

                try
                {
                    await _connection.OpenAsync();
                    await command.ExecuteNonQueryAsync();
                }

                finally
                {
                    await _connection.CloseAsync();
                }
                
            }
        }

        public async Task<int> Eliminar(int id)
        {
            using (var command = new SqlCommand("sp_EliminarPaquete", _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", id);

                try
                {
                    await _connection.OpenAsync();
                    object result = await command.ExecuteScalarAsync();
                    return (result != null) ? Convert.ToInt32(result) : 0;
                }
                finally
                {
                    await _connection.CloseAsync();
                }
            }
        }

        public async Task Grabar(PaqueteDTO paquete)
        {
            using (var command = new SqlCommand("sp_InsertarPaquete", _connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Nombre", paquete.Nombre);
                command.Parameters.AddWithValue("@Precio", paquete.Precio);
                command.Parameters.AddWithValue("@Color", paquete.Color);
                command.Parameters.AddWithValue("@EsEvaluacion", paquete.EsEvaluacion);
                command.Parameters.AddWithValue("@NumSesiones", paquete.NumSesiones);
                command.Parameters.AddWithValue("@Siglas", paquete.Siglas);

                try
                {
                    await _connection.OpenAsync(); 
                    await command.ExecuteNonQueryAsync();
                }
                finally
                {
                    await _connection.CloseAsync(); 
                }
            }
        }


        public List<PaqueteDTO> Listar(int pagina, int tamanoPagina, ref int totalReg )
        {
            var psicologos = new List<PaqueteDTO>();

            using (var command = new SqlCommand(Procedures.sp_listar_paquetes, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Pagina", pagina);
                command.Parameters.AddWithValue("@TamanoPagina", tamanoPagina);
                // Agregamos el parámetro de salida para obtener el total de registros
                var totalRegParam = new SqlParameter("@TotalReg", SqlDbType.Int)
                {
                    Direction = ParameterDirection.Output
                };
                command.Parameters.Add(totalRegParam);
                // Agregamos el parámetro de salida para obtener el total de registros
                //var totalRegParam = new SqlParameter("@TotalReg", SqlDbType.Int);
                _connection.Open();

                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        psicologos.Add(new PaqueteDTO
                        {
                            Id = reader.GetInt32(0),
                            Nombre = reader.GetString(1),
                            Precio = reader.GetDecimal(2),
                            Color = reader.IsDBNull(3) ? string.Empty : reader.GetString(3), // Maneja NULL en Color
                            EsEvaluacion = reader.GetBoolean(4),
                            NumSesiones = reader.GetInt32(5),
                            Siglas = reader.IsDBNull(6) ? string.Empty : reader.GetString(6)  // Maneja NULL en Siglas
                        });
                    }
                }

                // Obtener el valor del parámetro de salida después de ejecutar el procedimiento
                totalReg = (int)totalRegParam.Value;
                _connection.Close();
            }

            return psicologos;
        }

    }
}
