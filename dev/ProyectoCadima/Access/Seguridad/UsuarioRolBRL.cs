using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades.Seguridad;
using Data.Seguridad.UsuarioRolDSTableAdapters;
using Data.Seguridad;

namespace Access.Seguridad
{
    public class UsuarioRolBRL
    {
        public UsuarioRolBRL()
        {

        }
       

        public static int insertUserRol(UserRol obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("El objeto a ingresar no puede ser Nulo");
            }
                        
            int? usuarioRolId = 0;
            USUARIOROLTableAdapter adapter = new USUARIOROLTableAdapter();
            adapter.Insert(obj.UsuarioId, obj.RolId, obj.Estado, ref usuarioRolId);
            

            if (usuarioRolId == null || usuarioRolId <= 0)
            {
                throw new ArgumentException("La llave primaria no se genero correctamente");
            }

            return usuarioRolId.Value;

        }
        public static Boolean TieneRolesAsignados(int userId, int rolId)
        {
            USUARIOROLTableAdapter adapter = new USUARIOROLTableAdapter();
            UsuarioRolDS.USUARIOROLDataTable table = adapter.GetUsarioRoIdlByUserRol(userId, rolId);

            if (table.Rows.Count == 0)
            {
                return false;
            }
            return true;
        }

        public static void eliminarUsuarioRolById(int rolPermisoId)
        {
            USUARIOROLTableAdapter adapter = new USUARIOROLTableAdapter();
            adapter.Delete(rolPermisoId);
        }
        public static void eliminarUsuarioRolByRolIdPermisoId(int usuarioId, int permisoId)
        {
            USUARIOROLTableAdapter adapter = new USUARIOROLTableAdapter();
            UsuarioRolDS.USUARIOROLDataTable table = adapter.GetUsarioRoIdlByUserRol(usuarioId, permisoId);

            var row = table[0];

            UserRol obj = new UserRol();

            obj.UsuarioRolId = row.idUsuarioRol;

            eliminarUsuarioRolById(obj.UsuarioRolId);
        }

    }
}
