using Entidades.Seguridad;
using Negocio.Seguridad;

using Access.Seguridad;
using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

public partial class AdminUsers_RegistUsers : System.Web.UI.Page
{

    string strId;
    int codUsuario;

    protected void Page_Load(object sender, EventArgs e)
    {        
        lbVal.Visible = false;

        if (IsPostBack)
        {
            return;
        }

        cargarChekboxListRoles();

        string strId = Request.Params["Id"];
        if (string.IsNullOrEmpty(strId))
        {
            return;
        }
        recargarChekboxListRoles();
    }

    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        lbVal.Visible = false;
        strId = Request.Params["Id"];
        codUsuario = Convert.ToInt32(strId);
        
        try
        {
            int id = Convert.ToInt32(UserID.Value);

            string nombre = txtNombre.Text;
            string apellido = txtApellido.Text;
            string email = txtEmail.Text;
            string contraseña = txtPassword.Text;

            User objUser = new User()
            {
                Nombre = nombre,
                Apellido = apellido,
                Email = email,
                Contraseña = contraseña,
                TipoUsuario = "2",
                UsuarioId = codUsuario
            };           

            //Se Decide si Actualiza o Inserta Nuevo
            if (string.IsNullOrEmpty(strId))
            {   //Inserta Nuevo

                User objVali = UserBRL.getUserByEmail(email);

                if (objVali != null)
                {
                    lbVal.Text = "El email ingresado ya esta registrado en el Sistema";
                    lbVal.Visible = true;
                    return;
                }
                int  UserId = UserBRL.insertUser(objUser);

                // Insertando Roles a Usuario
                insertandoRoles(UserId);
            }
            else
            {
                //Actualizando Usuario
                UserBRL.updateUser(objUser);

                //Actualizar Roles
                Rol rol1;
                Rol rol2;
                for (int i = 0; i < CheckBoxListRoles.Items.Count; i++)
                {
                    if (CheckBoxListRoles.Items[i].Selected)
                    {
                        rol1 = RolBRL.getRolByNombre(CheckBoxListRoles.Items[i].Text);

                        if (!UsuarioRolBRL.TieneRolesAsignados(codUsuario, rol1.RolId))
                        {
                            List<RolPermiso> rolPer;

                            //Agregar
                            UsuarioPermiso userPer = new UsuarioPermiso();
                            UserRol userRol = new UserRol()
                            {
                                UsuarioId = codUsuario,
                                RolId = rol1.RolId
                            };

                            UsuarioRolBRL.insertUserRol(userRol);
                            rolPer = RolPermisoBRL.getPermisoIdByRolId(rol1.RolId);
                            foreach (var res in rolPer)
                            {
                                userPer.UsuarioId = codUsuario;
                                userPer.PermisoId = res.PermisoID;
                                userPer.Estado = "activo";
                                UsuarioPermisoBRL.insertUserPermiso(userPer);
                            }
                        }
                    }
                    else
                    {
                        List<UsuarioPermiso> Permisos;
                        rol2 = RolBRL.getRolByNombre(CheckBoxListRoles.Items[i].Text);
                        if (UsuarioRolBRL.TieneRolesAsignados(codUsuario, rol2.RolId))
                        {
                            //Eliminar
                            UsuarioRolBRL.eliminarUsuarioRolByRolIdPermisoId(codUsuario, rol2.RolId);
                            Permisos = UsuarioPermisoBRL.mostrarPermisos(codUsuario, rol2.RolId);
                            foreach (var res in Permisos)
                            {
                                UsuarioPermisoBRL.eliminarUsuarioPermisoByUsuarioIdPermisoId(codUsuario, res.PermisoId);
                            }
                        }
                    }

                }
            }
        }
        catch (Exception ex)
        {

        }
        Response.Redirect("ListUsers.aspx");
        
    }

    public void cargarChekboxListRoles()
    {
        List<Rol> roles = RolBRL.getRol();
        foreach (Rol rol in roles)
        {         
            CheckBoxListRoles.Items.Add(""+ rol.Nombre);
        }        
    }
    public void insertandoRoles(int codUser)
    {        
        try
        {
            List<RolPermiso> rolPer;
            Rol rol;
            for (int i = 0; i < CheckBoxListRoles.Items.Count; i++)
            {
                if (CheckBoxListRoles.Items[i].Selected)
                {
                    rol = RolBRL.getRolByNombre(CheckBoxListRoles.Items[i].Text);

                    UserRol userRol = new UserRol()
                    {
                        UsuarioId = codUser,
                        RolId = rol.RolId,
                        Estado = "activo"
                    };
                    UsuarioRolBRL.insertUserRol(userRol);

                    rolPer = RolPermisoBRL.getPermisoIdByRolId(rol.RolId);
                    
                    UsuarioPermiso userPer = new UsuarioPermiso();
                    foreach(var res in rolPer)
                    {
                        userPer.UsuarioId = codUser;
                        userPer.PermisoId = res.PermisoID;
                        userPer.Estado = "activo";
                        UsuarioPermisoBRL.insertUserPermiso(userPer);
                    }                                   
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void recargarChekboxListRoles()
    {
        string strId = Request.Params["Id"];
        int codUsuario = Convert.ToInt32(strId);

        int id = 0;
        try
        {
            id = Convert.ToInt32(strId);
        }
        catch (Exception ex)
        {
            Console.Write(ex.Message);
        }

        if (id <= 0)
        {
            return;
        }

        User objUser = UserBRL.getUserById(id);

        txtEmail.Visible = false;
        txtPassword.Visible = false;

        string nombre = txtNombre.Text;
        string apellido = txtApellido.Text;
        string email = txtEmail.Text;
        string contraseña = txtPassword.Text;


        txtNombre.Text = objUser.Nombre.Trim();
        txtApellido.Text = objUser.Apellido.Trim();

        Rol rol;
        for (int i = 0; i < CheckBoxListRoles.Items.Count; i++)
        {
            rol = RolBRL.getRolByNombre(CheckBoxListRoles.Items[i].Text);
            if (UsuarioRolBRL.TieneRolesAsignados(codUsuario, rol.RolId))
            {
                CheckBoxListRoles.Items[i].Selected = true;
            }
        }
    }
}