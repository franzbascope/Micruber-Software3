using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades.Seguridad;
using Data.Seguridad.PermisoDSTableAdapters;
using Data.Seguridad;

namespace Access.Seguridad
{
    public class PermisosBRL
    {
        public static Permisos getPermisoByNombre(string nombre)
        {
            PERMISOTableAdapter adapter = new PERMISOTableAdapter();
            PermisoDS.PERMISODataTable tabla = adapter.GetPermisoIdByNombre(nombre);

            if (tabla.Rows.Count == 0)
            {
                return null;
            }
            PermisoDS.PERMISORow row = tabla[0];
            Permisos obj = new Permisos()
            {
                PermisoId = row.permisoId      
            };
            return obj;
        }
    }
}
