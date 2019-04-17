using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VentasNur.Model;

public partial class Usuarios_CreateNewPassword : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ProcesarParametros();
        }
    }

    private void ProcesarParametros()
    {
        string code = "";
        bool esCodigoCorrecto = false;
        if (Request.QueryString["code"] != null && !string.IsNullOrEmpty(Request.QueryString["code"]))
        {
            try
            {
                code=Request.QueryString["code"].ToString();
                esCodigoCorrecto = UsuarioBLL.validateCodigoRecuperacion(code);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
        }
        if (esCodigoCorrecto)
        {
            panelCodigoCorrecto.Visible = true;
            CodigoRecuperaciondHiddenField.Value = code;
        }
        else
        {
            PanelCodigoIncorrecto.Visible = true;
        }

    }


    protected void BtnIngresar_Click(object sender, EventArgs e)
    {
        MsgError.Text = "";
        string password = PasswordTextBox.Text;
        string confirmPassword = ConfirmPasswordTextBox.Text;
        if (password.Equals(confirmPassword))
        {
            string code = CodigoRecuperaciondHiddenField.Value.ToString();
            UsuarioBLL.updatePassword(code, password);
            panelSuccess.Visible = true;
            PanelCodigoIncorrecto.Visible = false;
            panelCodigoCorrecto.Visible = false;
        }
        else
        {
            MsgError.Text = "Las contraseñas deben ser iguales";
        }
    }
}