using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VentasNur.Model
{
    public class Vehiculo
    {
        public int vehiculoId { get; set; }
        public int capacidad { get; set; }
        public string placa { get; set; }
        public bool desactivado { get; set; }
    }
}
