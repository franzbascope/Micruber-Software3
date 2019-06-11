using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VentasNur.Model;

public partial class Ruta_ListaVehiculos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (IsPostBack)
            return;
        else
        {
            CargarVehiculo();
        }

    }
    protected void CargarVehiculo()
    {

        try
        {
            List<Vehiculo> list = VehiculoBLL.getAllVehiculos();
            VehiculoGridView.DataSource = list;
            VehiculoGridView.DataBind();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex);
        }
    }
    protected void VehiculoGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int roleId = 0;
        try
        {
            roleId = Convert.ToInt32(e.CommandArgument);
        }
        catch (Exception ex)
        {

        }
        if (e.CommandName == "Asignar")
        {
            Response.Redirect("DetalleVehiculo.aspx?VehiculoId=" + roleId);
            return;
        }
        if (e.CommandName == "Editar")
        {
            Response.Redirect("CrearVehiculo.aspx?VehiculoId=" + roleId);
        }
        if (e.CommandName == "Eliminar")
        {
            try
            {
                VehiculoBLL.deleteVehiculo(roleId);
                CargarVehiculo();
            }
            catch (Exception ex)
            {

            }
        }
    }
}