using Access.Seguridad;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dash_ListDash : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            List<DashButton> listDash = DashBRL.GetAllDash();
            GridDash.DataSource = listDash;
            GridDash.DataBind();
        }
    }
    protected void GridDash_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
}