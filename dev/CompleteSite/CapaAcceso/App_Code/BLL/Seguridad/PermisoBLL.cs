using CapaAcceso.App_Code.Model.Seguridad;
using DAL.Seguridad;
using DAL.Seguridad.PermisosDSTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAcceso.App_Code.BLL.Seguridad
{
    public class PermisoBLL
    {
        public PermisoBLL()
        {

        }


        private static Permiso GetPermisoFromRow(PermisosDS.PermisosRow row)
        {
            return new Permiso()
            {
                permisoId = row.permisoId,
                descripcion = row.descripcion,
                perteneceRol = row.IsperteneceRolNull()? false : row.perteneceRol

            };
        }

        public static List<Permiso> getAllPermisos()
        {
            PermisosTableAdapter adapter = new PermisosTableAdapter();
            PermisosDS.PermisosDataTable table = adapter.GetPermisos();

            List<Permiso> list = new List<Permiso>();
            foreach (var row in table)
            {
                Permiso obj = GetPermisoFromRow(row);
                list.Add(obj);
            }
            return list;
        }

        public static List<Permiso> getAllPermisosByUserId(int id)
        {
            PermisosTableAdapter adapter = new PermisosTableAdapter();
            PermisosDS.PermisosDataTable table = adapter.GetPermisosByUsuarioId(id);

            List<Permiso> list = new List<Permiso>();
            foreach (var row in table)
            {
                Permiso obj = GetPermisoFromRow(row);
                list.Add(obj);
            }
            return list;
        }



    }
}
