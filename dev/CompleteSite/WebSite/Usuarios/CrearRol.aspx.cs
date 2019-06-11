using CapaAcceso.App_Code.BLL.Seguridad;
using CapaAcceso.App_Code.Model.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Usuarios_CrearRol : System.Web.UI.Page
{
    public int RolId
    {
        set { UsuarioIdHiddenField.Value = value.ToString(); }
        get
        {
            int usuarioId = 0;
            try
            {
                usuarioId = Convert.ToInt32(UsuarioIdHiddenField.Value);
            }
            catch (Exception ex)
            {

            }
            return usuarioId;
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
        if (Request.QueryString["RoleId"] != null && !string.IsNullOrEmpty(Request.QueryString["RoleId"]))
        {
            try
            {
                RolId = Convert.ToInt32(Request.QueryString["RoleId"]);
            }
            catch (Exception ex)
            {

            }
        }
        if (RolId > 0)
        {
            LabelTitle.Text = "Editar";
            CargarDatos(RolId);
        }
        else
            LabelTitle.Text = "Nuevo";
    }
    private void CargarDatos(int rolId)
    {
        try
        {
            Rol obj = RolBLL.getRolById(rolId);
            NombreTextBox.Text = obj.descripcion;

        }
        catch (Exception ex)
        {
            MsgLiteral.Text = "Error al obtener el Rol";
            PanelError.Visible = true;
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        PanelError.Visible = false;
       
        try
        {
            Rol obj = new Rol()
            {
                roleId = RolId,
                descripcion=NombreTextBox.Text
            };

            if (RolId > 0)               
                RolBLL.updateRol(obj);
            else
                RolBLL.insertRol(obj);

        }
        catch (Exception ex)
        {
            MsgLiteral.Text = "Error al guardar el rol";
            PanelError.Visible = true;
            return;
        }

        Response.Redirect("ListaRoles.aspx");

    }
}