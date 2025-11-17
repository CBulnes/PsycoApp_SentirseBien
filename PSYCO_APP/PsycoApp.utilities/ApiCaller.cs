using Newtonsoft.Json;
using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

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

        public static async Task<string> consume_endpoint_method_async(string url, object obj, string method)
        {
            using (HttpClientHandler handler = new HttpClientHandler())
            {
                // Permitir certificados no válidos como tu versión original
                handler.ServerCertificateCustomValidationCallback = (sender, cert, chain, sslPolicyErrors) => true;

                using (HttpClient client = new HttpClient(handler))
                {
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(
                        new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json")
                    );

                    HttpResponseMessage response;

                    if (method == "GET")
                    {
                        response = await client.GetAsync(url);
                    }
                    else
                    {
                        string json = JsonConvert.SerializeObject(obj);
                        var content = new StringContent(json, Encoding.UTF8, "application/json");

                        switch (method)
                        {
                            case "POST":
                                response = await client.PostAsync(url, content);
                                break;

                            case "PUT":
                                response = await client.PutAsync(url, content);
                                break;

                            case "DELETE":
                                response = await client.DeleteAsync(url);
                                break;

                            default:
                                throw new Exception($"Método HTTP no soportado: {method}");
                        }
                    }

                    response.EnsureSuccessStatusCode();
                    string result = await response.Content.ReadAsStringAsync();

                    // Mantener tu misma lógica de convertir "OK"
                    if (result == "\"OK\"")
                        return "OK";

                    return result;
                }
            }
        }

    }
}
