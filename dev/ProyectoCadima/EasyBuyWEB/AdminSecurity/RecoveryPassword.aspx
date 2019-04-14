<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage2.master" AutoEventWireup="true" CodeFile="RecoveryPassword.aspx.cs" Inherits="AdminSecurity_RecoveryPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br /><br /><br /><br /><br /><br /><br />
    <form id="formRegist" class="col-md-6  col-md-offset-3" runat="server">
        <h2>Recuperar Contraseña</h2>
        <p>
            <em>
                Coloque su email y presione "Enviar Codigo" para recibir un enlace y cambiar su contraseña.
            </em>
        </p>
        <br />
        <div class="form-group">
            <asp:textbox id="txtEmail" runat="server" cssclass="form-control" placeholder="Email">
            </asp:textbox>
            <asp:Label ID="lbValidation" runat="server" Text="" ForeColor="Red" Visible="false"></asp:Label>
        </div>
        <asp:Button ID="btnEnviarCode" runat="server" Text="Enviar Codigo" CssClass="btn btn-primary" OnClick="btnEnviarCode_Click" />
        <asp:Label ID="lbEstado" runat="server" ForeColor="Green" Visible="true"></asp:Label>
        <br /><br /><br /><br /><br /><br /><br /><br />
    </form>
    
</asp:Content>

