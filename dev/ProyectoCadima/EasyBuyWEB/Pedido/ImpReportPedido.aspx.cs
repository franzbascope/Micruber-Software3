using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pedido_ImpReportPedido : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            int PedidoId = Convert.ToInt32(Request.QueryString["Id"]);
            PedidoIdHiddenField.Value = PedidoId.ToString();
        }
        catch
        {

        }
    }
}