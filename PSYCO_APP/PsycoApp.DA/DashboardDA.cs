using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using System;
using System.Data;
using Microsoft.Data.SqlClient;

namespace PsycoApp.DA
{
    public class DashboardDA
    {
        public DashboardData Obtener(DateTime inicioSemana, DateTime finSemana, DateTime ahoraLocal, int idSede, int idUsuario, int idDoctor, int tipoUsuario, string login)
        {
            var resultado = new DashboardData();

            using (var conexion = new SqlConnector().cadConnection_psyco)
            using (var comando = new SqlCommand("dbo.SP_DASHBOARD_RESUMEN", conexion))
            {
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.Add("@InicioSemana", SqlDbType.Date).Value = inicioSemana.Date;
                comando.Parameters.Add("@FinSemana", SqlDbType.Date).Value = finSemana.Date;
                comando.Parameters.Add("@AhoraLocalSolicitado", SqlDbType.DateTime).Value = ahoraLocal;
                comando.Parameters.Add("@IdSede", SqlDbType.Int).Value = idSede;
                comando.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = idUsuario;
                comando.Parameters.Add("@IdDoctor", SqlDbType.Int).Value = idDoctor;
                comando.Parameters.Add("@TipoUsuario", SqlDbType.Int).Value = tipoUsuario;
                comando.Parameters.Add("@Login", SqlDbType.VarChar, 100).Value = string.IsNullOrWhiteSpace(login) ? (object)DBNull.Value : login;

                conexion.Open();
                using (var reader = comando.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        resultado.CitasHoy = GetInt(reader, "CitasHoy");
                        resultado.CitasCitadasHoy = GetInt(reader, "CitasCitadasHoy");
                        resultado.CitasConfirmadasHoy = GetInt(reader, "CitasConfirmadasHoy");
                        resultado.CitasAtendidasHoy = GetInt(reader, "CitasAtendidasHoy");
                        resultado.PacientesTotal = GetInt(reader, "PacientesTotal");
                        resultado.PacientesMes = GetInt(reader, "PacientesMes");
                        resultado.EspecialistasDisponibles = GetInt(reader, "EspecialistasDisponibles");
                        resultado.EspecialistasTotal = GetInt(reader, "EspecialistasTotal");
                        resultado.IngresosHoy = GetDecimal(reader, "IngresosHoy");
                        resultado.CajaAbierta = GetBool(reader, "CajaAbierta");
                        resultado.EstadoCaja = GetString(reader, "EstadoCaja");
                        resultado.FechaActual = GetDateTime(reader, "FechaActual");
                    }

                    if (reader.NextResult())
                    {
                        while (reader.Read())
                        {
                            resultado.PacientesAtendidos = GetInt(reader, "PacientesAtendidos");
                            resultado.PacientesCitados = GetInt(reader, "PacientesCitados");
                            resultado.PacientesConfirmados = GetInt(reader, "PacientesConfirmados");
                            resultado.PacientesPorAtender = GetInt(reader, "PacientesPorAtender");
                        }
                    }

                    if (reader.NextResult())
                    {
                        while (reader.Read())
                        {
                            resultado.IngresosPorFormaPago[GetString(reader, "FormaPago")] = GetDecimal(reader, "Importe");
                        }
                    }

                    if (reader.NextResult())
                    {
                        while (reader.Read())
                        {
                            resultado.ProximasCitas.Add(new DashboardCitaData
                            {
                                Id = GetInt(reader, "Id"),
                                Fecha = GetDateTime(reader, "Fecha"),
                                Hora = GetString(reader, "Hora"),
                                Paciente = GetString(reader, "Paciente"),
                                Especialista = GetString(reader, "Especialista"),
                                Servicio = GetString(reader, "Servicio"),
                                Estado = GetString(reader, "Estado")
                            });
                        }
                    }

                    if (reader.NextResult())
                    {
                        while (reader.Read())
                        {
                            resultado.ActividadSemanal.Add(new DashboardDiaData
                            {
                                Fecha = GetDateTime(reader, "Fecha"),
                                Citas = GetInt(reader, "Citas"),
                                Pacientes = GetInt(reader, "Pacientes"),
                                Ingresos = GetDecimal(reader, "Ingresos")
                            });
                        }
                    }

                    if (reader.NextResult())
                    {
                        while (reader.Read())
                        {
                            resultado.ActividadReciente.Add(new DashboardActividadData
                            {
                                Tipo = GetString(reader, "Tipo"),
                                Titulo = GetString(reader, "Titulo"),
                                Descripcion = GetString(reader, "Descripcion"),
                                Fecha = GetDateTime(reader, "Fecha")
                            });
                        }
                    }
                }
            }

            return resultado;
        }

        private static int GetInt(SqlDataReader reader, string columna)
        {
            var indice = reader.GetOrdinal(columna);
            return reader.IsDBNull(indice) ? 0 : Convert.ToInt32(reader.GetValue(indice));
        }

        private static decimal GetDecimal(SqlDataReader reader, string columna)
        {
            var indice = reader.GetOrdinal(columna);
            return reader.IsDBNull(indice) ? 0m : Convert.ToDecimal(reader.GetValue(indice));
        }

        private static bool GetBool(SqlDataReader reader, string columna)
        {
            var indice = reader.GetOrdinal(columna);
            return !reader.IsDBNull(indice) && Convert.ToBoolean(reader.GetValue(indice));
        }

        private static string GetString(SqlDataReader reader, string columna)
        {
            var indice = reader.GetOrdinal(columna);
            return reader.IsDBNull(indice) ? string.Empty : Convert.ToString(reader.GetValue(indice));
        }

        private static DateTime GetDateTime(SqlDataReader reader, string columna)
        {
            var indice = reader.GetOrdinal(columna);
            return reader.IsDBNull(indice) ? DateTime.MinValue : Convert.ToDateTime(reader.GetValue(indice));
        }

    }
}
