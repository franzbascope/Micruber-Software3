using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class Permisos
    {
        public Permisos()
        {

        }
        public int PermisoId { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string url { get; set; }
        public string posicion { get; set; }        
        public string Estado { get; set; }
    }
}
