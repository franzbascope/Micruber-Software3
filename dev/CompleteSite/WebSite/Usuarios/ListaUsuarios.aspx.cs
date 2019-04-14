using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VentasNur.Model;

public partial class Usuarios_ListaUsuarios : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CargarUsuarios();


        }
    }
    private void CargarUsuarios()
    {
        try
        {
            List<Usuario> usuarios = UsuarioBLL.getAllUsuarios();
            UsuarioGridView.DataSource = usuarios;
            UsuarioGridView.DataBind();
        }
        catch (Exception ex)
        {

        }
    }

    protected void UsuarioGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int usuarioId = 0;
        try
        {
            usuarioId = Convert.ToInt32(e.CommandArgument);
        }
        catch (Exception ex)
        {

        }
        if (usuarioId <= 0)
            return;
        if (e.CommandName == "Editar")
        {
            Response.Redirect("DetalleUsuario.aspx?UsuarioId=" + usuarioId);
            return;
        }
        if (e.CommandName == "Eliminar")
        {
            try
            {
                UsuarioBLL.deleteUsuario(usuarioId);
                CargarUsuarios();
            }
            catch (Exception ex)
            {

            }
        }
    }
}