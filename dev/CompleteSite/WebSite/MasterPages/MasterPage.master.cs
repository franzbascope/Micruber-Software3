using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using App.Utilities;
using CapaAcceso.App_Code.BLL.Seguridad;

public partial class MasterPages_MasterPage : System.Web.UI.MasterPage
{
    int usuarioId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        bool isValidVersion = false;
        try
        {
            isValidVersion = VersionUtilities.AppIsValidVersion();
        }
        catch (Exception ex)
        {
            Session["ErrorMessage"] = ex.Message;
            Response.Redirect("~/Error.aspx");
        }

        if (!isValidVersion)
        {
            Session["ErrorMessage"] = "La version de la Aplicacion no es la misma que la version de la Base de Datos.";
            Response.Redirect("~/Error.aspx");
            return;
        }
        if (Session["UserId"] == null)
        {
            Response.Redirect("~/Login.aspx");
            return;
        }
        else
        {
            usuarioId =Convert.ToInt32(Session["UserId"]);
            esconderBotones();
        }

        if (!IsPostBack)
        {
            if (!IsUserAuthorizedPage())
            {
                // Transfer the user to a page that tells him that he is not authorized to 
                // see that page.
                Response.Redirect("~/Utils/NotAuthorized.aspx");
            }


            //            string scripts = "<script type='text/javascript' src='" +
            //                ResolveUrl("~/Assets/Scripts/jquery.min.js") +
            //                "'></script>";

            //            scripts += "<script type='text/javascript' src='" +
            //                ResolveUrl("~/Assets/Scripts/popper.min.js") +
            //                "'></script>";

            //            scripts += "<script type='text/javascript' src='" +
            //                ResolveUrl("~/Assets/Scripts/bootstrap.min.js") +
            //                "'></script>";

            //            scripts += "<script type='text/javascript' src='" +
            //ResolveUrl("~/Assets/Scripts/perfect-scrollbar.jquery.min.js") +
            //"'></script>";


            //            scripts += "<script type='text/javascript' src='" +
            //              ResolveUrl("~/Assets/Scripts/now-ui-dashboard.min.js") +
            //              "'></script>";

            //            scripts += "<script type='text/javascript' src='" +
            //              ResolveUrl("~/Assets/Scripts/demo.js") +
            //              "'></script>";



            //            ScriptsLiteral.Text = scripts;
        }

    }
    public void esconderBotones()
    {
        if (!PermisoBLL.validarPermiso(usuarioId, "REGISTRO_ROLES"))
            ListaRolesLinkButton.Visible = false;
        if (!PermisoBLL.validarPermiso(usuarioId, "REGISTRO_USUARIOS"))
            ListaUsuariosLinkButton.Visible = false;
    }
    protected void Logout_Click(object sender, EventArgs e)
    {
        Session["UserId"] = null;
        Response.Redirect("~/Login.aspx");
    }
    private bool IsUserAuthorizedPage()
    {
        string currentPage = Page.Request.AppRelativeCurrentExecutionFilePath;

        string[] openPages = {
             "~/Index.aspx",
             "~/Usuarios/ChangePassword.aspx"
        };

        for (int i = 0; i < openPages.Length; i++)
        {
            if (currentPage.Equals(openPages[i]))
                return true;
        }

        // SECURITY Roles
        string[] securityPages = new string[] {
             "~/Usuarios/CrearRol.aspx",
             "~/Usuarios/DetalleRol.aspx",
             "~/Usuarios/ListaRoles.aspx"
        };

        for (int i = 0; i < securityPages.Length; i++)
        {
            if (currentPage.Equals(securityPages[i]) &&
                PermisoBLL.validarPermiso(usuarioId, "REGISTRO_ROLES"))
                return true;
        }
        

        // SECURITY Usuarios
        string[] userPages = new string[] {
             "~/Usuarios/ListaUsuarios.aspx",
             "~/Usuarios/DetalleUsuario.aspx"
        };

        for (int i = 0; i < userPages.Length; i++)
        {
            if (currentPage.Equals(userPages[i]) &&
                PermisoBLL.validarPermiso(usuarioId, "REGISTRO_USUARIOS"))
                return true;
        }
        // Nothing else worked.  The user should not be allowed to access the page.
        return false;

    }

        protected void RolesForm_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Usuarios/ListaRoles.aspx");

    }

    protected void ChangePassword_Click(object sender, EventArgs e)
    {
        if (Session["UserId"] != null)
        {
            Response.Redirect("~/Usuarios/ChangePassword.aspx?UsuarioId=" + Session["UserId"]);
        }

    }
}
