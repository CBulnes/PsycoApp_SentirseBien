using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;

namespace PsycoApp.DA
{
    public class EmpresaSedeDA
    {
        public List<Empresa> ListarEmpresas()
        {
            var empresas = new List<Empresa>();
            using (var cn = new SqlConnector().cadConnection_psyco)
            using (var cmd = new SqlCommand("SP_ADMIN_LISTAR_EMPRESAS", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        empresas.Add(new Empresa
                        {
                            Id = Convert.ToInt32(reader["Id"]),
                            Nombre = Convert.ToString(reader["Nombre"]),
                            Estado = Convert.ToBoolean(reader["Estado"])
                        });
                    }
                }
            }
            return empresas;
        }

        public int CrearEmpresa(Empresa empresa)
        {
            using (var cn = new SqlConnector().cadConnection_psyco)
            using (var cmd = new SqlCommand("SP_ADMIN_CREAR_EMPRESA", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Nombre", SqlDbType.VarChar, 200).Value = empresa.Nombre;
                cn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public bool EmpresaActiva(int idEmpresa)
        {
            using (var cn = new SqlConnector().cadConnection_psyco)
            using (var cmd = new SqlCommand("SELECT CASE WHEN EXISTS (SELECT 1 FROM dbo.tbl_empresa WHERE Id = @IdEmpresa AND Estado = 1) THEN 1 ELSE 0 END", cn))
            {
                cmd.Parameters.Add("@IdEmpresa", SqlDbType.Int).Value = idEmpresa;
                cn.Open();
                return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }

        public bool SedePerteneceEmpresaActiva(int idSede, int idEmpresa)
        {
            using (var cn = new SqlConnector().cadConnection_psyco)
            using (var cmd = new SqlCommand("SELECT CASE WHEN EXISTS (SELECT 1 FROM dbo.tbl_sede s INNER JOIN dbo.tbl_empresa e ON e.Id = s.Id_empresa WHERE s.Id = @IdSede AND s.Id_empresa = @IdEmpresa AND s.Estado = 1 AND e.Estado = 1) THEN 1 ELSE 0 END", cn))
            {
                cmd.Parameters.Add("@IdSede", SqlDbType.Int).Value = idSede;
                cmd.Parameters.Add("@IdEmpresa", SqlDbType.Int).Value = idEmpresa;
                cn.Open();
                return Convert.ToBoolean(cmd.ExecuteScalar());
            }
        }

        public List<Sede> ListarSedes(int idEmpresa)
        {
            var sedes = new List<Sede>();
            using (var cn = new SqlConnector().cadConnection_psyco)
            using (var cmd = new SqlCommand("SP_ADMIN_LISTAR_SEDES", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdEmpresa", SqlDbType.Int).Value = idEmpresa;
                cn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        sedes.Add(new Sede
                        {
                            Id = Convert.ToInt32(reader["Id"]),
                            Nombre = Convert.ToString(reader["Nombre"]),
                            Estado = reader["Estado"] != DBNull.Value && Convert.ToBoolean(reader["Estado"]),
                            Centro = reader["Centro"] == DBNull.Value ? string.Empty : Convert.ToString(reader["Centro"]),
                            IdEmpresa = Convert.ToInt32(reader["Id_empresa"])
                        });
                    }
                }
            }
            return sedes;
        }

        public int CrearSede(Sede sede)
        {
            using (var cn = new SqlConnector().cadConnection_psyco)
            using (var cmd = new SqlCommand("SP_ADMIN_CREAR_SEDE", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Nombre", SqlDbType.VarChar, 200).Value = sede.Nombre;
                cmd.Parameters.Add("@Centro", SqlDbType.VarChar, 100).Value = string.IsNullOrWhiteSpace(sede.Centro) ? (object)DBNull.Value : sede.Centro;
                cmd.Parameters.Add("@IdEmpresa", SqlDbType.Int).Value = sede.IdEmpresa;
                cn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public int CrearUsuario(UsuarioEmpresa usuario)
        {
            using (var cn = new SqlConnector().cadConnection_psyco)
            using (var cmd = new SqlCommand("SP_ADMIN_CREAR_USUARIO_EMPRESA", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Nombres", SqlDbType.VarChar, 100).Value = usuario.Nombres;
                cmd.Parameters.Add("@Apellidos", SqlDbType.VarChar, 100).Value = usuario.Apellidos;
                cmd.Parameters.Add("@Usuario", SqlDbType.VarChar, 100).Value = usuario.Usuario;
                cmd.Parameters.Add("@Password", SqlDbType.VarChar, 50).Value = usuario.Password;
                cmd.Parameters.Add("@IdTipoUsuario", SqlDbType.Int).Value = usuario.IdTipoUsuario;
                cmd.Parameters.Add("@IdEmpresa", SqlDbType.Int).Value = usuario.IdEmpresa;
                cmd.Parameters.Add("@IdSede", SqlDbType.Int).Value = usuario.IdSede;
                cn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public RegistroSaasEmpresa RegistrarEmpresaPrueba(RegistroSaasEmpresa registro)
        {
            using (var cn = new SqlConnector().cadConnection_psyco)
            using (var cmd = new SqlCommand("SP_SAAS_REGISTRAR_EMPRESA_PRUEBA", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Empresa", SqlDbType.VarChar, 200).Value = registro.Empresa;
                cmd.Parameters.Add("@Sede", SqlDbType.VarChar, 200).Value = registro.Sede;
                cmd.Parameters.Add("@Nombres", SqlDbType.VarChar, 100).Value = registro.Nombres;
                cmd.Parameters.Add("@Apellidos", SqlDbType.VarChar, 100).Value = registro.Apellidos;
                cmd.Parameters.Add("@Usuario", SqlDbType.VarChar, 100).Value = registro.Usuario;
                cmd.Parameters.Add("@Password", SqlDbType.VarChar, 50).Value = registro.Password;
                cn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    if (!reader.Read())
                        throw new InvalidOperationException("No se recibió la confirmación del registro.");

                    registro.IdEmpresa = Convert.ToInt32(reader["IdEmpresa"]);
                    registro.IdSede = Convert.ToInt32(reader["IdSede"]);
                    registro.IdUsuario = Convert.ToInt32(reader["IdUsuario"]);
                }
            }
            return registro;
        }

    }
}
