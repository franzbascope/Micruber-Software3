<%@ Page Title="Usuarios" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="ListaUsuarios.aspx.cs"  Inherits="Usuarios_ListaUsuarios" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <div class="row">
        <div class="col-md-12">
        <div class="card">
            <div class="card-header">
            <h4 class="card-title">Usuarios</h4>
                <asp:HyperLink runat="server" NavigateUrl="~/Usuarios/DetalleUsuario.aspx" CssClass="btn btn-primary">
                Nuevo Usuario
            </asp:HyperLink>
            </div>
            <div class="card-body">
            <div class="table-responsive">
                 <asp:GridView ID="UsuarioGridView" runat="server" CssClass="table" 
                GridLines="None" AutoGenerateColumns="false"
                OnRowCommand="UsuarioGridView_RowCommand"> 
                <Columns>
                    <asp:TemplateField HeaderText="Editar">
                        <ItemTemplate>
                            <asp:LinkButton ID="EditBtn" runat="server" CommandName="Editar"
                                CommandArgument='<%# Eval("usuarioId") %>'>
                                <i class="fas fa-edit"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Eliminar">
                        <ItemTemplate>
                            <asp:LinkButton ID="DeleteBtn" runat="server" CommandName="Eliminar"
                                OnClientClick="return confirm('¿Esta seguro que desea eliminar este usuario?')"
                                CommandArgument='<%# Eval("usuarioId") %>'>
                                <i class="fas fa-trash-alt text-danger"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Nombre Completo" DataField="nombreCompleto" />
                    <asp:BoundField HeaderText="Correo" DataField="correo" />
                    <asp:BoundField HeaderText="Rol" DataField="rolDescripcion" />
                </Columns>
            </asp:GridView>
            </div>
            </div>
        </div>
        </div>
    </div>
</asp:Content>
