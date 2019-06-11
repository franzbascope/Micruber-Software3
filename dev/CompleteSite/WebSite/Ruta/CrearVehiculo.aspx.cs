using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VentasNur.Model;

public partial class Ruta_CrearVehiculo : System.Web.UI.Page
{
    public int VehiculoId
    {
        set { UsuarioIdHiddenField.Value = value.ToString(); }
        get
        {
            int vehiculoId = 0;
            try
            {
                vehiculoId = Convert.ToInt32(UsuarioIdHiddenField.Value);
            }
            catch (Exception ex)
            {

            }
            return vehiculoId;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ProcesarParametros();
        }
    }

    private void ProcesarParametros()
    {
        if (Request.QueryString["VehiculoId"] != null && !string.IsNullOrEmpty(Request.QueryString["VehiculoId"]))
        {
            try
            {
                VehiculoId = Convert.ToInt32(Request.QueryString["VehiculoId"]);
            }
            catch (Exception ex)
            {

            }
        }
        if (VehiculoId > 0)
        {
            LabelTitle.Text = "Editar";
            CargarDatos(VehiculoId);
        }
        else
            LabelTitle.Text = "Nuevo";
    }
    private void CargarDatos(int vehiculoId)
    {
        try
        {
            Vehiculo obj = VehiculoBLL.getVehiculoById(vehiculoId);
            NombreTextBox.Text = obj.placa;
            CantidadTextBox.Text = obj.capacidad.ToString();


        }
        catch (Exception ex)
        {
            MsgLiteral.Text = "Error al obtener el vehiculo";
            PanelError.Visible = true;
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        PanelError.Visible = false;

        try
        {
            Vehiculo obj = new Vehiculo()
            {
                vehiculoId = VehiculoId,
                placa=NombreTextBox.Text,
                capacidad =Convert.ToInt32(CantidadTextBox.Text)
            };

            if (VehiculoId > 0)
                VehiculoBLL.updateVehiculo(obj);
            else
                VehiculoBLL.insertVehiculo(obj);

        }
        catch (Exception ex)
        {
            MsgLiteral.Text = "Error al guardar el vehiculo";
            PanelError.Visible = true;
            return;
        }

        Response.Redirect("ListaVehiculos.aspx");

    }

}