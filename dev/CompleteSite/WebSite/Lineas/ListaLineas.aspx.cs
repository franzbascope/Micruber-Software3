using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VentasNur.Model;

public partial class Lineas_ListaLineas : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CargarLineas();


        }
    }
    private void CargarLineas()
    {
        try
        {
            List<Linea> lineas = LineaBLL.getLineas();
            LineaGridView.DataSource = lineas;
            LineaGridView.DataBind();
        }
        catch (Exception ex)
        {

        }
    }

    protected void LineaGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int lineaId = 0;
        try
        {
            lineaId = Convert.ToInt32(e.CommandArgument);
        }
        catch (Exception ex)
        {

        }
        if (lineaId <= 0)
            return;
        if (e.CommandName == "Editar")
        {
            Response.Redirect("DetalleLinea.aspx?LineaId=" + lineaId);
            return;
        }
        if (e.CommandName == "Ruta")
        {
            Response.Redirect("RegistroRutas.aspx?LineaId=" + lineaId);
            return;
        }
        if (e.CommandName == "Eliminar")
        {
            try
            {
                LineaBLL.deleteLinea(lineaId);
                CargarLineas();
            }
            catch (Exception ex)
            {

            }
        }
    }
}