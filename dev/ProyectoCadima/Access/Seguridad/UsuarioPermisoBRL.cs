using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Entidades.Seguridad;
using Data.Seguridad.UsuarioPermisoDSTableAdapters;
using Data.Seguridad;


namespace Access.Seguridad
{
    public class UsuarioPermisoBRL
    {
        public static void insertUserPermiso(UsuarioPermiso obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("El objeto a ingresar no puede ser Nulo");
            }
            
            USUARIOPERMISOTableAdapter adapter = new USUARIOPERMISOTableAdapter();
            adapter.Insert(obj.UsuarioId, obj.PermisoId, obj.Estado);

        }

        public static List<UsuarioPermiso> mostrarPermisos(int usuarioId, int rolId)
        {
            USUARIOPERMISOTableAdapter adapter = new USUARIOPERMISOTableAdapter();
            UsuarioPermisoDS.USUARIOPERMISODataTable table = adapter.GetPermisosByUsuarioIdRolId(usuarioId, rolId);
            
            List<UsuarioPermiso> listUsersPermisos = new List<UsuarioPermiso>();

            foreach (var row in table)
            {
                UsuarioPermiso obj = new UsuarioPermiso();

                obj.UsuarioId = row.usuarioId;
                obj.PermisoId = row.permisoId;
                obj.Estado = row.estado;

                listUsersPermisos.Add(obj);
            }
            return listUsersPermisos;
        }

        public static Boolean mostrarSiTienePermisos(int usuarioId, int permisoId)
        {
            USUARIOPERMISOTableAdapter adapter = new USUARIOPERMISOTableAdapter();
            UsuarioPermisoDS.USUARIOPERMISODataTable table = adapter.GetMostrarSiTienePermiso(usuarioId, permisoId);
            if (table.Rows.Count == 0)
            {
                return false;
            }
            return true;
        }

        public static void eliminarUsuarioPermisoByUsuarioIdPermisoId(int usuarioId, int rolPermisoId)
        {
            USUARIOPERMISOTableAdapter adapter = new USUARIOPERMISOTableAdapter();
            adapter.Delete(usuarioId,rolPermisoId);
        }
    }    
}
