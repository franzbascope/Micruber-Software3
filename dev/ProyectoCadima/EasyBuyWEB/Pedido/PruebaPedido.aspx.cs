using Negocio.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pedido_PruebaPedido : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSendPedido_Click(object sender, EventArgs e)
    {
        if (PedidoBRL.enviarPedido(4))
        {
            lbRes.Text = "Pedido enviado";
        } else
        {
            lbRes.Text = "Error al enviar pedido";
        }     
    }
}