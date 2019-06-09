using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAcceso.App_Code.Model.Pagos
{
    public class Pagos
    {
        public int pagoId { get; set; }
        public DateTime fechaPago { get; set; }
        public int conceptoId { get; set; }
        public string conceptoDescripcion { get; set; }
        public String numeroLinea { get; set; }
        public bool esIngreso { get; set; }
        public int usuarioId { get; set; }
        public int vehiculoId { get; set; }
        public int lineaId { get; set; }

        public string fechaPagoForDisplay
        {
            get
            {
                return fechaPago.ToString("dd-MM-yyyy HH:mm:ss"); ;
            }
        }
    }
}
