<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="ListPedidos.aspx.cs" Inherits="Pedido_ListPedidos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>List Pedidos</h2>
    <asp:GridView ID="GridPedidos" runat="server"
        OnRowCommand="GridPedidos_RowCommand"
        AutoGenerateColumns="false"
        CssClass="table"
        GridLines="None">
        <Columns>
            <asp:BoundField DataField="T_ClienteName" HeaderText="Cliente" />
            <asp:BoundField DataField="T_EmpresaName" HeaderText="Empresa" />
            <asp:BoundField DataField="T_Dispositivo" HeaderText="Dispositivo" />
            <asp:BoundField DataField="T_EstadoAtencion" HeaderText="Estado" />
            <asp:TemplateField HeaderText="Ver Pedido">
                <ItemTemplate>
                    <asp:LinkButton ID="EditButton" runat="server"
                        CommandName="Ver"
                        CommandArgument='<%# Eval("PedidoId") %>'>
                                <i class="glyphicon glyphicon-eye-open"></i>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>            

        </Columns>
    </asp:GridView>
</asp:Content>

