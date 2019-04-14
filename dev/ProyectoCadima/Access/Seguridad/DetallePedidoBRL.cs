using Access.Seguridad;
using Data.Seguridad;
using Data.Seguridad.DetallePedidoDSTableAdapters;
using Data.Seguridad.PedidoDSTableAdapters;
using Data.Seguridad.ProductoDSTableAdapters;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Seguridad
{
    public class DetallePedidoBRL
    {
        public DetallePedidoBRL()
        {
        }
        
        public static int insertDetallePedido(DetallePedido obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("El objeto DetallePedido no debe ser nulo");
            }

            int? productoId = 0;
            DetallePedidoAdapter adapter = new DetallePedidoAdapter();
            adapter.Insert(obj.PedidoId,obj.ProductoId,obj.Precio,obj.Cantidad,obj.SubTotal);

            return productoId.Value;
        }


        public static List<DetallePedido> getDatallesByPedidoId(int pedidoId)
        {
            DetallePedidoAdapter adapter = new DetallePedidoAdapter();            
            DetallePedidoDS.DetallePedidoDataTable table = adapter.GetDetalle(pedidoId);

            List<DetallePedido> listDetalles = new List<DetallePedido>();
            DetallePedido objTemp;
            Producto productoTemp;
            foreach (var row in table)
            {
                objTemp = new DetallePedido();
                objTemp.DetallePedidoId = row.DetallePedidoId;
                objTemp.PedidoId = row.PedidoId;
                objTemp.ProductoId = row.ProductoId;
                objTemp.Precio = row.Precio;
                objTemp.Cantidad = row.Cantidad;
                objTemp.SubTotal = row.SubTotal;                
                //objTemp.NombreProducto = row.Ta

                productoTemp = ProductoBRL.getProductoById(row.ProductoId);
                objTemp.NombreProducto = productoTemp.Nombre;

                listDetalles.Add(objTemp);
            }

            return listDetalles;
        }

    }
}
