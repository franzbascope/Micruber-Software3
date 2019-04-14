using Access.Seguridad;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Empresas_ListEmpresas : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Validaciones para Insertar, Editar y eliminar
        if (!IsPostBack)
        {
            revisarPermiso();
            cargarEmpresas();
        }

    }

    public void revisarPermiso()
    {
        User objCurrent = (User)Session["User"];
        try
        {
            agregar.Visible = false;
            GridEmpresas.Columns[4].Visible = false;
            GridEmpresas.Columns[5].Visible = false;

            if (UsuarioPermisoBRL.mostrarSiTienePermisos(objCurrent.UsuarioId, 7))
            {
                agregar.Visible = true;
            }

            if (UsuarioPermisoBRL.mostrarSiTienePermisos(objCurrent.UsuarioId, 8))
            {
                GridEmpresas.Columns[4].Visible = true;
            }
            if (UsuarioPermisoBRL.mostrarSiTienePermisos(objCurrent.UsuarioId, 9))
            {
                GridEmpresas.Columns[5].Visible = true;
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void GridEmpresas_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int empresaId = 0;
        try
        {
            empresaId = Convert.ToInt32(e.CommandArgument);
        }
        catch (Exception ex)
        {

        }
        if (empresaId <= 0)
            return;

        if (e.CommandName == "Eliminar")
        {
            try
            {
                //AdmiPermiso_BRL.deleteAdmiPermisAll(UserAdmId);
                //UserADM_BRL.deleteUserADM(UserAdmId);
                //cargarAdmins();
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
                throw new Exception("Error al eliminar");
            }
        }
        if (e.CommandName == "Editar")
        {
            Response.Redirect("FormEmpresa.aspx?Id=" + empresaId.ToString());
            return;
        }
    }


    public void cargarEmpresas()
    {
        List<Empresa> admins = EmpresaBRL.getEmpresas();
        GridEmpresas.DataSource = admins;
        GridEmpresas.DataBind();
    }
}