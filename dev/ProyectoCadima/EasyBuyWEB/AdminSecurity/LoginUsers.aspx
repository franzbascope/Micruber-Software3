<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage2.master" AutoEventWireup="true" CodeFile="LoginUsers.aspx.cs" Inherits="AdminSecurity_LoginUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <form class="col-md-4  col-md-offset-4" runat="server">
        <h2>Iniciar Sesión</h2>
        <br />
        <div class="form-group">
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email">
            </asp:TextBox>
        </div>

        <div class="form-group">
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password">
            </asp:TextBox>
        </div>

        <asp:HyperLink runat="server" NavigateUrl="~/AdminSecurity/RecoveryPassword.aspx">
                Olvidó su Contraseña?
        </asp:HyperLink>
        <br /><br />
        <asp:Button ID="btnInitSesion" runat="server" Text="Ingresar" OnClick="btnInitSesion_Click" CssClass="btn btn-primary" />
        <asp:Label ID="lbValidator" ForeColor="Red" runat="server" Text="" Visible ="false"></asp:Label>
        <!--<button class="btn btn-primary">Enviar</button>-->
        <br />
        <br />        
        <br />
        <br />
        <br />
        <br />
        <br />
    </form>

</asp:Content>

