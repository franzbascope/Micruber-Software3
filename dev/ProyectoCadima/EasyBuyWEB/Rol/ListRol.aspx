<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="ListRol.aspx.cs" Inherits="Productos_ListProductos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>Lista de Roles</h2>
    <asp:HyperLink ID="agregar" runat="server" NavigateUrl="~/Rol/RegistroRol.aspx">
                AÑADIR NUEVO ROL +
    </asp:HyperLink>

    <asp:GridView ID="GridRol" runat="server"
        OnRowCommand="GridRol_RowCommand"
        AutoGenerateColumns="false"
        CssClass="table"
        GridLines="None">
        <Columns>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />

            <asp:TemplateField HeaderText="Editar">
                <ItemTemplate>
                    <asp:LinkButton ID="EditButton" runat="server"
                        CommandName="Editar"
                        CommandArgument='<%# Eval("RolId") %>'>
                                <i class="glyphicon glyphicon-pencil"></i>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Eliminar">
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteButton" runat="server"
                        CommandName="Eliminar"
                        OnClientClick="return confirm('Esta seguro que desea eliminar el Rol?')"
                        CommandArgument='<%# Eval("RolId") %>'>
                                <i class="glyphicon glyphicon-trash"></i>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

