using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PsycoApp.utilities
{
    public class RandomUtilities
    {
        private static Random random = new Random();
        public string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length).Select(s => s[random.Next(s.Length)]).ToArray());
        }

        public string CurrentDate()
        {
            var time = DateTime.Now;
            string formattedTime = time.ToString("yyyyMMddhhmmss");
            return formattedTime;
        }

        public static string fecha_formato(string fecha, string formato)
        {
            string fecha_rt = "";

            if (formato == "dd-mm-yyyy")
            {
                fecha_rt = fecha.Substring(8,2) + "-" + fecha.Substring(5,2) + "-" + fecha.Substring(0,4);
            } else
            {
                fecha_rt = fecha;
            }
            return fecha_rt;
        }
    }
}
