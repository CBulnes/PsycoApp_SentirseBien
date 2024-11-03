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
    public class ProductoDA
    {
        private readonly SqlConnection _connection;
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        public ProductoDA()
        {
            _connection = cn;
        }

        public List<entities.Producto> listar_productos_combo()
        {
            List<entities.Producto> lista = new List<entities.Producto>();
            try
            {
                cn.Open();
                SqlCommand cmd = new SqlCommand(Procedures.sp_listar_productos_combo, cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    entities.Producto item = new entities.Producto();
                    item.Id = Convert.ToInt32(row["Id"]);
                    item.Nombre = Convert.ToString(row["Nombre"]);
                    item.Alias = Convert.ToString(row["Alias"]);
                    item.Precio = Convert.ToString(row["Precio"]);
                    item.Color = Convert.ToString(row["Color"]);
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
