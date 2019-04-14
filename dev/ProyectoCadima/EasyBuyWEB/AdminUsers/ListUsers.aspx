<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="ListUsers.aspx.cs" Inherits="AdminUsers_ListUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <h1>Lista de Colaboradores</h1>
            <asp:HyperLink runat="server" id="agregar" NavigateUrl="~/AdminUsers/RegistUsers.aspx">
                AÑADIR NUEVO COLABORADOR +
            </asp:HyperLink>

            <asp:GridView ID="GridUsers" runat="server"
                OnRowCommand="GridUser_RowCommand"
                AutoGenerateColumns="false"
                CssClass="table"
                GridLines="None">

                <Columns>
                    <asp:BoundField DataField="usuarioId" HeaderText="Codigo" />
                    <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="apellido" HeaderText="Apellido" />
                    <asp:BoundField DataField="email" HeaderText="Correo" />

                    <asp:TemplateField  HeaderText="Editar">
                        <ItemTemplate>
                            <asp:LinkButton ID="EditButton" runat="server"
                                CommandName="Editar"
                                CommandArgument='<%# Eval("usuarioId") %>'>
                                        <i class="glyphicon glyphicon-pencil"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:TemplateField HeaderText="Eliminar">
                        <ItemTemplate>
                            <asp:LinkButton ID="DeleteButton" runat="server"
                                CommandName="Eliminar"
                                OnClientClick="return confirm('Esta seguro que desea eliminar el Rol?')"
                                CommandArgument='<%# Eval("usuarioId") %>'>
                                        <i class="glyphicon glyphicon-trash"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                </Columns>
            </asp:GridView>
        </div>
    </div>

</asp:Content>

