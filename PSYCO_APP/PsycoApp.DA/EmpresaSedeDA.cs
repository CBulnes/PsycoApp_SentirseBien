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

    }
}
