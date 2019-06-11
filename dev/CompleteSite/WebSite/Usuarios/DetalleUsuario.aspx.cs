using CapaAcceso.App_Code.BLL.Seguridad;
using CapaAcceso.App_Code.Model.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VentasNur.Model;

public partial class Usuarios_DetalleUsuario : System.Web.UI.Page
{
    public int UsuarioId
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
        if (Request.QueryString["UsuarioId"] != null && !string.IsNullOrEmpty(Request.QueryString["UsuarioId"]))
        {
            try
            {
                UsuarioId = Convert.ToInt32(Request.QueryString["UsuarioId"]);
            }
            catch (Exception ex)
            {

            }
        }
        if (UsuarioId > 0)
        {
            LabelTitle.Text = "Editar";
            CargarDatos(UsuarioId);
        }
        else
            LabelTitle.Text = "Nuevo";
        List<Rol> listaRoles = RolBLL.getAllRoles();
        RolDropDownLsit.DataTextField = "descripcion";
        RolDropDownLsit.DataValueField = "roleId";
        RolDropDownLsit.DataSource = listaRoles;
        RolDropDownLsit.DataBind();
    }
    private void CargarDatos(int usuarioId)
    {
        try
        {
            Usuario obj = UsuarioBLL.getUsuarioById(usuarioId);
            NombreTextBox.Text = obj.nombreCompleto;
            CorreoTextBox.Text = obj.correo;
            RolDropDownLsit.SelectedValue = obj.rolId.ToString();

        }
        catch (Exception ex)
        {
            MsgLiteral.Text = "Error al obtener el Producto";
            PanelError.Visible = true;
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {

        try
        {
            Usuario obj = new Usuario()
            {
                correo = CorreoTextBox.Text,
                nombreCompleto = NombreTextBox.Text,
                usuarioId = UsuarioId,
                rolId = Convert.ToInt32(RolDropDownLsit.SelectedValue)
            };

            if (UsuarioId > 0)
                UsuarioBLL.updateUsuario(obj);
            else
            {
                PanelError.Visible = false;
                string email = CorreoTextBox.Text;
                bool existeCorreo = UsuarioBLL.validateEmail(email);
                if (existeCorreo)
                {
                    MsgLiteral.Text = "El correo ingresado ya existe, ingrese otro";
                    PanelError.Visible = true;
                    return;
                }
                UsuarioBLL.insertUsuarioAdministracion(obj);
            }


        }
        catch (Exception ex)
        {
            MsgLiteral.Text = "Error al guardar el usuario";
            PanelError.Visible = true;
            return;
        }

        Response.Redirect("ListaUsuarios.aspx");

    }
}