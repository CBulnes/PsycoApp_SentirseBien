using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using PsycoApp.entities;
using PsycoApp.DA.SQLConnector;
using PsycoApp.utilities;
using System.Collections;
using System.Linq;

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
                            IdSedeSecundaria = (int)reader["IdSedeSecundaria"],
                            IdSedeTerciaria = (int)reader["IdSedeTerciaria"]
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
            try
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
                                Estado = (string)reader["Estado"],
                                IdSedePrincipal = (int)reader["IdSedePrincipal"],
                                IdSedeSecundaria = (int)reader["IdSedeSecundaria1"],
                                IdSedeSecundaria2 = (int)reader["IdSedeSecundaria2"],
                                Sedes = (string)reader["Sedes"]
                            };
                            psicologos.Add(psicologo);
                        }
                    }
                    _connection.Close();
                }

                return psicologos;
            }
            catch (Exception e)
            {
                var message = e.Message.ToString();
                throw;
            }
           
        }

        public List<Psicologo> ListarPsicologos(int pagina, int tamanoPagina)
        {
            try
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
                                Estado = (string)reader["Estado"],
                                IdSedePrincipal = (int)reader["IdSedePrincipal"],
                                IdSedeSecundaria = (int)reader["IdSedeSecundaria1"],
                                IdSedeSecundaria2 = (int)reader["IdSedeSecundaria2"],
                                Sedes = (string)reader["Sedes"]
                            });
                        }
                    }

                    _connection.Close();
                }

                return psicologos;
            }
            catch (Exception ex)
            {
                var msg = ex.Message.ToString();
                var stack = ex.StackTrace.ToString();

            }
            finally
            {
                _connection.Close();
            }
            return new List<Psicologo>();
        }

        public List<Psicologo> ListarPsicologosPorEmpresa(int pagina, int tamanoPagina, int idEmpresa, int? idSede = null)
        {
            var psicologos = new List<Psicologo>();
            var procedure = idSede.HasValue ? Procedures.listar_psicologos_empresa_sede : Procedures.listar_psicologos_empresa;
            using (var command = new SqlCommand(procedure, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@Pagina", SqlDbType.Int).Value = pagina;
                command.Parameters.Add("@TamanoPagina", SqlDbType.Int).Value = tamanoPagina;
                command.Parameters.Add("@IdEmpresa", SqlDbType.Int).Value = idEmpresa;
                if (idSede.HasValue)
                    command.Parameters.Add("@IdSede", SqlDbType.Int).Value = idSede.Value;
                _connection.Open();
                try
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            psicologos.Add(new Psicologo
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                Nombre = Convert.ToString(reader["Nombre"]),
                                Apellido = Convert.ToString(reader["Apellido"]),
                                FechaNacimiento = Convert.ToDateTime(reader["FechaNacimiento"]),
                                DocumentoTipo = Convert.ToString(reader["DocumentoTipo"]),
                                DocumentoNumero = Convert.ToString(reader["DocumentoNumero"]),
                                Telefono = Convert.ToString(reader["Telefono"]),
                                Refrigerio = Convert.ToString(reader["Refrigerio"]),
                                Especialidad = Convert.ToInt32(reader["Especialidad"]),
                                Direccion = Convert.ToString(reader["Direccion"]),
                                Distrito = Convert.ToString(reader["Distrito"]),
                                Estado = Convert.ToString(reader["Estado"]),
                                IdSedePrincipal = Convert.ToInt32(reader["IdSedePrincipal"]),
                                IdSedeSecundaria = Convert.ToInt32(reader["IdSedeSecundaria1"]),
                                IdSedeSecundaria2 = Convert.ToInt32(reader["IdSedeSecundaria2"]),
                                Sedes = Convert.ToString(reader["Sedes"])
                            });
                        }
                    }
                }
                finally
                {
                    _connection.Close();
                }
            }
            AplicarEstadoCredenciales(psicologos);
            return psicologos;
        }

        public List<Psicologo> BuscarPsicologoPorEmpresa(string nombre, int idEmpresa, int? idSede = null)
        {
            var psicologos = new List<Psicologo>();
            var procedure = idSede.HasValue ? Procedures.buscar_psicologos_empresa_sede : Procedures.buscar_psicologos_empresa;
            using (var command = new SqlCommand(procedure, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@Nombre", SqlDbType.NVarChar, 100).Value = nombre ?? string.Empty;
                command.Parameters.Add("@IdEmpresa", SqlDbType.Int).Value = idEmpresa;
                if (idSede.HasValue)
                    command.Parameters.Add("@IdSede", SqlDbType.Int).Value = idSede.Value;
                _connection.Open();
                try
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            psicologos.Add(new Psicologo
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                Nombre = Convert.ToString(reader["Nombre"]),
                                Apellido = Convert.ToString(reader["Apellido"]),
                                FechaNacimiento = Convert.ToDateTime(reader["FechaNacimiento"]),
                                DocumentoTipo = Convert.ToString(reader["DocumentoTipo"]),
                                DocumentoNumero = Convert.ToString(reader["DocumentoNumero"]),
                                Telefono = Convert.ToString(reader["Telefono"]),
                                Refrigerio = Convert.ToString(reader["Refrigerio"]),
                                Especialidad = Convert.ToInt32(reader["Especialidad"]),
                                Direccion = Convert.ToString(reader["Direccion"]),
                                Distrito = Convert.ToString(reader["Distrito"]),
                                Estado = Convert.ToString(reader["Estado"]),
                                IdSedePrincipal = Convert.ToInt32(reader["IdSedePrincipal"]),
                                IdSedeSecundaria = Convert.ToInt32(reader["IdSedeSecundaria1"]),
                                IdSedeSecundaria2 = Convert.ToInt32(reader["IdSedeSecundaria2"]),
                                Sedes = Convert.ToString(reader["Sedes"])
                            });
                        }
                    }
                }
                finally
                {
                    _connection.Close();
                }
            }
            AplicarEstadoCredenciales(psicologos);
            return psicologos;
        }

        private void AplicarEstadoCredenciales(List<Psicologo> psicologos)
        {
            if (psicologos == null || psicologos.Count == 0)
                return;

            var parametros = psicologos.Select((psicologo, index) => "@Id" + index).ToArray();
            var consulta = "SELECT p.Id, CONVERT(BIT, CASE WHEN NULLIF(LTRIM(RTRIM(u.email)), '') IS NULL THEN 0 ELSE 1 END) AS TieneUsuario " +
                "FROM dbo.tbl_psicologo p LEFT JOIN dbo.tbl_usuario u ON u.id_tipousuario = 4 AND u.num_documento = p.DocumentoNumero " +
                "WHERE p.Id IN (" + string.Join(",", parametros) + ")";

            using (var command = new SqlCommand(consulta, _connection))
            {
                for (var i = 0; i < psicologos.Count; i++)
                    command.Parameters.Add(parametros[i], SqlDbType.Int).Value = psicologos[i].Id;

                _connection.Open();
                try
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var psicologo = psicologos.FirstOrDefault(item => item.Id == Convert.ToInt32(reader["Id"]));
                            if (psicologo != null)
                                psicologo.TieneUsuario = Convert.ToBoolean(reader["TieneUsuario"]);
                        }
                    }
                }
                finally
                {
                    _connection.Close();
                }
            }
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
                command.Parameters.AddWithValue("@IdSedeTerciaria", psicologo.IdSedeTerciaria);
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

        public void GuardarCredencialesPsicologo(int idPsicologo, int idSede, string email, string password)
        {
            using (var command = new SqlCommand(Procedures.guardar_credenciales_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@IdPsicologo", SqlDbType.Int).Value = idPsicologo;
                command.Parameters.Add("@IdSede", SqlDbType.Int).Value = idSede;
                command.Parameters.Add("@Email", SqlDbType.VarChar, 100).Value = email;
                command.Parameters.Add("@Password", SqlDbType.VarChar, 300).Value = password;

                _connection.Open();
                try
                {
                    command.ExecuteNonQuery();
                }
                finally
                {
                    _connection.Close();
                }
            }
        }

        public Usuario ObtenerCredencialesPsicologo(int idPsicologo, int idSede)
        {
            using (var command = new SqlCommand(Procedures.obtener_credenciales_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@IdPsicologo", SqlDbType.Int).Value = idPsicologo;
                command.Parameters.Add("@IdSede", SqlDbType.Int).Value = idSede;
                _connection.Open();
                try
                {
                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read())
                            return null;

                        return new Usuario
                        {
                            id_usuario = Convert.ToInt32(reader["IdUsuario"]),
                            id_psicologo = idPsicologo,
                            email = Convert.ToString(reader["Login"])
                        };
                    }
                }
                finally
                {
                    _connection.Close();
                }
            }
        }

        public void ActualizarPasswordPsicologo(int idPsicologo, int idSede, string password)
        {
            using (var command = new SqlCommand(Procedures.actualizar_password_psicologo, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@IdPsicologo", SqlDbType.Int).Value = idPsicologo;
                command.Parameters.Add("@IdSede", SqlDbType.Int).Value = idSede;
                command.Parameters.Add("@Password", SqlDbType.VarChar, 300).Value = password;
                _connection.Open();
                try
                {
                    command.ExecuteNonQuery();
                }
                finally
                {
                    _connection.Close();
                }
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
                command.Parameters.AddWithValue("@IdSedeTerciaria", psicologo.IdSedeTerciaria);
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
                    item.Sedes = Convert.ToString(row["sedes"]);
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

        public List<entities.Usuario> listar_usuarios_caja_combo(int idEmpresa, int idSede)
        {
            List<entities.Usuario> lista = new List<entities.Usuario>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand("SP_LISTAR_USUARIOS_CAJA_COMBO", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdEmpresa", SqlDbType.Int).Value = idEmpresa;
                cmd.Parameters.Add("@IdSede", SqlDbType.Int).Value = idSede;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                foreach (DataRow row in dt.Rows)
                {
                    entities.Usuario item = new entities.Usuario();
                    item.id_usuario = Convert.ToInt32(row["id_usuario"]);
                    item.nombres = Convert.ToString(row["nombres"]);
                    item.sedes = Convert.ToString(row["sedes"]);
                    item.id_sede = Convert.ToInt32(row["id_sede"]);
                    item.id_empresa = Convert.ToInt32(row["id_empresa"]);
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
                cmd.Parameters.AddWithValue("@id_psicologo", id_usuario);

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

        public List<entities.Horario> horarios_psicologo(int id_psicologo, string inicio, string fin, string dias)
        {
            List<entities.Horario> lista = new List<entities.Horario>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_horario_psicologo, cn);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_psicologo", SqlDbType.Int).Value = id_psicologo;
                cmd.Parameters.Add("@inicio", SqlDbType.VarChar).Value = inicio;
                cmd.Parameters.Add("@fin", SqlDbType.VarChar).Value = fin;
                cmd.Parameters.Add("@dias", SqlDbType.VarChar).Value = dias;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    entities.Horario item = new entities.Horario();
                    item.Orden = Convert.ToInt32(row["Orden"]);
                    item.Id = Convert.ToInt32(row["Id"]);
                    item.Fecha = Convert.ToString(row["Fecha"]);
                    item.NombreDia = Convert.ToString(row["NombreDia"]);
                    item.Inicio = Convert.ToString(row["Inicio"]);
                    item.Refrigerio = Convert.ToString(row["Refrigerio"]);
                    item.Fin = Convert.ToString(row["Fin"]);
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

        public List<entities.Horario> vacaciones_psicologo(int id_psicologo, string inicio, string fin, int año)
        {
            List<entities.Horario> lista = new List<entities.Horario>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_vacaciones_psicologo, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id_psicologo", SqlDbType.Int).Value = id_psicologo;
                cmd.Parameters.Add("@inicio", SqlDbType.VarChar).Value = inicio;
                cmd.Parameters.Add("@fin", SqlDbType.VarChar).Value = fin;
                cmd.Parameters.Add("@año", SqlDbType.Int).Value = año;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    entities.Horario item = new entities.Horario();
                    item.Orden = Convert.ToInt32(row["Orden"]);
                    item.Id = Convert.ToInt32(row["Id"]);
                    item.Fecha = Convert.ToString(row["Fecha"]);
                    item.NombreDia = Convert.ToString(row["NombreDia"]);
                    item.Eliminar = Convert.ToInt32(row["Eliminar"]);
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

        public RespuestaUsuario guardar_horarios_psicologo(List<entities.Horario> lista)
        {
            var res = new RespuestaUsuario();
            DataTable dtHorarios = Helper.ToDataTable(lista);
            using (var command = new SqlCommand(Procedures.sp_guardar_horario_psicologo, _connection))
            {
                try
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@HorariosPsicologo", dtHorarios);
                    _connection.Open();
                    command.ExecuteNonQuery();
                    res.estado = true;
                }
                catch (Exception)
                {
                    res.estado = false;
                    res.descripcion = "Ocurrió un error al guardar los horarios.";
                }
                finally
                {
                    _connection.Close();
                }
            }
            return res;
        }

        public RespuestaUsuario guardar_horarios_psicologo_v2(entities.Horario item)
        {
            var res = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_guardar_horario_psicologo_v2, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = item.Id;
                cmd.Parameters.Add("@IdPsicologo", SqlDbType.Int).Value = item.IdPsicologo;
                cmd.Parameters.Add("@Fecha", SqlDbType.VarChar).Value = item.Fecha;
                cmd.Parameters.Add("@Inicio", SqlDbType.VarChar).Value = item.Inicio;
                cmd.Parameters.Add("@Refrigerio", SqlDbType.VarChar).Value = item.Refrigerio;
                cmd.Parameters.Add("@Fin", SqlDbType.VarChar).Value = item.Fin;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                res.estado = true;
            }
            catch (Exception e)
            {
                res.estado = false;
                res.descripcion = "Ocurrió un error al guardar los horarios.";
            }
            cn.Close();
            return res;
        }

        public RespuestaUsuario guardar_vacaciones_psicologo(entities.Horario item, int totalEliminar)
        {
            var res = new RespuestaUsuario();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_guardar_vacaciones_psicologo, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = item.Id;
                cmd.Parameters.Add("@IdPsicologo", SqlDbType.Int).Value = item.IdPsicologo;
                cmd.Parameters.Add("@Fecha", SqlDbType.VarChar).Value = item.Fecha;
                cmd.Parameters.Add("@Eliminar", SqlDbType.Int).Value = item.Eliminar;
                cmd.Parameters.Add("@TotalEliminar", SqlDbType.Int).Value = totalEliminar;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    res.estado = Convert.ToString(row["rpta"]) == "OK" ? true : false;
                }
            }
            catch (Exception e)
            {
                res.estado = false;
                res.descripcion = "Ocurrió un error al guardar las vacaciones.";
            }
            cn.Close();
            return res;
        }

    }
}