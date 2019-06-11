<%@ Page Title="Lineas" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="ListaLineas.aspx.cs"  Inherits="Lineas_ListaLineas" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <div class="row">
        <div class="col-md-12">
        <div class="card">
            <div class="card-header">
            <h4 class="card-title">Lineas</h4>
                <asp:HyperLink runat="server" NavigateUrl="~/Lineas/DetalleLinea.aspx" CssClass="btn btn-primary">
                Nueva Linea
            </asp:HyperLink>
            </div>
            <div class="card-body">
            <div class="table-responsive">
                 <asp:GridView ID="LineaGridView" runat="server" CssClass="table" 
                GridLines="None" AutoGenerateColumns="false"
                OnRowCommand="LineaGridView_RowCommand"> 
                <Columns>
                    <asp:TemplateField HeaderText="Editar">
                        <ItemTemplate>
                            <asp:LinkButton ID="EditBtn" runat="server" CommandName="Editar"
                                CommandArgument='<%# Eval("lineaId") %>'>
                                <i class="fas fa-edit"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Eliminar">
                        <ItemTemplate>
                            <asp:LinkButton ID="DeleteBtn" runat="server" CommandName="Eliminar"
                                OnClientClick="return confirm('¿Esta seguro que desea eliminar este usuario?')"
                                CommandArgument='<%# Eval("lineaId") %>'>
                                <i class="fas fa-trash-alt text-danger"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Numero de Linea" DataField="numeroLinea" />

                    <asp:TemplateField HeaderText="Agregar/Editar Ruta">
                        <ItemTemplate>
                            <asp:LinkButton ID="rutaBtn" runat="server" CommandName="Ruta"
                                CommandArgument='<%# Eval("lineaId") %>'>
                                <i class="fas fa-map-marker-alt"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
            </div>
        </div>
        </div>
    </div>
</asp:Content>
