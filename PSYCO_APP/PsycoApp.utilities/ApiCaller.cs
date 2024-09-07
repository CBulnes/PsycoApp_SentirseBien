using Newtonsoft.Json;
using System.IO;
using System.Net;
using System.Text;

namespace PsycoApp.utilities
{
    public class ApiCaller
    {
        public static string consume_endpoint_method(string url, object obj, string method)//, string tk)
        {
            HttpWebRequest request = HttpWebRequest.Create(url) as HttpWebRequest;
            //if (!string.IsNullOrEmpty(tk))
            //{
            //    request.Headers["Authorization"] = tk;
            //}
            request.Method = method;
            request.Accept = "application/json";
            request.ContentType = "application/json";

            string api_url = Helper.GetUrlApi();

            if (api_url.Contains("https"))
            {
                request.ServerCertificateValidationCallback = (sender, cert, chain, sslPolicyErrors) => { return true; };
            }
            //request.ServerCertificateValidationCallback = delegate { return true; };

            byte[] byteArray = null;
            if (obj != null && method != "GET")
            {
                string data = JsonConvert.SerializeObject(obj);
                byteArray = Encoding.UTF8.GetBytes(data);
                request.ContentLength = byteArray.Length;

                Stream dataStream = request.GetRequestStream();
                dataStream.Write(byteArray, 0, byteArray.Length);
                dataStream.Close();
            }

            try
            {
                WebResponse ws = request.GetResponse();
                using (Stream stream = ws.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(stream, Encoding.UTF8);
                    string response = reader.ReadToEnd();

                    if (response == "\"OK\"")
                    {
                        response = "OK";
                    }
                    return response;
                }
            }
            catch (WebException e)
            {
                string pageContent = new StreamReader(e.Response.GetResponseStream()).ReadToEnd().ToString();
                throw;
            }
        }


    }
}
