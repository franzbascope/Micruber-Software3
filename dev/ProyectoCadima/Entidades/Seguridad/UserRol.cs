using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class UserRol
    {
        public UserRol()
        {

        }

        public int UsuarioRolId { get; set; }

        public int UsuarioId { get; set; }

        public int RolId { get; set; }

        public string Estado { get; set; }
    }
}
