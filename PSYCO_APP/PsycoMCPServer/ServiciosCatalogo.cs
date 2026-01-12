using System;
using System.Collections.Generic;

namespace PsycoMCPServer.Services
{
    public static class ServiciosCatalogo
    {
        private static readonly Dictionary<string, ServicioInfo> _servicios =
            new(StringComparer.OrdinalIgnoreCase)
            {
                ["TERAPIA DE PAREJA Y FAMILIA (TPF)"] =
                    new ServicioInfo { Id = 3, Precio = 160m, Nombre = "TERAPIA DE PAREJA Y FAMILIA (TPF)" },

                ["EVALUACION DE APRENDIZAJE"] =
                    new ServicioInfo { Id = 12, Precio = 590m, Nombre = "EVALUACION DE APRENDIZAJE" },

                ["PAQUETE DE 5 SESIONES INDIVIDUAL"] =
                    new ServicioInfo { Id = 34, Precio = 600m, Nombre = "PAQUETE DE 5 SESIONES INDIVIDUAL" },

                ["CONSULTA O ATENCION SIN COSTO"] =
                    new ServicioInfo { Id = 45, Precio = 0m, Nombre = "CONSULTA O ATENCION SIN COSTO" },

                ["ENTREGA INFORME 30 MINUTOS"] =
                    new ServicioInfo { Id = 47, Precio = 0m, Nombre = "ENTREGA INFORME 30 MINUTOS" },

                ["EVALUACION INTEGRAL (EI)"] =
                    new ServicioInfo { Id = 57, Precio = 740m, Nombre = "EVALUACION INTEGRAL (EI)" },

                ["EVALUACION PERSONALIDAD (EP)"] =
                    new ServicioInfo { Id = 58, Precio = 640m, Nombre = "EVALUACION PERSONALIDAD (EP)" },

                ["VISITA COLEGIO"] =
                    new ServicioInfo { Id = 60, Precio = 160m, Nombre = "VISITA COLEGIO" },

                ["TERAPIA VIRTUAL Y PRESENCIALES (V)"] =
                    new ServicioInfo { Id = 77, Precio = 140m, Nombre = "TERAPIA VIRTUAL Y PRESENCIALES (V)" },

                ["(N)TERAPIA VIRTUAL Y PRESENCIALES NUEVOS (V)"] =
                    new ServicioInfo { Id = 78, Precio = 140m, Nombre = "(N)TERAPIA VIRTUAL Y PRESENCIALES NUEVOS (V)" },

                ["PAQUETE DE 5 SESIONES DE TERAPIA DE PAREJA"] =
                    new ServicioInfo { Id = 81, Precio = 750m, Nombre = "PAQUETE DE 5 SESIONES DE TERAPIA DE PAREJA" },

                ["EVALUACION NEUROPSICOLOGICA"] =
                    new ServicioInfo { Id = 85, Precio = 760m, Nombre = "EVALUACION NEUROPSICOLOGICA" },

                ["Consulta o atención sin costo"] =
                    new ServicioInfo { Id = 86, Precio = 0m, Nombre = "Consulta o atención sin costo" },

                ["Evaluacion de Inteligencia"] =
                    new ServicioInfo { Id = 87, Precio = 280m, Nombre = "Evaluacion de Inteligencia" },

                ["Evaluacion Vocacional"] =
                    new ServicioInfo { Id = 88, Precio = 390m, Nombre = "Evaluacion Vocacional" }
            };

        public static ServicioInfo? Obtener(string nombre)
            => _servicios.TryGetValue(nombre, out var s) ? s : null;
    }

    public class ServicioInfo
    {
        public int Id { get; set; }
        public decimal Precio { get; set; }
        public string? Nombre { get; set; }
    }
}