using Entidades.Seguridad;
using Negocio.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminSecurity_LoginUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["User"] = null;
    }

    protected void btnInitSesion_Click(object sender, EventArgs e)
    {
        lbValidator.Visible = false;
        string email = txtEmail.Text;
        string password = txtPassword.Text;

        User obj = UserBRL.getUserByEmail(email);

        if (obj == null)
        {
            lbValidator.Text = "El email ingresado no está registrado en el Sistema";
            lbValidator.Visible = true;
            lbValidator.ForeColor = System.Drawing.Color.Red;

            return;
        }

        if (!obj.Contraseña.Trim().Equals(password)) 
        {
            lbValidator.Text = "El Contraseña incorrecta";
            lbValidator.Visible = true;
            lbValidator.ForeColor = System.Drawing.Color.Red;
            return;
        }

        Session["User"] = obj;

        Response.Redirect("~/Productos/ListProductos.aspx");
    }
}