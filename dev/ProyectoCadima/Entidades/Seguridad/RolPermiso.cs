using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class RolPermiso
    {
        public RolPermiso()
        {

        }

        public int RolPermisoId { get; set; }
        public int RolId { get; set; }
        public int PermisoID { get; set; }
        public string Estado { get; set; }

    }
}
