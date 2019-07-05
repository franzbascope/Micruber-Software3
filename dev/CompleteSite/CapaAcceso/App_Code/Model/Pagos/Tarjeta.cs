using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAcceso.App_Code.Model.Pagos
{
    public class Tarjeta
    {
        public int tarjetaId { get; set; }
        public string codigoNFC { get; set; }
        public int estado { get; set; }
    }
}
