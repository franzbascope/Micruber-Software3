using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
   
    public class UsuarioPermiso
    {
        public int UsuarioId { get; set; }
        public int PermisoId { get; set; }
        public string Estado { get; set; }

        public UsuarioPermiso()
        {

        }

    }
}
