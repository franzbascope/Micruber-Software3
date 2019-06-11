using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VentasNur.Model;

public partial class Ruta_DetalleVehiculo : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
            ProcesarParametros();
        else
        {
            return;
        }

        try
        {
            // List<Permiso> list = PermisoBLL.getAllPermisos();
            List<Linea> list = LineaBLL.getAllLineasByVehiculoId(VehiculoId);
            AsignarLineaGridView.DataSource = list;
            AsignarLineaGridView.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    public int VehiculoId
    {
        set { RoleIdHiddenField.Value = value.ToString(); }
        get
        {
            int VehiculoId = 0;
            try
            {
                VehiculoId = Convert.ToInt32(RoleIdHiddenField.Value);
            }
            catch (Exception ex)
            {

            }
            return VehiculoId;
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
    }
    protected void SaveButton_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in AsignarLineaGridView.Rows)
        {
            CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
            if (chkRow.Checked)
            {
                try
                {
                    VehiculoBLL.insertLineaVehiculo(Convert.ToInt32(row.Cells[1].Text), VehiculoId);

                }
                catch (Exception ex)
                {
                    Console.WriteLine("salio mal samierda");
                    return;
                }
            }
        }
        Response.Redirect("ListaVehiculos.aspx");
        return;
    }

   
}