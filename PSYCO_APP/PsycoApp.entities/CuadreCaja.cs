using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class CuadreCaja
    {
        public int cantidad { get; set; } = 0;
        public string usuario { get; set; } = "";
        public string paciente { get; set; } = "";
        public string fecha_transaccion { get; set; } = "";
        public string estado_cita { get; set; } = "";
        public string servicio { get; set; } = "";
        public string forma_pago { get; set; } = "";
        public string detalle_transferencia { get; set; } = "";
        public string importe { get; set; } = "";
        public string estado_orden { get; set; } = "";
        public string sede { get; set; } = "";
    }
    public class ListaEfectivoDiario
    {
        public string fecha { get; set; } = "";
        public string importe { get; set; } = "";
        public string comentario { get; set; } = "";
        public string usuario { get; set; } = "";
    }
}
