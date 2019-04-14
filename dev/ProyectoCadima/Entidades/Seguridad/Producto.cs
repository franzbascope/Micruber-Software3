using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class Producto
    {
        public int ProductoId { get; set; }
        public int TipoIdc { get; set; }
        public int EmpresaId { get; set; }
        public string Nombre { get; set; }
        public decimal Precio { get; set; }
        public bool Estado { get; set; }
        public string NombreEmp { get; set; }
        public Producto()
        {
        }
    }
}
