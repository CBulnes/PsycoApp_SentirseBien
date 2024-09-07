using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Text;

namespace PsycoApp.DA.SQLConnector
{
    public class SqlConnector
    {
        public string _connectionString = string.Empty;

        public SqlConnection cadConnection_psyco
        {
            get
            {
                var configurationBuilder = new ConfigurationBuilder();
                var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");

                configurationBuilder.AddJsonFile(path, false);
                var root = configurationBuilder.Build();
                _connectionString = root.GetSection("ConnectionStrings").GetSection("db_psycoContext").Value;

                SqlConnection cn = new SqlConnection(_connectionString);
                return cn;
            }
        }

        public static void Cerrar_conexion(SqlConnection conexion)
        {
            if (conexion.State.ToString() == "Open")
            {
                conexion.Close();
            }
        }


    }
}
