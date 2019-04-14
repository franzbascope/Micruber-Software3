<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="FormProducto.aspx.cs" Inherits="Productos_FormProducto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="formRegist" class="col-md-6  col-md-offset-3" runat="server">
        <h2 runat="server" id="lbRist">Registrar Productos</h2>
        <br />

        <div class="row">
            <div class="col-md-6">
                <label>Nombre:</label>
                <asp:TextBox ID="txtNombreProd" runat="server"
                    CssClass="form-control"
                    placeholder="Ingrese el Nombre del Producto">
                </asp:TextBox>
            </div>
            <div class="col-md-6">
                <label>Precio:</label>
                <asp:TextBox ID="txtPrecio" runat="server"
                    TextMode="Number"
                    
                    CssClass="form-control"
                    placeholder="Ingrese el Precio del Producto">
                </asp:TextBox>
                <asp:CompareValidator runat="server"
                    ControlToValidate="txtPrecio"
                    Display="Dynamic"
                    ForeColor="Red"
                    ValueToCompare="0"
                    Operator="GreaterThanEqual"
                    ErrorMessage="El precio debe ser Positivo">
                </asp:CompareValidator>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-6">
                <label>Tipo de Producto:</label>
                <asp:DropDownList ID="TipoProdComboBox" runat="server" CssClass="form-control"
                    OnDataBound="TipoProdComboBox_DataBound"
                    DataValueField="TipoHijosId"
                    DataTextField="Nombre">
                </asp:DropDownList>
            </div>
            <div class="col-md-6">
                <label>Empresa Proveedora:</label>
                <asp:DropDownList ID="EmpresaComboBox" runat="server" CssClass="form-control"
                    OnDataBound="EmpresaComboBox_DataBound"
                    DataValueField="EmpresaId"
                    DataTextField="Nombre">
                </asp:DropDownList>
            </div>
        </div>

        <%-- <h4>Tipo de Producto</h4>
        --%>

        <asp:Label ID="lbVal" runat="server" Text="" ForeColor="Red"></asp:Label>
        <br />
        <asp:Button ID="btnRegistrar" runat="server"
            Text="Registrar Producto"
            CssClass="btn btn-primary" OnClick="btnRegistrar_Click" />

    </div>
</asp:Content>

