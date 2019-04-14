using Access.Seguridad;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Empresas_RegistEmpresa : System.Web.UI.Page
{
    Empresa objSelected;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            objSelected = null;
            List<TipoHijos> hijos = TipoHijoBRL.getTipoHijoByIdMaestro(1);
            EmpresaComboBox.DataSource = hijos;
            EmpresaComboBox.DataBind();
            Response.Cache.SetCacheability(HttpCacheability.ServerAndNoCache);
            Response.Cache.SetAllowResponseInBrowserHistory(false);
            Response.Cache.SetNoStore();
        }

        lbRist.InnerText = "Registrar Empresa";
        lbVal.Text = "";

        //Por si hay Id

        string cadIdEmpresa = Request.Params["Id"];
        if (String.IsNullOrEmpty(cadIdEmpresa))
        {
            return;
        }

        int idEmpresa = 0;
        idEmpresa = Convert.ToInt32(cadIdEmpresa);

        objSelected = EmpresaBRL.getEmpresaById(idEmpresa);
        if (!IsPostBack)
        {
            lbRist.InnerText = "Editar Empresa";
            txtNit.Text = objSelected.Nit;
            txtNombreEmp.Text = objSelected.Nombre;
            txtGerente.Text = objSelected.Gerente;
            txtTelefono.Text = objSelected.Telefono;

            EmpresaComboBox.SelectedValue = objSelected.TipoIdc.ToString();
        }
    }

    protected void EmpresaComboBox_DataBound(object sender, EventArgs e)
    {
        EmpresaComboBox.Items.Insert(0, new ListItem("Seleccione un Tipo de Empresa...", ""));
    }

    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        lbVal.Text = "";
        string nit = txtNit.Text.Trim();
        string nombre = txtNombreEmp.Text.Trim();
        string gerente = txtGerente.Text.Trim();
        string telefono = txtTelefono.Text.Trim();
        
        if (String.IsNullOrEmpty(nit))
        {
            lbVal.Text = "La casilla Nit no debe estar Vacía";
            return;
        }
        if (String.IsNullOrEmpty(nombre))
        {
            lbVal.Text = "La casilla Nombre no debe estar Vacía";
            return;
        }
        if (String.IsNullOrEmpty(gerente))
        {
            lbVal.Text = "La casilla Gerente no debe estar Vacía";
            return;
        }
        if (String.IsNullOrEmpty(telefono))
        {
            lbVal.Text = "La casilla Telefono no debe estar Vacía";
            return;
        }

        string value = EmpresaComboBox.SelectedValue;
        int indexSelected = EmpresaComboBox.SelectedIndex;
        if (indexSelected == 0)
        {
            lbVal.Text = "Debe Seleccionar un Tipo de Empresa";
            return;
        }

        

        if (objSelected == null)
        {
            objSelected = new Empresa();
        }
        objSelected.TipoIdc = Convert.ToInt32(value);
        objSelected.Nit = nit;
        objSelected.Nombre = nombre;
        objSelected.Gerente = gerente;
        objSelected.Telefono = telefono;
        objSelected.Estado = true;

        if (objSelected.EmpresaId == 0)
        {
            Empresa tempName = EmpresaBRL.getEmpresaByNombre(nombre);
            if (tempName != null)
            {
                lbVal.Text = "Ya existe una empresa con con ese nombre";
                return;
            }
            EmpresaBRL.insertEmpresa(objSelected);
        }
        else
        {
            EmpresaBRL.updateEmpresa(objSelected);
        }

        lbVal.Text = "";

        Response.Redirect("ListEmpresas.aspx");
    }
}