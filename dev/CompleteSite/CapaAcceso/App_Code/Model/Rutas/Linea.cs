using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VentasNur.Model
{
    public class Linea
    {
        private double velocidadCaminar = 1.5;
        private double velocidadTransporte = 12;
        public int lineaId { get; set; }
        public string numeroLinea { get; set; }
        public bool perteneceLinea { get; set; }

        public decimal distanciaCaminarMetros { get; set; }
        public decimal distanciaRecorridoMetros { get; set; }

        public int tiempoCaminata
        {
            get
            {
                return Convert.ToInt32( (double)distanciaCaminarMetros / (double) velocidadCaminar);
            }
        }

        public int tiempoRecorrido
        {
            get
            {
                return Convert.ToInt32((double)distanciaRecorridoMetros / (double)velocidadCaminar);
            }
        }
    }
}
