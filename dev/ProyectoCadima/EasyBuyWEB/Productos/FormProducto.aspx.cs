using Access.Seguridad;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Productos_FormProducto : System.Web.UI.Page
{
    Producto objSelected;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            objSelected = null;
            //Empresas
            List<Empresa> empresas = EmpresaBRL.getEmpresas();
            EmpresaComboBox.DataSource = empresas;
            EmpresaComboBox.DataBind();
            //Tipo Producto
            List<TipoHijos> tipoHijos = TipoHijoBRL.getTipoHijoByIdMaestro(2);
            
            TipoProdComboBox.DataSource = tipoHijos;
            TipoProdComboBox.DataBind();

            Response.Cache.SetCacheability(HttpCacheability.ServerAndNoCache);
            Response.Cache.SetAllowResponseInBrowserHistory(false);
            Response.Cache.SetNoStore();
        }
        lbRist.InnerText = "Registrar Productos";
        lbVal.Text = "";

        string cadIdProducto = Request.Params["Id"];
        if (String.IsNullOrEmpty(cadIdProducto))
        {
            return;
        }

        int idProducto = 0;
        idProducto = Convert.ToInt32(cadIdProducto);

        objSelected = ProductoBRL.getProductoById(idProducto);

        if (!IsPostBack)
        {
            lbRist.InnerText = "Editar Producto";
            txtNombreProd.Text = objSelected.Nombre;
            txtPrecio.Text = objSelected.Precio.ToString(CultureInfo.InvariantCulture);

            EmpresaComboBox.SelectedValue = objSelected.EmpresaId.ToString();
            TipoProdComboBox.SelectedValue = objSelected.TipoIdc.ToString();

        }
    }
    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        try
        {
            string nombre = txtNombreProd.Text.Trim();
            decimal precio = Convert.ToDecimal(txtPrecio.Text, CultureInfo.InvariantCulture);

            if (EmpresaComboBox.Items.Count == 1)
            {
                lbVal.Text = "Debe Registrar Empresas";
                return;
            }

            if (String.IsNullOrEmpty(nombre))
            {
                lbVal.Text = "La Casilla nombre no debe estar Vacía";
                return;
            }
            if (precio < 0)
            {
                lbVal.Text = "Debe ingresar un valor de Precio Positivo";
            }

            int indexSelectTipoProd = TipoProdComboBox.SelectedIndex;
            int indexSelectEmpresa = EmpresaComboBox.SelectedIndex;
            int tipoIdc = Convert.ToInt32(TipoProdComboBox.SelectedValue);
            int empresaId = Convert.ToInt32(EmpresaComboBox.SelectedValue);

            if (indexSelectEmpresa == 0)
            {
                lbVal.Text = "Debe seleccionar un tipo de Empresa";
                return;
            }
            if (indexSelectTipoProd == 0)
            {
                lbVal.Text = "Debe seleccionar un tipo de Producto";
                return;
            }

            if (objSelected == null)
            {
                objSelected = new Producto();
            }

            objSelected.EmpresaId = empresaId;
            objSelected.TipoIdc = tipoIdc;
            objSelected.Nombre = nombre;
            objSelected.Precio = precio;
            objSelected.Estado = true;

            if (objSelected.ProductoId == 0)
            {
                ProductoBRL.insertProducto(objSelected);
            }
            else
            {
                ProductoBRL.updateProducto(objSelected);
            }

            Response.Redirect("ListProductos.aspx");
            lbVal.Text = "";
        }
        catch (Exception ex)
        {
            lbVal.Text = ex.Message;
        }

    }
    protected void EmpresaComboBox_DataBound(object sender, EventArgs e)
    {
        EmpresaComboBox.Items.Insert(0, new ListItem("Seleccione una Empresa...", ""));
    }
    protected void TipoProdComboBox_DataBound(object sender, EventArgs e)
    {
        TipoProdComboBox.Items.Insert(0, new ListItem("Seleccione un Tipo Producto...", ""));
    }

}