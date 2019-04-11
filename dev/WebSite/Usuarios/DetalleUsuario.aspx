<%@ Page Title="Usuarios" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="DetalleUsuario.aspx.cs" Inherits="Usuarios_DetalleUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5>
                <asp:Literal runat="server" ID="LabelTitle"></asp:Literal>
                Usuario
            </h5>            
            <asp:HyperLink runat="server" NavigateUrl="~/Usuarios/ListaUsuarios.aspx">
                Volver a la Lista de Usuarios
            </asp:HyperLink>
                    <asp:Panel ID="PanelError" runat="server" Visible="false" CssClass="alert alert-danger" role="alert">
                <asp:Literal ID="MsgLiteral" runat="server"></asp:Literal>
            </asp:Panel>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="NombreTextBox">Nombre Completo</asp:Label>
                        <asp:TextBox ID="NombreTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                        <div class="text-danger">
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic"
                                ErrorMessage="Debe ingresar el nombre"
                                ValidationGroup="Usuario"
                                ControlToValidate="NombreTextBox">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="CorreoTextBox">Correo</asp:Label>
                        <asp:TextBox ID="CorreoTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                        <div class="text-danger">
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic"
                                ErrorMessage="Debe ingresar el correo"
                                ValidationGroup="Usuario"
                                ControlToValidate="CorreoTextBox">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div id="divPassword" runat="server" class="form-group">
                        <asp:Label runat="server" AssociatedControlID="PasswordTextBox">Contraseña</asp:Label>
                        <asp:TextBox ID="PasswordTextBox" type="password" runat="server" CssClass="form-control"></asp:TextBox>
                        <div class="text-danger">
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic"
                                ErrorMessage="Debe ingresar su contraseña"
                                ValidationGroup="Usuario"
                                ControlToValidate="PasswordTextBox">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:LinkButton ID="SaveButton" runat="server" OnClick="SaveButton_Click"
                            CssClass="btn btn-primary"
                            ValidationGroup="Usuario">
                    Guardar
                        </asp:LinkButton>
                        <asp:HyperLink runat="server" NavigateUrl="~/Usuarios/ListaUsuarios.aspx" CssClass="btn">
                    Cancelar
                        </asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <asp:HiddenField ID="UsuarioIdHiddenField" runat="server" Value="0" />
</asp:Content>
