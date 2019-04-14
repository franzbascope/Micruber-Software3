using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class Empresa
    {
        public int EmpresaId { get; set; }
        public int TipoIdc { get; set; }
        public string Nit { get; set; }
        public string Nombre { get; set; }
        public string Gerente { get; set; }
        public string Telefono { get; set; }
        public bool Estado { get; set; }
        public Empresa() { }
    }
}
