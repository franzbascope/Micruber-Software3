using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using Access.Seguridad;
using Negocio.Seguridad;
using pruebaFranz3.franz;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminUsers_ListUsers : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
        revisarPermiso();

        List<User> user = UserBRL.getUsuarios();
        GridUsers.DataSource = user;
        GridUsers.DataBind();
        Test a = new Test();
    }

    public void revisarPermiso()
    {
        User objCurrent = (User)Session["User"];

        agregar.Visible = false;
        GridUsers.Columns[4].Visible = false;

        if (UsuarioPermisoBRL.mostrarSiTienePermisos(objCurrent.UsuarioId, 4))
        {
            agregar.Visible = true;
        }

        if (UsuarioPermisoBRL.mostrarSiTienePermisos(objCurrent.UsuarioId, 6))
        {
            GridUsers.Columns[4].Visible = true;
        }
    }

    protected void GridUser_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int userID = 0;
        try
        {
            userID = Convert.ToInt32(e.CommandArgument);
        }
        catch (Exception ex)
        {

        }

        if (userID <= 0)
            return;

        
        if (e.CommandName == "Editar")
        {
            Response.Redirect("RegistUsers.aspx?Id="+userID.ToString());
            return;
        }
    }

}