using CapaAcceso.App_Code.BLL.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class Index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
            return;
        try
        {
            List<Reporte> rep = LineaBLL.GetNroLineaUltimoMes();
            var jsonSerialiser = new JavaScriptSerializer();
            var json = jsonSerialiser.Serialize(rep);
            lineaRep.Value = json; 


        }catch(Exception ex)
        {

        }
    }
}