<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" 
    AutoEventWireup="true" 
    CodeFile="RegistUsers.aspx.cs" 
    Inherits="AdminUsers_RegistUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="formRegist" class="col-md-6  col-md-offset-3" runat="server">
        <h2>Registrar Administradores</h2>
        <br />
        <asp:HiddenField ID="UserID" runat="server" Value="0" />
        <div class="form-group">
            <asp:TextBox ID="txtNombre" runat="server" 
                CssClass="form-control" 
                placeholder="Nombre">
            </asp:TextBox>
            <asp:RequiredFieldValidator runat="server"
                ControlToValidate="txtNombre"
                Display="Dynamic"
                ErrorMessage="Debe ingresar su nombre"
                ForeColor="Red"
                ValidationGroup="AddRoles">
            </asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <asp:TextBox ID="txtApellido" runat="server" 
                CssClass="form-control" 
                placeholder="Apellidos">
            </asp:TextBox>
            <asp:RequiredFieldValidator runat="server"
                ControlToValidate="txtApellido"
                Display="Dynamic"
                ErrorMessage="Debe ingresar su Apellido"
                ForeColor="Red"
                ValidationGroup="AddRoles">
            </asp:RequiredFieldValidator>     
        </div>

        <div class="form-group">
            <asp:TextBox ID="txtEmail" runat="server" 
                CssClass="form-control" 
                placeholder="Email">
            </asp:TextBox>
            <asp:RequiredFieldValidator runat="server"
                ControlToValidate="txtEmail"
                Display="Dynamic"
                ErrorMessage="Debe ingresar su Apellido"
                ForeColor="Red"
                ValidationGroup="AddRoles">
            </asp:RequiredFieldValidator>

 
        </div>

        <div class="form-group">
            <asp:TextBox ID="txtPassword" runat="server" 
                CssClass="form-control" 
                placeholder="Password" 
                TextMode="Password">
            </asp:TextBox>
            <asp:RequiredFieldValidator runat="server"
                ControlToValidate="txtPassword"
                Display="Dynamic"
                ErrorMessage="Debe ingresar su Constraseña"
                ForeColor="Red"
                ValidationGroup="AddRoles">
            </asp:RequiredFieldValidator>
 
        </div>
        <div class="form-group" runat="server" visible ="true">
            <h4>Roles de Administrador</h4>

            <asp:CheckBoxList ID="CheckBoxListRoles" style="padding-left:35px" runat="server" CssClass="checkbox-inline">

            </asp:CheckBoxList>
            <br />
            <br />

            <asp:HyperLink runat="server" NavigateUrl="~/Rol/RegistroRol.aspx">
                AÑADIR NUEVO ROL +
            </asp:HyperLink>
        </div>


        <asp:Button ID="btnRegistrar" runat="server" 
            Text="Registrar" 
            CssClass="btn btn-primary" 
            OnClick="btnRegistrar_Click" 
            ValidationGroup="AddRoles"/>
         
        <asp:Label ID="lbVal" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label>
         
    </div>
</asp:Content>

