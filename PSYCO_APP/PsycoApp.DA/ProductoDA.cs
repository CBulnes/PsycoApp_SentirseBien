using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Text;
using PsycoApp.entities;
using PsycoApp.DA.SQLConnector;
using PsycoApp.utilities;

namespace PsycoApp.DA
{
    public class ProductoDA
    {
        private readonly SqlConnection _connection;
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        public ProductoDA()
        {
            _connection = cn;
        }

        public List<entities.Producto> listar_productos_combo(int idEmpresa)
        {
            List<entities.Producto> lista = new List<entities.Producto>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_productos_combo, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id_empresa", SqlDbType.Int).Value = idEmpresa;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    entities.Producto item = new entities.Producto();
                    item.Id = Convert.ToInt32(row["Id"]);
                    item.Id_empresa = idEmpresa;
                    item.Nombre = Convert.ToString(row["Nombre"]);
                    item.Alias = Convert.ToString(row["Alias"]);
                    item.Precio = Convert.ToString(row["Precio"]);
                    item.Color = Convert.ToString(row["Color"]);
                    item.NumSesiones = Convert.ToInt32(row["NumSesiones"]);
                    lista.Add(item);
                }
            }
            catch (Exception)
            {
                lista.Clear();
            }
            cn.Close();
            return lista;
        }

        public List<entities.Producto> listar_mantenimiento(int idEmpresa)
        {
            var lista = new List<entities.Producto>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_admin_productos_listar, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id_empresa", SqlDbType.Int).Value = idEmpresa;
                var dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                foreach (DataRow row in dt.Rows)
                {
                    lista.Add(new entities.Producto
                    {
                        Id = Convert.ToInt32(row["Id"]),
                        Id_empresa = Convert.ToInt32(row["Id_empresa"]),
                        Nombre = Convert.ToString(row["Nombre"]),
                        Precio = Convert.ToString(row["Precio"]),
                        Color = Convert.ToString(row["Color"]),
                        EsEvaluacion = Convert.ToBoolean(row["EsEvaluacion"]),
                        NumSesiones = Convert.ToInt32(row["NumSesiones"]),
                        Siglas = Convert.ToString(row["Siglas"]),
                        Mostrar = Convert.ToInt32(row["Mostrar"])
                    });
                }
            }
            finally
            {
                cn.Close();
            }
            return lista;
        }

        public int guardar(entities.Producto producto, int idEmpresa)
        {
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_admin_producto_guardar, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = producto.Id;
                cmd.Parameters.Add("@Id_empresa", SqlDbType.Int).Value = idEmpresa;
                cmd.Parameters.Add("@Nombre", SqlDbType.NVarChar, 100).Value = producto.Nombre;
                cmd.Parameters.Add("@Precio", SqlDbType.Decimal).Value = decimal.Parse(producto.Precio, System.Globalization.CultureInfo.InvariantCulture);
                cmd.Parameters.Add("@Color", SqlDbType.Char, 7).Value = string.IsNullOrWhiteSpace(producto.Color) ? (object)DBNull.Value : producto.Color;
                cmd.Parameters.Add("@EsEvaluacion", SqlDbType.Bit).Value = producto.EsEvaluacion;
                cmd.Parameters.Add("@NumSesiones", SqlDbType.Int).Value = producto.NumSesiones;
                cmd.Parameters.Add("@Siglas", SqlDbType.VarChar, 10).Value = string.IsNullOrWhiteSpace(producto.Siglas) ? (object)DBNull.Value : producto.Siglas;
                cmd.Parameters.Add("@Mostrar", SqlDbType.Int).Value = producto.Mostrar;
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
            finally
            {
                cn.Close();
            }
        }

        public bool eliminar(int id, int idEmpresa)
        {
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_admin_producto_eliminar, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = id;
                cmd.Parameters.Add("@Id_empresa", SqlDbType.Int).Value = idEmpresa;
                return Convert.ToInt32(cmd.ExecuteScalar()) == 1;
            }
            finally
            {
                cn.Close();
            }
        }

    }
}
