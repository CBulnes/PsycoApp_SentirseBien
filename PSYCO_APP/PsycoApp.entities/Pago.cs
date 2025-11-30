using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class Pago
    {
        public int? id_cita { get; set; } = 0;
        public int? id_forma_pago { get; set; } = 0;
        public int? id_detalle_transferencia { get; set; } = 0;
        public string? usuario { get; set; } = "";
        public string? comentario { get; set; } = "";
        public decimal? importe { get; set; } = 0;
    }
    public class EfectivoDiario
    {
        public string fecha { get; set; } = "";
        public decimal importe { get; set; } = 0;
        public string comentario { get; set; } = "";
        public string usuario { get; set; } = "";
    }

    public class PagosPendientes
    {
        public int id_cita { get; set; } = 0;
        public string servicio { get; set; } = "";
        public string fecha_cita { get; set; } = "";
        public string usuario_registra { get; set; } = "";
        public string fecha_registra { get; set; } = "";
        public string estado_cita { get; set; } = "";
        public string monto_pactado { get; set; } = "";
        public string monto_pagado { get; set; } = "";
        public string monto_pendiente { get; set; } = "";
    }
}
