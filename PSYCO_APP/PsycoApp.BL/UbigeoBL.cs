using PsycoApp.DA;
using PsycoApp.entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.BL
{
    public class UbigeoBL
    {
        private readonly UbigeoDA _ubigeoDA;

        public UbigeoBL()
        {
            _ubigeoDA = new UbigeoDA();
        }

        public List<Ubigeo> ListarUbigeos()
        {
            return _ubigeoDA.ListarUbigeos();
        }
    }
}
