using CapaAcceso.App_Code.BLL.Seguridad;
using CapaAcceso.App_Code.Model.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Usuarios_DetalleRol : System.Web.UI.Page
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
            List<Permiso> list =PermisoBLL.getAllPermisosByUserId(RolId);
            AsignarPermisosGridView.DataSource = list;
            AsignarPermisosGridView.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    public int RolId
    {
        set { RoleIdHiddenField.Value = value.ToString(); }
        get
        {
            int RoleId = 0;
            try
            {
                RoleId = Convert.ToInt32(RoleIdHiddenField.Value);
            }
            catch (Exception ex)
            {

            }
            return RoleId;
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
       
        
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
            foreach (GridViewRow row in AsignarPermisosGridView.Rows)
            {
                    CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                    if (chkRow.Checked)
                    {
                try
                {
                    RolBLL.insertRolesPermisos(Convert.ToInt32(row.Cells[1].Text), RolId);

                }
                catch (Exception ex)
                {
                    Console.WriteLine("salio mal samierda");
                    return;
                }

                //Insert Permiso
                //string name = row.Cells[1].Text;
                //string country = (row.Cells[2].FindControl("lblCountry") as Label).Text;
                //dt.Rows.Add(name, country);
            }
            }
        Response.Redirect("ListaRoles.aspx");


        return;
    }

    protected void AsignarPermisosGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
}