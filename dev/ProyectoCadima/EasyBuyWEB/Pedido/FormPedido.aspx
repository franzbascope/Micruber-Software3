<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="FormPedido.aspx.cs" Inherits="Pedido_FormPedido" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title></title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/webcomponentsjs/1.0.17/webcomponents-lite.js"></script>
    <link rel="import" href="https://raw-dot-custom-elements.appspot.com/GoogleWebComponents/google-map/v2.0.2/google-map/google-map.html">



    <style>
        google-map {
            height: 380px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2 class="text-center" runat="server" id="lbPed">Pedido pendiente por Atender</h2>
    <br />
    <div class="row">
        <div class="col-md-4">
            <div class="form-group">
                <label>CLIENTE:</label>
                <asp:TextBox ID="txtCliente" runat="server"
                    CssClass="form-control" Enabled="false">
                </asp:TextBox>
            </div>

            <div class="form-group">
                <label>CORREO:</label>
                <asp:TextBox ID="txtCorreo" runat="server"
                    CssClass="form-control" Enabled="false">
                </asp:TextBox>
            </div>

            <div class="form-group">
                <label>EMPRESA:</label>
                <asp:TextBox ID="txtNombreEmp" runat="server"
                    CssClass="form-control" Enabled="false">
                </asp:TextBox>
            </div>

            <div class="form-group">
                <label>FECHA:</label>
                <asp:TextBox ID="txtFecha" runat="server"
                    CssClass="form-control" Enabled="false">
                </asp:TextBox>
            </div>

            <div class="form-group">
                <label>DISPOSITIVO:</label>
                <asp:TextBox ID="txtDispositivo" runat="server"
                    CssClass="form-control" Enabled="false">
                </asp:TextBox>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:Button ID="btnAtender" runat="server" Text="Atender" CssClass="btn btn-primary btn-block" OnClick="btnAtender_Click" />
                </div>
                <div class="col-md-4">
                    <asp:Button class="btn btn-primary btn-block" data-target="#detalleModal" data-toggle="modal">Ver Detalle</asp:Button>
                </div>

                <div class="col-md-4">
                    <asp:Button ID="Imprimir" runat="server" Text="Imprimir" CssClass="btn btn-primary btn-block" OnClick="Imprimir_Click" />
                </div>
            </div>

        </div>

        <div class="col-md-8">
            <div>
                <asp:Literal ID="GMap" runat="server"></asp:Literal>
            </div>
        </div>
    </div>

    <div class="container" runat="server">
        <div class="row">
            <div class="col-md-8">
                <div class="modal" id="detalleModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button class="close" data-dismiss="modal">&times;</button>
                                <h4>Detalle de Pedido</h4>
                            </div>
                            <div class="modal-body">
                                <asp:GridView ID="GridPedido" runat="server"
                                    OnRowCommand="GridPedido_RowCommand"
                                    AutoGenerateColumns="false"
                                    CssClass="table"
                                    GridLines="None">
                                    <Columns>
                                        <asp:BoundField DataField="NombreProducto" HeaderText="Nombre de Producto" />
                                        <asp:BoundField DataField="Precio" HeaderText="Precio de Producto" />
                                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />                                        
                                        <asp:BoundField DataField="SubTotal" HeaderText="Subtotal" />                                        
                                    </Columns>
                                </asp:GridView>
                                <asp:Label ID="Label1" runat="server" Text="Total a Pagar:" Font-Bold="true"></asp:Label>
                                <asp:Label ID="txtPagoFinal" runat="server" Enabled="false" Font-Bold="true"/>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.js" s></script>
</asp:Content>

