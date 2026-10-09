using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace PsycoApp.entities
{
    public class DashboardData
    {
        public int CitasHoy { get; set; }
        public int CitasCitadasHoy { get; set; }
        public int CitasConfirmadasHoy { get; set; }
        public int CitasAtendidasHoy { get; set; }
        public int PacientesTotal { get; set; }
        public int PacientesMes { get; set; }
        public int EspecialistasDisponibles { get; set; }
        public int EspecialistasTotal { get; set; }
        public int PacientesAtendidos { get; set; }
        public int PacientesCitados { get; set; }
        public int PacientesConfirmados { get; set; }
        public int PacientesPorAtender { get; set; }
        public decimal IngresosHoy { get; set; }
        public bool CajaAbierta { get; set; }
        public string EstadoCaja { get; set; } = string.Empty;
        public DateTime FechaActual { get; set; }
        public IDictionary<string, decimal> IngresosPorFormaPago { get; set; } = new Dictionary<string, decimal>();
        [JsonProperty("ProximasCitas")]
        [JsonConverter(typeof(SingleOrArrayConverter<DashboardCitaData>))]
        public List<DashboardCitaData> ProximasCitas { get; set; } = new List<DashboardCitaData>();
        [JsonProperty("ActividadReciente")]
        [JsonConverter(typeof(SingleOrArrayConverter<DashboardActividadData>))]
        public List<DashboardActividadData> ActividadReciente { get; set; } = new List<DashboardActividadData>();
        [JsonProperty("ActividadSemanal")]
        [JsonConverter(typeof(SingleOrArrayConverter<DashboardDiaData>))]
        public List<DashboardDiaData> ActividadSemanal { get; set; } = new List<DashboardDiaData>();
    }

    public class SingleOrArrayConverter<T> : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            return objectType == typeof(IList<T>) || objectType == typeof(List<T>);
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null)
                return new List<T>();
            if (reader.TokenType == JsonToken.StartArray)
            {
                var items = new List<T>();
                while (reader.Read() && reader.TokenType != JsonToken.EndArray)
                {
                    var arrayItem = serializer.Deserialize<T>(reader);
                    if (arrayItem != null)
                        items.Add(arrayItem);
                }
                return items;
            }

            if (reader.TokenType != JsonToken.StartObject)
                throw new JsonSerializationException("Se esperaba un array o un objeto para la colección del dashboard.");

            var token = Newtonsoft.Json.Linq.JToken.ReadFrom(reader);
            var objectItem = token.ToObject<T>(serializer);
            return objectItem == null ? new List<T>() : new List<T> { objectItem };
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            serializer.Serialize(writer, value);
        }
    }

    public class DashboardCitaData
    {
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        [JsonConverter(typeof(DashboardHoraJsonConverter))]
        public string Hora { get; set; } = string.Empty;
        public string Paciente { get; set; } = string.Empty;
        public string Especialista { get; set; } = string.Empty;
        public string Servicio { get; set; } = string.Empty;
        public string Estado { get; set; } = string.Empty;
    }

    public class DashboardHoraJsonConverter : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            return objectType == typeof(string);
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null)
                return string.Empty;

            var token = Newtonsoft.Json.Linq.JToken.ReadFrom(reader);
            if (token.Type == Newtonsoft.Json.Linq.JTokenType.String || token.Type == Newtonsoft.Json.Linq.JTokenType.Integer)
                return Convert.ToString(((Newtonsoft.Json.Linq.JValue)token).Value);

            if (token.Type == Newtonsoft.Json.Linq.JTokenType.Object)
            {
                var ticks = token["Ticks"] ?? token["ticks"];
                if (ticks != null && long.TryParse(Convert.ToString(ticks), out var tickValue))
                    return TimeSpan.FromTicks(tickValue).ToString(@"hh\:mm");

                var hours = ReadPart(token, "Hours", "hours");
                var minutes = ReadPart(token, "Minutes", "minutes");
                if (hours.HasValue || minutes.HasValue)
                    return new TimeSpan(0, hours.GetValueOrDefault(), minutes.GetValueOrDefault(), ReadPart(token, "Seconds", "seconds").GetValueOrDefault()).ToString(@"hh\:mm");
            }

            return string.Empty;
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            writer.WriteValue(value as string ?? string.Empty);
        }

        private static int? ReadPart(Newtonsoft.Json.Linq.JToken token, string pascalName, string camelName)
        {
            var value = token[pascalName] ?? token[camelName];
            return value != null && int.TryParse(Convert.ToString(value), out var parsed) ? parsed : (int?)null;
        }
    }

    public class DashboardActividadData
    {
        public string Tipo { get; set; } = string.Empty;
        public string Titulo { get; set; } = string.Empty;
        public string Descripcion { get; set; } = string.Empty;
        public DateTime Fecha { get; set; }
    }

    public class DashboardDiaData
    {
        public DateTime Fecha { get; set; }
        public int Citas { get; set; }
        public int Pacientes { get; set; }
        public decimal Ingresos { get; set; }
    }
}
