using Access.Seguridad;
using Entidades.Seguridad;
using Negocio.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminSecurity_ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txtPassword.Visible = false;
        txtRePassword.Visible = false;
        btnChangePassword.Visible = false;
        lbEstado.Visible = false;
        string code = Request.Params["code"];
        if (string.IsNullOrEmpty(code))
        {
            txtEmail.InnerText = "El Link ha expirado o es invalido";
            return;
        }
        Recuperacion objRecup = RecuperacionBRL.getRecuperacionByCode(code);
        if (objRecup == null)
        {
            txtEmail.InnerText = "El Link ha expirado o es invalido";
            return;
        }

        if (objRecup.Estado == '0')
        {
            txtEmail.InnerText = "El Link ha expirado o es invalido";
            return;
        }

        TimeSpan ts = DateTime.Now - objRecup.FechaGenerado;
        int diference = ts.Hours;

        if (diference > objRecup.Tiempo)
        {
            txtEmail.InnerText = "El Link ha expirado o es invalido";
            return;
        }



        User objUser = UserBRL.getUserById(objRecup.UsuarioId);
        txtEmail.InnerText = "Recuperacion de contraseña de cuenta: " + objUser.Email;
        txtPassword.Visible = true;
        txtRePassword.Visible = true;
        btnChangePassword.Visible = true;
    }

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        string pass = txtPassword.Text;
        string repass = txtRePassword.Text;

        if (pass.Equals(repass))
        {
            string code = Request.Params["code"];
            Recuperacion objRecup = RecuperacionBRL.getRecuperacionByCode(code);
            objRecup.FechaActual = DateTime.Now;
            objRecup.Estado = '0';
            RecuperacionBRL.updateRecuperacion(objRecup);
            
            User objUser = UserBRL.getUserById(objRecup.UsuarioId);
            objUser.Contraseña = pass;
            UserBRL.updateUser(objUser);
            lbEstado.Text = "Se ha cambiado la contraseña correctamente";
            lbEstado.ForeColor = System.Drawing.Color.Green;
            lbEstado.Visible = true;

            Response.Redirect("LoginUsers.aspx");

        } else
        {
            lbEstado.Text = "Las Contraseñas no Coinciden";
            lbEstado.ForeColor = System.Drawing.Color.Red;
            lbEstado.Visible = true;
        }
        
    }
}