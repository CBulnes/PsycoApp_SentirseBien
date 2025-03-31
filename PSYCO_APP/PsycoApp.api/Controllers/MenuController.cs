using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PsycoApp.BL;
using PsycoApp.entities;
using PsycoApp.utilities;

namespace PsycoApp.api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MenuController : ControllerBase
    {
        MenuBL menuBL = new MenuBL();

        RespuestaMenu oRespuesta = new RespuestaMenu();
        Usuario usuario = new Usuario();
        List<Menu> lista = new List<Menu>();

        // GET api/values
        [HttpGet("{id_usuario}/{id_tipousuario}/{portal}")]
        public ActionResult<RespuestaMenu> Get(int id_usuario, int id_tipousuario,int portal=0)
        {
            usuario.id_usuario = id_usuario;
            usuario.id_tipousuario = id_tipousuario;

            try
            {
                lista = menuBL.listar_menu(id_usuario, id_tipousuario,portal);

                oRespuesta.data = lista;

                // vlidar si hay error
                if (lista.Count > 0 && lista[0].validacion != "OK")
                {
                    oRespuesta.estado = "ERROR";
                    oRespuesta.descripcion = lista[0].validacion;
                }
            }
            catch (Exception e)
            {
                oRespuesta.estado = "ERROR";
                oRespuesta.descripcion = e.Message.ToString();
            }
            return oRespuesta;
        }

        //// GET api/values/5
        //[HttpGet("{id}")]
        //public ActionResult<Respuesta> Get(int id)
        //{
        //    Menu menu = new Menu();

        //    Respuesta respuesta = new Respuesta();
        //    respuesta.estado = "OK";
        //    respuesta.descripcion = "";
        //    respuesta.data = menu;

        //    return respuesta;
        //}

        //// POST api/values
        //[HttpPost]
        //public Respuesta Post([FromBody] Usuario input)
        //{
        //    Menu menu = new Menu();

        //    Respuesta respuesta = new Respuesta();
        //    respuesta.estado = "OK";
        //    respuesta.descripcion = "Registro insertado";
        //    respuesta.data = menu;

        //    return respuesta;
        //}

        //// PUT api/values/5
        //[HttpPut("{id}")]
        //public Respuesta Put(int id, [FromBody] Usuario input)
        //{
        //    Menu menu = new Menu();

        //    Respuesta respuesta = new Respuesta();
        //    respuesta.estado = "OK";
        //    respuesta.descripcion = "Registro actualizado";
        //    respuesta.data = menu;

        //    return respuesta;
        //}

        //// DELETE api/values/5
        //[HttpDelete("{id}")]
        //public Respuesta Delete(int id)
        //{
        //    Menu menu = new Menu();

        //    Respuesta respuesta = new Respuesta();
        //    respuesta.estado = "OK";
        //    respuesta.descripcion = "Registro eliminado";
        //    respuesta.data = menu;

        //    return respuesta;
        //}
    }
}
