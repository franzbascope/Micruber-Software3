using Data.Seguridad;
using Data.Seguridad.ProductoDSTableAdapters;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Access.Seguridad
{
    public class ProductoBRL
    {
        public ProductoBRL()
        {
        }

        public static List<Producto> getProductosTable()
        {
            ProductosTableAdapter adapter = new ProductosTableAdapter();
            ProductoDS.ProductosDataTable table  = adapter.GetProductos();

            List<Producto> listProducto = new List<Producto>();
            foreach (var row in table)
            {
                Producto obj = new Producto();
                obj.ProductoId = row.productoId;
                obj.TipoIdc = row.tipoIdc;
                obj.EmpresaId = row.empresaId;
                obj.Nombre = row.nombre;
                obj.Precio = row.precio;
                obj.Estado = row.estado;

                Empresa objemp = EmpresaBRL.getEmpresaById(row.empresaId);
                obj.NombreEmp = objemp.Nombre;

                listProducto.Add(obj);
            }

            return listProducto;
        }

        public static List<Producto> getProductos()
        {
            ProductosTableAdapter adapter = new ProductosTableAdapter();
            ProductoDS.ProductosDataTable table = adapter.GetProductos();

            List<Producto> listProducto = new List<Producto>();
            foreach (var row in table)
            {
                Producto obj = new Producto();
                obj.ProductoId = row.productoId;
                obj.TipoIdc = row.tipoIdc;
                obj.EmpresaId = row.empresaId;
                obj.Nombre = row.nombre;
                obj.Precio = row.precio;
                obj.Estado = row.estado;

                listProducto.Add(obj);
            }

            return listProducto;
        }

        public static int insertProducto(Producto obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("El objeto Producto no debe ser nulo");
            }

            int? productoId = 0;
            ProductosTableAdapter adapter = new ProductosTableAdapter();
            adapter.Insert(obj.TipoIdc, obj.EmpresaId, obj.Nombre, obj.Precio, obj.Estado, ref productoId);

            if (productoId <= 0)
            {
                throw new ArgumentException("Falla al insertar, el productoId es menor que 0");
            }

            return productoId.Value;
        }

        public static void updateProducto(Producto obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("El objeto Produco no debe ser nulo");
            }

            ProductosTableAdapter adapter = new ProductosTableAdapter();
            adapter.Update(obj.TipoIdc, obj.EmpresaId, obj.Nombre, obj.Precio, obj.ProductoId);
        }

        public static Producto getProductoById(int productoId)
        {
            if (productoId <= 0)
            {
                new ArgumentException("Producto Id no debe ser manor o igual a 0");
            }

            ProductosTableAdapter adapter = new ProductosTableAdapter();
            ProductoDS.ProductosDataTable table = adapter.GetProductoById(productoId);

            if (table.Rows.Count == 0)
            {
                return null;
            }

            ProductoDS.ProductosRow row = table[0];
            Producto obj = new Producto()
            {
                ProductoId = row.productoId,
                TipoIdc = row.tipoIdc,
                EmpresaId = row.empresaId,
                Nombre = row.nombre,
                Precio = row.precio,
                Estado = row.estado
            };

            return obj;
        }
    }
}
