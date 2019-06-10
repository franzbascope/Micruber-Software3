using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAcceso.App_Code.Model.Seguridad
{
    public class Permiso
    {
        public int permisoId { get; set; }
        public string descripcion { get; set; }
        public bool perteneceRol { get; set; }
    }
}
