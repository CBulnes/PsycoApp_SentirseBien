using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class CuadreCaja
    {
        public long Fila { get; set; }
        public string paciente { get; set; } = "";
        public string fecha_transaccion { get; set; } = "";
        public string estado_cita { get; set; } = "";
        public string servicio { get; set; } = "";
        public string forma_pago { get; set; } = "";
        public string detalle_transferencia { get; set; } = "";
        public string importe { get; set; } = "";
        public string usuario { get; set; } = "";
        public string estado_orden { get; set; } = "";
        public string sede { get; set; } = "";
    }
    public class ResumenCajaUsuario
    {
        public long Fila { get; set; }
        public string usuario { get; set; } = "";
        public string importe { get; set; } = "";
        public int mes { get; set; } = 0;
        public int anho { get; set; } = 0;
    }
    public class ResumenCajaFormaPago
    {
        public long Fila { get; set; }
        public int cantidad { get; set; } = 0;
        public string importe { get; set; } = "";
        public string forma_pago { get; set; } = "";
        public string detalle_transferencia { get; set; } = "";
        public int mes { get; set; } = 0;
        public int anho { get; set; } = 0;
    }

    public class DataCaja
    {
        public List<CuadreCaja> Registros1 { get; set; }
        public List<ResumenCajaUsuario> Registros2 { get; set; }
        public List<ResumenCajaFormaPago> Registros3 { get; set; }
        public int TotalRegistros { get; set; }
    }
}
