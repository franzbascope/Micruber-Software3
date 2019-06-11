using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAcceso.App_Code.Model.Pagos
{
    public class PagoUsuario
    {
        public String correo { get; set; }
        public int monto { get; set; }
        public int userRecargo { get; set; }

    }
}
