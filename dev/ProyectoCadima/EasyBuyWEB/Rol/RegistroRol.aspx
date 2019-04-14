<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="RegistroRol.aspx.cs" Inherits="Roles_RegistRol" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <h2>Registrar Roles</h2>
        <br />
        <asp:HiddenField ID="RolID" runat="server" Value="0" />
        <div class="col-md-6">
            <div class="form-group">
            <asp:TextBox ID="txtNombre" runat="server" 
                placeholder="Ingrese el Nombre de Rol" 
                CssClass="form-control">
            </asp:TextBox>

            </div>
            <div class="form-group">
                <asp:TextBox ID="txtDescripcion" TextMode="multiline" Columns="74" Rows="10"
                    CssClass="form-control" runat="server" placeholder="Descripcion de Rol">
                </asp:TextBox>
            </div>

           
        <h3>Asignar Permisos</h3>      

        <asp:CheckBoxList ID="checkPermisos" class="checkbox-inline"  runat="server">
            <asp:ListItem>Insertar Productos</asp:ListItem>
            <asp:ListItem>Eliminar Productos</asp:ListItem>
            <asp:ListItem>Modificar Productos</asp:ListItem>
            <asp:ListItem>Registrar Usuarios</asp:ListItem>
            <asp:ListItem>Eliminar Usuarios</asp:ListItem>
            <asp:ListItem>Modificar Usuarios</asp:ListItem>
            <asp:ListItem>Registrar Empresa</asp:ListItem>
            <asp:ListItem>Eliminar Empresa</asp:ListItem>
            <asp:ListItem>Modificar Empresa</asp:ListItem>
            <asp:ListItem>Ver Reportes</asp:ListItem>
        </asp:CheckBoxList>

        <asp:Button ID="btnRegistrar" 
            runat="server" 
            Text="Registrar"             
            CssClass="btn btn-primary btn-block" 
            OnClick="btnRegistrar_Click"/>    
           
        </div>
</asp:Content>  

