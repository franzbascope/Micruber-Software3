using CapaAcceso.App_Code.Model.Seguridad;
using DAL.Seguridad;
using DAL.Seguridad.RolesDSTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAcceso.App_Code.BLL.Seguridad
{
    public class RolBLL
    {

        public RolBLL()
        {

        }


        private static Rol GetRolFromRow(RolesDS.RolesRow row)
        {
            return new Rol()
            {
                roleId = row.roleId,
                descripcion = row.descripcion,
                desactivado=row.desactivado

            };
        }

        public static List<Rol> getAllRoles()
        {
            RolesTableAdapter adapter = new RolesTableAdapter();
            RolesDS.RolesDataTable table = adapter.getAllRoles();

            List<Rol> list = new List<Rol>();
            foreach (var row in table)
            {
                Rol obj = GetRolFromRow(row);
                list.Add(obj);
            }
            return list;
        }
        public static Rol getRolById(int rolId)
        {
            RolesTableAdapter adapter = new RolesTableAdapter();
            RolesDS.RolesDataTable table = adapter.GetRolById(rolId);

            List<Rol> list = new List<Rol>();
            foreach (var row in table)
            {
                Rol obj = GetRolFromRow(row);
                list.Add(obj);
            }
            return list[0];
        }
        public static int insertRolesPermisos(int permisoId, int roleId)
        {
            if (permisoId <=0)
                throw new ArgumentException("El permisoId no puede ser <=0");

            if (roleId <=0)
                throw new ArgumentException("El roleId no puede ser nulo o vacio");


            int? id = null;
            RolesTableAdapter adapter = new RolesTableAdapter();
            adapter.InsertRolesPermisos(permisoId, roleId, ref id);

            if (id == null || id.Value <= 0)
                throw new Exception("No se ingreso correctamente");
           
            return id.Value;
        }
        public static void updateRol(Rol objRol)
        {
            RolesTableAdapter adapter = new RolesTableAdapter();
            try
            {
                adapter.UpdateRol(objRol.descripcion, objRol.roleId);
            }
            catch (Exception ex)
            {
                Console.WriteLine("error al updateRol" + ex);
                return;
            }


        }

        public static int insertRol(Rol obj)
        {
            if (string.IsNullOrEmpty(obj.descripcion))
                throw new ArgumentException("La descripcion no puede ser nulo o vacio");

           

            int? id = null;
            RolesTableAdapter adapter = new RolesTableAdapter();
            adapter.InsertRol(obj.descripcion, ref id);

            if (id == null || id.Value <= 0)
                throw new Exception("La llave primaria no se generó correctamente");
            
              
            return id.Value;
        }
        public static void deleteRol(int roleId)
        {
            RolesTableAdapter adapter = new RolesTableAdapter();
            adapter.DeleteRol(roleId);
        }
        public static void deletePermisosByRolId(int roleId)
        {
            RolesTableAdapter adapter = new RolesTableAdapter();
            adapter.deletePermisosByRolId(roleId);
        }

    }
}
