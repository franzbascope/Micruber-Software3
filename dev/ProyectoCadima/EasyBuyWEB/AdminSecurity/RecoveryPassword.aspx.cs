using System;
using Negocio.Seguridad;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entidades.Seguridad;

public partial class AdminSecurity_RecoveryPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lbEstado.Text = "";
    }

    protected void btnEnviarCode_Click(object sender, EventArgs e)
    {

        string emailReceptor = txtEmail.Text;
        if (String.IsNullOrEmpty(emailReceptor))
        {
            lbValidation.Text = "Debe Ingresar su Email";
            lbValidation.Visible = true;
            return;
        }

        User obj = UserBRL.getUserByEmail(emailReceptor);
        if (obj == null)
        {
            lbValidation.Text = "El email no está registrado en el Sistema";
            lbValidation.Visible = true;
            return;
        }

        if (UserBRL.enviarEmail(emailReceptor, obj))
        {
            lbEstado.Text = "Codigo de Recuperación enviado correctamente";
        }
        else
        {
            lbEstado.Text = "Error al enviar Codigo de Recuperación";
        }
        lbValidation.Visible = false;
    }
}