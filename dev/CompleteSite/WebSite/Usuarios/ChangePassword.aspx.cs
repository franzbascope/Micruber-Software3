using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Usuarios_ChangePassword : System.Web.UI.Page
{
    public int UsuarioId
    {
        set { UsuarioIdHiddenField.Value = value.ToString(); }
        get
        {
            int usuarioId = 0;
            try
            {
                usuarioId = Convert.ToInt32(UsuarioIdHiddenField.Value);
            }
            catch (Exception ex)
            {

            }
            return usuarioId;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ProcesarParametros();
        }
    }

    private void ProcesarParametros()
    {
        if (Request.QueryString["UsuarioId"] != null && !string.IsNullOrEmpty(Request.QueryString["UsuarioId"]))
        {
            try
            {
                UsuarioId = Convert.ToInt32(Request.QueryString["UsuarioId"]);
            }
            catch (Exception ex)
            {

            }
        }
        else
        {
            Response.Redirect("~/Index.aspx");
        }
    }


    protected void SaveButton_Click(object sender, EventArgs e)
    {
        string error = UsuarioBLL.changePassword(UsuarioId, CurrentPasswordtextBox.Text, NewPasswordTextBox.Text);
        if (!String.IsNullOrEmpty(error))
        {
            PanelError.Visible = true;
            MsgLiteral.Text = "Error al actualizar contraseña";
            if (error.Contains("INCORRECT_PASSWORD"))
            {
                MsgLiteral.Text = "La contraseña anterior es incorrecta";
            }
        }
        else
        {
            Response.Redirect("~/Index.aspx");
        }
        



    }
}