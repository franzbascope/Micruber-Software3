using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class DetallePedido
    {
        public int DetallePedidoId { get; set; }
        public int PedidoId { get; set; }
        public int ProductoId { get; set; }
        public decimal Precio { get; set; }
        public decimal Cantidad { get; set; }
        public decimal SubTotal { get; set; }

        public string  NombreProducto { get; set; }
        public DetallePedido()
        {
        }
    }
}
