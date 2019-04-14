<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage2.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="AdminSecurity_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form id="formRegist" class="col-md-6  col-md-offset-3" runat="server">
        <br /><br /><br /><br /><br /><br /><br />
        <h1>Recuperar Contraseña</h1>        
        <br />
        <h4 runat="server" id ="txtEmail" visible="true"></h4>
        <div class="form-group">
            <asp:textbox id="txtPassword" runat="server" cssclass="form-control" placeholder="Contraseña" TextMode="Password">
            </asp:textbox>            
        </div>
        <div class="form-group">
            <asp:textbox id="txtRePassword" runat="server" cssclass="form-control" placeholder="Repita su Contraseña" TextMode ="Password">
            </asp:textbox>            
        </div>
        <asp:Button ID="btnChangePassword" runat="server" Text="Cambiar Contraseña" CssClass="btn btn-primary" OnClick="btnChangePassword_Click"/>
        <asp:Label ID="lbEstado" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        <br /><br /><br /><br /><br /><br /><br />
    </form>
</asp:Content>

