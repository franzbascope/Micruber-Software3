<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListaVehiculos.aspx.cs" Inherits="Ruta_ListaVehiculos" MasterPageFile="~/MasterPages/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="card">
        <div class="card-header">
            <h4 class="card-title">Lista de Vehiculos</h4>
            <asp:HyperLink runat="server" NavigateUrl="~/Ruta/CrearVehiculo.aspx" CssClass="btn btn-primary">
                Crear un vehiculo
            </asp:HyperLink>
        </div>
        <div class="row">
            <div class="col-12">
                <asp:GridView runat="server" ID="VehiculoGridView" CssClass="table table-striped" GridLines="None" AutoGenerateColumns="false"
                    OnRowCommand="VehiculoGridView_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Asignar">
                            <ItemTemplate>
                                <asp:LinkButton ID="Asignar" runat="server" CommandName="Asignar"
                                    CommandArgument='<%# Eval("vehiculoId") %>'>
                                <i class="fa fa-list-alt"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Editar">
                            <ItemTemplate>
                                <asp:LinkButton ID="EditBtn" runat="server" CommandName="Editar"
                                    CommandArgument='<%# Eval("vehiculoId") %>'>
                                <i class="fas fa-edit"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Eliminar">
                            <ItemTemplate>
                                <asp:LinkButton ID="DeleteBtn" runat="server" CommandName="Eliminar"
                                    OnClientClick="return confirm('¿Esta seguro que desea eliminar este vehiculo?')"
                                    CommandArgument='<%# Eval("vehiculoId") %>'>
                                <i class="fas fa-trash-alt text-danger"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Placa" DataField="placa" />
                        <asp:BoundField HeaderText="Capacidad" DataField="capacidad" />

                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </div>
</asp:Content>

