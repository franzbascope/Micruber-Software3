using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VentasNur.Model
{
    public class Coordenada
    {
        public int coordenadaId { get; set; }
        public int lineaId { get; set; }
        public decimal latitud { get; set; }
        public decimal longitud { get; set; }
    }
}
