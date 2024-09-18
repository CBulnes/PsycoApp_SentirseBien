using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;

namespace PsycoApp.utilities
{
    public class Helper
    {
        public static bool ValidarCorreo(string email)
        {
            bool res = Regex.IsMatch(email, @"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z", RegexOptions.IgnoreCase);
            return res;
        }

        public static bool validar_mayusculas(string psw)
        {
            int cont_l = Regex.Matches(psw, @"[A-Z]").Count;

            if (cont_l > 0)
            {
                return true;
            }
            return false;
        }

        public static bool validar_minusculas(string psw)
        {
            int cont_l = Regex.Matches(psw, @"[a-z]").Count;

            if (cont_l > 0)
            {
                return true;
            }
            return false;
        }

        public static bool validar_numeros(string psw)
        {
            int cont_n = Regex.Matches(psw, @"[0-9]").Count;

            if (cont_n > 0)
            {
                return true;
            }
            return false;
        }

        public static bool validar_caracteres_especiales(string psw)
        {
            string[] lista_ec = new string[] { "#", "$", "%", "&", ".", "-", "_", "*", "?", "¿", "!", "¡", "+", "," };

            foreach (var item in lista_ec)
            {
                if (psw.Contains(item))
                {
                    return true;
                }
            }
            return false;
        }

        #region "CONNECTION STRING"
        public static string GetUrlApi()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("AppSettings").GetSection("API_URL").Value;
            return data;
        }
        public static string GetUrlSite()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("AppSettings").GetSection("SITE_URL").Value;
            return data;
        }
        public static string GetNombreSite()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("AppSettings").GetSection("NOMBRE_SITE").Value;
            return data;
        }
        #endregion


        #region "CONFIGURATION"
        public static string GetLogErrorActivo()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Configuration").GetSection("LOG_ERROR_ACTIVO").Value;
            return data;
        }
        public static string GetLogTransacActivo()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Configuration").GetSection("LOG_TRANSAC_ACTIVO").Value;
            return data;
        }
        public static string GetRutaLogError()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Configuration").GetSection("RUTA_LOG_ERROR").Value;
            return data;
        }
        public static string GetRutaLogTransac()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Configuration").GetSection("RUTA_LOG_TRANSAC").Value;
            return data;
        }
        #endregion


        #region "WATSON"
        public static string GetApiKey()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Watson").GetSection("Api_key").Value;
            return data;
        }
        public static string GetVersion()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Watson").GetSection("Version").Value;
            return data;
        }
        public static string GetUrlAsistente()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Watson").GetSection("Url_asistente").Value;
            return data;
        }
        public static string GetIdAsistente()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Watson").GetSection("Id_asistente").Value;
            return data;
        }
        #endregion


        #region "CONTACTO"
        public static string GetCallCenter()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Contacto").GetSection("Call_center").Value;
            return data;
        }
        public static string GetCallCenterInvitado()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Contacto").GetSection("Call_center_invitado").Value;
            return data;
        }
        public static string GetHorario()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Contacto").GetSection("Horario_atencion").Value;
            return data;
        }
        public static string GetWhatsapp()
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);

            var root = configurationBuilder.Build();
            string data = root.GetSection("Contacto").GetSection("Whatsapp").Value;
            return data;
        }
        #endregion

        public static DataTable ToDataTable<T>(List<T> items)
        {
            DataTable dataTable = new DataTable(typeof(T).Name);
            //Get all the properties
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Setting column names as Property names
                dataTable.Columns.Add(prop.Name);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    //inserting property values to datatable rows
                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }
            //put a breakpoint here and check datatable
            return dataTable;
        }
    }
}
