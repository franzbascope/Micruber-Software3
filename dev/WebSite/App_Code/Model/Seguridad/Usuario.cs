using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VentasNur.Model
{
    public class Usuario
    {
        public int usuarioId { get; set; }
        public string nombreCompleto { get; set; }
        public string correo { get; set; }
        public string password { get; set; }



    }
}