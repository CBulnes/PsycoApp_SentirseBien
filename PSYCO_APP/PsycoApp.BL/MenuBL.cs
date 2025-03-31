using PsycoApp.DA.SQLConnector;
using PsycoApp.entities;
using PsycoApp.utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using PsycoApp.DA;

namespace PsycoApp.BL
{
    public class MenuBL
    {
        MenuDA menuDA = new MenuDA();

        public List<Menu> listar_menu(int id_usuario, int id_tipousuario, int portal=0)
        {
            return menuDA.listar_menu(id_usuario, id_tipousuario,portal);
        }
    }
}
