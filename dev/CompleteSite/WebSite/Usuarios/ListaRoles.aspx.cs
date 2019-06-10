using CapaAcceso.App_Code.BLL.Seguridad;
using CapaAcceso.App_Code.Model.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Usuarios_ListaRoles : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
            return;
        else
        {
            CargarRol();
        }

    }
    protected void CargarRol()
    {

        try
        {
            List<Rol> list = RolBLL.getAllRoles();
            RolGridView.DataSource = list;
            RolGridView.DataBind();
        }
        catch (Exception ex)
        {

        }
    }

    protected void RolGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int roleId = 0;
        try
        {
            roleId = Convert.ToInt32(e.CommandArgument);
        }
        catch (Exception ex)
        {

        }
        if (e.CommandName == "Asignar")
        {
           Response.Redirect("DetalleRol.aspx?RoleId=" + roleId);
            return;
        }
        if (e.CommandName == "Editar")
        {
            Response.Redirect("CrearRol.aspx?RoleId=" + roleId);
        }
        if (e.CommandName == "Eliminar")
        {
            try
            {
                RolBLL.deleteRol(roleId);
                CargarRol();
            }
            catch (Exception ex)
            {

            }
        }
    }

    
}