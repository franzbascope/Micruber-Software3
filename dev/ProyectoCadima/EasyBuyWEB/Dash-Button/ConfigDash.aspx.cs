using Access.Seguridad;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dash_Button_ConfigDash : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Response.Cache.SetCacheability(HttpCacheability.ServerAndNoCache);
            Response.Cache.SetAllowResponseInBrowserHistory(false);
            Response.Cache.SetNoStore();
        }
        string cadIdDash = Request.Params["Id"];
        if (String.IsNullOrEmpty(cadIdDash))
        {
            return;
        }

        int DashId = 0;
        DashId = Convert.ToInt32(cadIdDash);

        ConfigDash obj = ConfigDashBRL.GetConfigDashByDashID(DashId);

        txtConfig.InnerText = obj.ConfigDashId + "|" + obj.DashId + "|" + obj.UserId + "|"
            + obj.ProductoId + "|" + obj.EmpresaId + "|" + obj.Cantidad + "|" + obj.Fecha;
    }
}