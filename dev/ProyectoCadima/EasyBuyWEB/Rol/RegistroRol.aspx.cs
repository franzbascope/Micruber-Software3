using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entidades.Seguridad;
using Access.Seguridad;
using Negocio.Seguridad;

public partial class Roles_RegistRol : System.Web.UI.Page
{
    string strId;
    int codRol;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            return;
        }

        string strId = Request.Params["Id"];
        if (string.IsNullOrEmpty(strId))
        {
            return;
        }
        
        cargarDatos();        
    }
    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        strId = Request.Params["Id"];
        codRol = Convert.ToInt32(strId);
        try
        {
            int id = Convert.ToInt32(RolID.Value);
            string nombre = txtNombre.Text;
            string descripcion = txtDescripcion.Text;

            Rol objRol = new Rol()
            {               
                Nombre = nombre,
                Descripcion = descripcion,
                Estado = "activo",
                RolId = codRol
            };

            if (string.IsNullOrEmpty(strId))
            {   //Inserta Nuevo
                int codigoRol = RolBRL.insertRol(objRol);

                RolPermiso rolPermiso;
                Permisos tempPermiso;

                //Insertando los permisos
                for (int i = 0; i < checkPermisos.Items.Count; i++)
                {
                    if (checkPermisos.Items[i].Selected)
                    {
                        tempPermiso = PermisosBRL.getPermisoByNombre(checkPermisos.Items[i].Text);

                        rolPermiso = new RolPermiso()
                        {
                            RolId = codigoRol,
                            PermisoID = tempPermiso.PermisoId,
                            Estado = "activo"
                        };
                        RolPermisoBRL.insertRolPermiso(rolPermiso);
                    }
                }
            }
            else
            {
                //Actualizando Rol
                RolBRL.updateRol(objRol);

                //Actualizar Permisos
                Permisos perm1;
                Permisos perm2;
                for (int i = 0; i < checkPermisos.Items.Count; i++)
                {
                    if (checkPermisos.Items[i].Selected)
                    {
                        perm1 = PermisosBRL.getPermisoByNombre(checkPermisos.Items[i].Text);

                        if (!RolPermisoBRL.tienePermiso(codRol, perm1.PermisoId))
                        {
                            //Agregar
                            RolPermiso rolPerm = new RolPermiso()
                            {
                                RolId = codRol,
                                PermisoID = perm1.PermisoId,
                                Estado = "activo"
                                
                            };
                            RolPermisoBRL.insertRolPermiso(rolPerm);
                        }
                    }
                    else
                    {
                        perm2 = PermisosBRL.getPermisoByNombre(checkPermisos.Items[i].Text);
                        if (RolPermisoBRL.tienePermiso(codRol, perm2.PermisoId))
                        {
                            //Eliminar
                            RolPermisoBRL.eliminarUsuarioPermisoByRolIdPermisoId(codRol, perm2.PermisoId);
                        }
                    }

                }
            }
            Response.Redirect("~/Rol/ListRol.aspx");
        }
        catch (Exception ex)
        {

        }
    }
    public void cargarDatos()
    {       
        string strId = Request.Params["Id"];
        int id = 0;

        try
        {
            id = Convert.ToInt32(strId);
        }
        catch (Exception ex)
        {
            Console.Write(ex.Message);
        }

        if (id <= 0)
        {
            return;
        }

        Rol obj = RolBRL.getRolesById(id);

        txtNombre.Text = obj.Nombre.Trim();
        txtDescripcion.Text = obj.Descripcion.Trim();

        Permisos perm;
        for (int i = 0; i < checkPermisos.Items.Count; i++)
        {
            perm = PermisosBRL.getPermisoByNombre(checkPermisos.Items[i].Text);
            if (RolPermisoBRL.tienePermiso(obj.RolId, perm.PermisoId))
            {
                checkPermisos.Items[i].Selected = true;
            }
        }


    }
}