using Access.Seguridad;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dash_Dash : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {            
            Response.Cache.SetCacheability(HttpCacheability.ServerAndNoCache);
            Response.Cache.SetAllowResponseInBrowserHistory(false);
            Response.Cache.SetNoStore();
        }
        lbValidator.Text = "";
        lbValidator.Visible = false;
    }

    protected void btnRegistrarDash_Click(object sender, EventArgs e)
    {
        string code = txtCodeDash.Text.Trim();
        if (string.IsNullOrEmpty(code))
        {
            lbValidator.Text = "No Deje el Campo CODE vacío";
            lbValidator.Visible = true;
            return;
        }

        DashButton obj = DashBRL.GetDashByCode(code);
        if (obj != null)
        {
            lbValidator.Text = "Ya Existe un dash con ese nombre";
            lbValidator.Visible = true;
            return;
        }
        obj = new DashButton()
        {
            Codigo = code,
            Estado = true
        };

        DashBRL.InsertDash(obj);
        lbValidator.Text = "";
        lbValidator.Visible = false;

        Response.Redirect("ListDash.aspx");
    }
}