using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.site.Models;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.entities;
using PsycoApp.utilities;

namespace PsycoApp.site.Controllers
{
    public class TicketController : Controller
    {
        private string url_usuario = Helper.GetUrlApi() + "/api/usuario";
        private string url = "";

        dynamic obj = new System.Dynamic.ExpandoObject();

        [HttpPost]
        public ActionResult<RespuestaUsuario> registrar_ticket(Ticket oTicket)
        {
            string rpta = "";
            RespuestaUsuario respuesta = new RespuestaUsuario();
            try
            {
                Cita ocita = new Cita();
                ocita.id_usuario = oTicket.id_usuario;
                ocita.fecha_cita = "";
                if (oTicket.estado == "Muy bien se agendó un nuevo test, a partir de mañana podrá realizarlo"
                || oTicket.estado == "Muy bien se agendó un nuevo test de evaluación, a partir de mañana podrá realizarlo")
                {
                    ocita.id_doctor_asignado = 2; //cuestionario 2
                }

                //if (oTicket.estado == "El test de evaluación ha concluido se generara una cita con su médico"
                //|| oTicket.estado == "El test de evaluación ha concluido se generará una cita con su médico"
                //)
                //{
                //    ocita.id_doctor_asignado = 2; //cuestionario 3
                //}

                url = Helper.GetUrlApi() + "/api/cita/registrar_cuestionario";

                obj = (dynamic)ocita;

                rpta = ApiCaller.consume_endpoint_method(url, obj, "POST");
                respuesta = JsonConvert.DeserializeObject<RespuestaUsuario>(rpta);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                //oTicket.codigo = "ERROR";
                respuesta.estado = false;
                respuesta.descripcion = "Ocurrió un error al procesar su solicitud, vuelva a intentarlo";
            }
            return respuesta;
        }

        public string generar_ticket()
        {
            Ticket oTicket = new Ticket();
            string rpta = "";
            try
            {
                url = url_usuario + "/generar_ticket";

                rpta = ApiCaller.consume_endpoint_method(url, null, "GET");
                oTicket = JsonConvert.DeserializeObject<Ticket>(rpta);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                rpta = "Ocurrió un error generando el ticket";
            }
            return oTicket.codigo;
        }
    }
}
