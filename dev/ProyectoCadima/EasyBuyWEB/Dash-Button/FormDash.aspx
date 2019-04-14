<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="FormDash.aspx.cs" Inherits="Dash_Dash" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <div class="col-md-4  col-md-offset-4" runat="server">
        <h2>Registrar Dash</h2>
        <br />        

        <div class="form-group">            
            <h4>Ingrese el Código del Dash</h4>
            <asp:TextBox ID="txtCodeDash" runat="server" CssClass="form-control" placeholder="Codigo de Dash">
            </asp:TextBox>
        </div>
        <asp:Button ID="btnRegistrarDash" runat="server" Text="Registrar Dash" OnClick="btnRegistrarDash_Click" CssClass="btn btn-primary btn-block" />
        <asp:Label ID="lbValidator" ForeColor="Red" runat="server" Text="" Visible="false"></asp:Label>
        <!--<button class="btn btn-primary">Enviar</button>-->
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    </div>
</asp:Content>

