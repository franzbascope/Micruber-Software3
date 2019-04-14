using Access.Seguridad;
using Entidades.Seguridad;
using Negocio.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pedido_FormPedido : System.Web.UI.Page
{
    Pedido objSelected;
    protected void Page_Load(object sender, EventArgs e)
    {
        string cadIdPedido = Request.Params["Id"];
        if (String.IsNullOrEmpty(cadIdPedido))
        {
            return;
        }

        int pedidoId = 0;
        pedidoId = Convert.ToInt32(cadIdPedido);

        objSelected = PedidoBRL.GetPedidoByID(pedidoId);

        if (!IsPostBack)
        {
            cargarDatos(pedidoId);
            cargarPedidos(pedidoId);
        }
        
    }

    protected void btnAtender_Click(object sender, EventArgs e)
    {
        PedidoBRL.AtenderPedido(objSelected.PedidoId);
        btnAtender.Enabled = false;
        lbPed.InnerText = "Pedido Atendido";
    }

    public void cargarDatos(int pedidoId)
    {        
        Empresa objEmpresa = EmpresaBRL.getEmpresaById(objSelected.EmpresaId);
        User objCliente = UserBRL.getUserById(objSelected.ClienteId);

        if (objSelected.Atendido)
        {
            lbPed.InnerText = "Pedido Atendido";
            btnAtender.Enabled = false;
        } else
        {
            lbPed.InnerText = "Pedido pendiente por Atender";
            btnAtender.Enabled = true;
        }

        txtCliente.Text = objCliente.Nombre + " " + objCliente.Apellido;
        txtCorreo.Text = objCliente.Email;
        txtNombreEmp.Text = objEmpresa.Nombre;
        txtFecha.Text = objSelected.Fecha.ToString();
        string disp;
        if (objSelected.IsMovil)
        {
            disp = "Teléfono Móvil";
        } else {
            disp = "Dash-Button";
        }
        txtDispositivo.Text = disp;

        GMap.Text = "<google-map latitude='" + objSelected.Latitud + "' longitude='" + objSelected.Longitud + "' zoom='15' fit-to-markers api-key='AIzaSyD3E1D9b-Z7ekrT3tbhl_dy8DCXuIuDDRc'>" +
            " <google-map-marker latitude='" + objSelected.Latitud + "' longitude='" + objSelected.Longitud + "' draggable='false'></google-map-marker>" +
                         "</google-map>";
    }


    protected void GridPedido_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }

    public void cargarPedidos(int pedidoId)
    {
        txtPagoFinal.Text = objSelected.TotalPago.ToString();
        List<DetallePedido> listDetalle = DetallePedidoBRL.getDatallesByPedidoId(pedidoId);
        GridPedido.DataSource = listDetalle;
        GridPedido.DataBind();
    }

    protected void Imprimir_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Pedido/ImpReportPedido.aspx?Id=" + objSelected.PedidoId);
    }
}