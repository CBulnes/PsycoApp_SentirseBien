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
    public class UbigeoDA
    {
        private readonly SqlConnection _connection;
        SqlConnection cn = new SqlConnector().cadConnection_psyco;
        public UbigeoDA()
        {
            _connection = cn;
        }

        
        public List<Ubigeo> ListarUbigeos()
        {
            var ubigeos = new List<Ubigeo>();

            using (var command = new SqlCommand(Procedures.listar_ubigeos, _connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        ubigeos.Add(new Ubigeo
                        {
                            Id = reader.GetInt32(0),
                            CodUbigeo = reader.GetString(1),
                            Departamento = reader.GetString(2),
                            Provincia = reader.GetString(3),
                            Distrito = reader.GetString(4)
                        });
                    }
                }

                _connection.Close();
            }
            return ubigeos;
        }
    }
}
