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
        public string codigoActivacion { get; set; }
        public string codigoRecuperacion { get; set; }
        public string tempPassword { get; set; }
        public int rolId { get; set; }
        public int tipoUsuario { get; set; }

        public string rolDescripcion { get; set; }
        public bool esEstudiante { get; set; }
        public decimal saldoActual { get; set; }



    }
}