using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using VentasNur.Model;

public partial class Lineas_RegistroRutas : System.Web.UI.Page
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

        if (LineaId <= 0)
        {
            Response.Redirect("ListaLineas.aspx");
            return;
        }
        else {
            CargarDatos(LineaId);
        }

    }

    private void CargarDatos(int lineaId)
    {
        try
        {
            Linea obj = LineaBLL.getLineaById(lineaId);
            //NumeroLinea.Text = "Ruta Linea " + obj.numeroLinea;

        }
        catch (Exception ex)
        {
            
        }
    }

    [WebMethod]
    public static void deleteCoordenadas(int lineaId)
    {
        CoordenadaBLL.deleteCoordenadasByLineaId(lineaId);
    }

    [WebMethod]
    public static void InsertarCoordenadas(int lineaId, decimal latitud, decimal longitud)
    {
        Coordenada coordenada = new Coordenada();
        coordenada.latitud = latitud;
        coordenada.longitud = longitud;
        coordenada.lineaId = lineaId;
        
        CoordenadaBLL.insertCoordenada(coordenada);
    }

    /*
    [WebMethod]
    public static void InsertarCoordenadas(List<Coordenada> coordenadas)
    {
        for (int i = 0; i < coordenadas.Count; i++) {
            CoordenadaBLL.insertCoordenada(coordenadas[i]);
        }
    }
    */
    [WebMethod]
    public static List<Coordenada> mostrarCoordenadas(int lineaId)
    {
        List<Coordenada> listaCoordenadas = CoordenadaBLL.getCoordenadasByLineaId(lineaId);

        return listaCoordenadas.Count <= 0 ? new List<Coordenada>()  : listaCoordenadas;
    }
}