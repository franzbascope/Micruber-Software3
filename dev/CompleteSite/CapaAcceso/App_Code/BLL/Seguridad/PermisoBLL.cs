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
        public static bool validarPermiso(int usuarioId, string memotecnico)
        {
            if (usuarioId <= 0)
                throw new Exception("El usuarioId no puede ser <=0");
            if (String.IsNullOrEmpty(memotecnico))
            {
                throw new Exception("el memotecnico no puede ser nulo o vacio");
            }
            bool? tienePermiso = false;
            try
            {
                PermisosTableAdapter adapter = new PermisosTableAdapter();
                adapter.validarPagina(usuarioId, memotecnico, ref tienePermiso);
            }
            catch (Exception ex)
            {
                Console.WriteLine("error al validar pagina : " + ex);
            }
            return tienePermiso.Value;

        }



    }
}
