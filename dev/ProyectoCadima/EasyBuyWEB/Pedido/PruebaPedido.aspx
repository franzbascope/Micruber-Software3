<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage2.master" AutoEventWireup="true" CodeFile="PruebaPedido.aspx.cs" Inherits="Pedido_PruebaPedido" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form id="form1" runat="server">
        <asp:Label ID="lbRes" runat="server" Text=""></asp:Label>
        <asp:Button ID="btnSendPedido" runat="server" Text="Enviar Pedido" CssClass="btn btn-primary" OnClick="btnSendPedido_Click"/>
    </form>
    
</asp:Content>

