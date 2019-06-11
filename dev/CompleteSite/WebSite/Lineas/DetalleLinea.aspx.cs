using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VentasNur.Model;

public partial class Lineas_DetalleLineas : System.Web.UI.Page
{
    public int LineaId
    {
        set { LineaIdHiddenField.Value = value.ToString(); }
        get
        {
            int lineaId = 0;
            try
            {
                lineaId = Convert.ToInt32(LineaIdHiddenField.Value);
            }
            catch (Exception ex)
            {

            }
            return lineaId;
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
        if (Request.QueryString["LineaId"] != null && !string.IsNullOrEmpty(Request.QueryString["LineaId"]))
        {
            try
            {
                LineaId = Convert.ToInt32(Request.QueryString["LineaId"]);
            }
            catch (Exception ex)
            {

            }
        }

        if (LineaId > 0)
        {
            LabelTitle.Text = "Editar";
            CargarDatos(LineaId);
        }
        else
            LabelTitle.Text = "Nuevo";
    }
    private void CargarDatos(int lineaId)
    {
        try
        {
            Linea obj = LineaBLL.getLineaById(lineaId);
            NumeroLineaTextBox.Text = obj.numeroLinea;

        }
        catch (Exception ex)
        {
            MsgLiteral.Text = "Error al obtener los datos";
            PanelError.Visible = true;
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        PanelError.Visible = false;
        try
        {
            Linea obj = new Linea()
            {
                numeroLinea = NumeroLineaTextBox.Text,
                lineaId = LineaId
            };

            if (LineaId > 0)
                LineaBLL.updateLinea(obj);
            else
                LineaBLL.insertLinea(obj);

        }
        catch (Exception ex)
        {
            MsgLiteral.Text = "Error al guardar la línea";
            PanelError.Visible = true;
            return;
        }

        Response.Redirect("ListaLineas.aspx");

    }
}