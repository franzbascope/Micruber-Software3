<%@ Page Title="Usuarios" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Usuarios_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5>
                <asp:Literal runat="server" ID="LabelTitle"></asp:Literal>
                Cambiar Contraseña
            </h5>        
                         <asp:Panel ID="PanelError" runat="server" Visible="false" CssClass="alert alert-danger" role="alert">
                <asp:Literal ID="MsgLiteral" runat="server"></asp:Literal>
            </asp:Panel>
                </div>
             <%--   <asp:Panel ID="SuccessPanel" runat="server" Visible="false" CssClass="alert alert-success" role="alert">
               <label>Contraseña actualizada correctamente</label>
            </asp:Panel>--%>
                <div class="card-body">
                    <div class="form-group">
                        <asp:Label runat="server" >Ingrese su antigua contraseña</asp:Label>
                        <asp:TextBox ID="CurrentPasswordtextBox"  type="password" runat="server" CssClass="form-control"></asp:TextBox>
                        <div class="text-danger">
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic"
                                ErrorMessage="Debe ingresar su antigua contraseña"
                                ValidationGroup="UpdatePassword"
                                ControlToValidate="CurrentPasswordtextBox">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div  runat="server" class="form-group">
                        <asp:Label runat="server">Nueva Contraseña</asp:Label>
                        <asp:TextBox ID="NewPasswordTextBox" type="password" runat="server" CssClass="form-control"></asp:TextBox>
                        <div class="text-danger">
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic"
                                ErrorMessage="Debe ingresar su nueva contraseña"
                                ValidationGroup="UpdatePassword"
                                ControlToValidate="NewPasswordTextBox">
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="PasswordValidor" ValidationGroup="UpdatePassword" runat="server"
                                ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,15}$"
                                ControlToValidate="NewPasswordTextBox" ErrorMessage="La contraseña debe tener al menos una letra mayuscula, un numero
                                y tener mas de 6 caracteres y un maximo de 15 caracteres">
                            </asp:RegularExpressionValidator>	
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:LinkButton ID="SaveButton" runat="server" OnClick="SaveButton_Click"
                            CssClass="btn btn-primary"
                            ValidationGroup="UpdatePassword">
                    Guardar
                        </asp:LinkButton>
                        <asp:HyperLink runat="server" NavigateUrl="~/Index.aspx" CssClass="btn">
                    Cancelar
                        </asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <asp:HiddenField ID="UsuarioIdHiddenField" runat="server" Value="0" />
</asp:Content>
