using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.DA;
using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.utilities;

namespace PsycoApp.BL
{
    public class CentroAtencionBL
    {
        CentroAtencionDA centroAtencionDA = new CentroAtencionDA();

        public List<CentroAtencion> listar_centros_atencion(string latitud, string longitud, string main_path, string random_str)
        {
            return centroAtencionDA.listar_centros_atencion(latitud, longitud, main_path, random_str);
        }
    }
}
