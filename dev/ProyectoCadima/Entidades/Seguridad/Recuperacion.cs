using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class Recuperacion
    {
        public int RecuperacionId { get; set; }
        public int UsuarioId { get; set; }
        public string Codigo { get; set; }
        public DateTime FechaGenerado { get; set; }
        public DateTime FechaActual { get; set; }
        public int Tiempo { get; set; }
        public char Estado { get; set; }
        public Recuperacion()
        {

        }

    }


}
