<%@ Page Title="ListaRoles" Language="C#" AutoEventWireup="true" CodeFile="ListaRoles.aspx.cs" Inherits="Usuarios_ListaRoles" MasterPageFile="~/MasterPages/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">

    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Lista de roles</h4>
                    <asp:HyperLink runat="server" NavigateUrl="~/Usuarios/CrearRol.aspx" CssClass="btn btn-primary">
                            Nuevo Rol
                    </asp:HyperLink>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView runat="server" ID="RolGridView" CssClass="table table-striped" GridLines="None" AutoGenerateColumns="false"
                            OnRowCommand="RolGridView_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="Asignar">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="Asignar" runat="server" CommandName="Asignar"
                                            CommandArgument='<%# Eval("roleId") %>'>
                                <i class="fa fa-list-alt"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Editar">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="EditBtn" runat="server" CommandName="Editar"
                                            CommandArgument='<%# Eval("roleId") %>'>
                                <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Eliminar">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteBtn" runat="server" CommandName="Eliminar"
                                            OnClientClick="return confirm('¿Esta seguro que desea eliminar este usuario?')"
                                            CommandArgument='<%# Eval("roleId") %>'>
                                <i class="fas fa-trash-alt text-danger"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Descripcion Rol" DataField="descripcion" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

