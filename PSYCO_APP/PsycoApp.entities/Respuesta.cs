using System;
using System.Collections.Generic;
using System.Text;

namespace PsycoApp.entities
{
    public class Respuesta<T>
    {
        public int Codigo { get; set; }
        public string Texto { get; set; }
        public T Data { get; set; }

        public Respuesta(int codigo, string texto, T data = default)
        {
            Codigo = codigo;
            Texto = texto;
            Data = data;
        }
    }
}