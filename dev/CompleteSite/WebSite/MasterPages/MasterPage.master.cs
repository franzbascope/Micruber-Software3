using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using App.Utilities;

public partial class MasterPages_MasterPage : System.Web.UI.MasterPage
{
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

        if (!IsPostBack)
        {


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

    protected void Logout_Click(object sender, EventArgs e)
    {
        Session["UserId"] = null;
        Response.Redirect("~/Login.aspx");
    }
}
