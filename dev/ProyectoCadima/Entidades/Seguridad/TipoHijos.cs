using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class TipoHijos
    {
        public int TipoHijosId { get; set; }
        public int TipoMaestroId { get; set; }
        public string Nombre { get; set; }
        public string Valor { get; set; }
        public bool Estado { get; set; }
        public TipoHijos()
        {

        }
    }
}
