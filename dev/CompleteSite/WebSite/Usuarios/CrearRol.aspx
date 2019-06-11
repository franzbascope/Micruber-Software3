<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CrearRol.aspx.cs" Inherits="Usuarios_CrearRol"  MasterPageFile="~/MasterPages/MasterPage.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5>
                <asp:Literal runat="server" ID="LabelTitle"></asp:Literal>
                Rol
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
                        <asp:Label runat="server" AssociatedControlID="NombreTextBox">Descripcion</asp:Label>
                        <asp:TextBox ID="NombreTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                        <div class="text-danger">
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic"
                                ErrorMessage="Debe ingresar la descripcion"
                                ValidationGroup="Rol"
                                ControlToValidate="NombreTextBox">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>


                    <div class="form-group">
                        <asp:LinkButton ID="SaveButton" runat="server" OnClick="SaveButton_Click"
                            CssClass="btn btn-primary"
                            ValidationGroup="Rol">
                    Guardar
                        </asp:LinkButton>
                        <asp:HyperLink runat="server" NavigateUrl="~/Usuarios/ListaRoles.aspx" CssClass="btn">
                    Cancelar
                        </asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <asp:HiddenField ID="UsuarioIdHiddenField" runat="server" Value="0" />     
   

        </asp:Content>
