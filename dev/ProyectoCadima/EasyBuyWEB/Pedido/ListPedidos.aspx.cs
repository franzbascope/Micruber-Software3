using Entidades.Seguridad;
using Negocio.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pedido_ListPedidos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cargarPedidos();
        }
    }

    public void cargarPedidos()
    {
        List<Pedido> listPedidos = PedidoBRL.GetPedidos();
        GridPedidos.DataSource = listPedidos;
        GridPedidos.DataBind();
    }

    protected void GridPedidos_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int pedidoId = 0;
        try
        {
            pedidoId = Convert.ToInt32(e.CommandArgument);
        }
        catch (Exception ex)
        {
        }
        
        if (e.CommandName == "Ver")
        {
            Response.Redirect("~/Pedido/FormPedido.aspx?Id=" + pedidoId);
        }
    }
}