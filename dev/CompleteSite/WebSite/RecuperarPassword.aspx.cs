using App.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class RecuperarPassword : System.Web.UI.Page
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
        }
        if (Session["UserId"] != null)
        {
            Response.Redirect("Index.aspx");
        }
    }

    protected void BtnIngresar_Click(object sender, EventArgs e)
    {
        MsgError.Text = "";
        try
        {
            string correo = UsernameTextBox.Text;
            bool existeCorreo = UsuarioBLL.validateEmail(correo);
            if (existeCorreo)
            {
                UsuarioBLL.updateCodigoRecuperacion(correo);
                panelEmailSend.Visible = true;
            }
            else
            {
                MsgError.Text = "El correo ingresado no existe";
                return;
            }
        }
        catch (Exception ex)
        {
            MsgError.Text = "Error al verificar los datos";
            return;
        }
    }
}