<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="ListProductos.aspx.cs" Inherits="Productos_ListProductos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>Lista de Productos</h2>
    <asp:HyperLink runat="server" id="agregar" NavigateUrl="~/Productos/FormProducto.aspx">
                AÑADIR NUEVO PRODUCTO +
    </asp:HyperLink>

    <asp:GridView ID="GridProductos" runat="server"
        OnRowCommand="GridProductos_RowCommand"
        AutoGenerateColumns="false"
        CssClass="table"
        GridLines="None">
        <Columns>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="Precio" HeaderText="Precio" />
            <asp:BoundField DataField="NombreEmp" HeaderText="Empresa" />
            <asp:TemplateField HeaderText="Editar">
                <ItemTemplate>
                    <asp:LinkButton ID="EditButton" runat="server"
                        CommandName="Editar"
                        CommandArgument='<%# Eval("ProductoId") %>'>
                                <i class="glyphicon glyphicon-pencil"></i>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Eliminar">
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteButton" runat="server"
                        CommandName="Eliminar"
                        OnClientClick="return confirm('Esta seguro que desea eliminar el Producto?')"
                        CommandArgument='<%# Eval("ProductoId") %>'>
                                <i class="glyphicon glyphicon-trash"></i>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>
</asp:Content>

