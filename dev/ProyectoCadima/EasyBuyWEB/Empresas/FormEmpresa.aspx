<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="FormEmpresa.aspx.cs" Inherits="Empresas_RegistEmpresa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="formRegist" class="col-md-6  col-md-offset-3" runat="server">
        <h2 runat="server" id="lbRist">Registrar Empresas</h2>
        <br />
        <div class="form-group">
            <label>NIT:</label>
            <asp:TextBox ID="txtNit" runat="server"
                CssClass="form-control"
                placeholder="Ingrese NIT de Empresa">
            </asp:TextBox>
        </div>

        <div class="form-group">
            <label>Nombre:</label>
            <asp:TextBox ID="txtNombreEmp" runat="server"
                CssClass="form-control"
                placeholder="Ingrese Nombre de Empresa">
            </asp:TextBox>
        </div>

        <div class="form-group">
            <label>Gerente:</label>
            <asp:TextBox ID="txtGerente" runat="server"
                CssClass="form-control"
                placeholder="Ingrese Nombre de Gerente de Empresa">
            </asp:TextBox>
        </div>

        <div class="form-group">
            <label>Telefono:</label>
            <asp:TextBox ID="txtTelefono" runat="server"
                CssClass="form-control"
                placeholder="Ingrese el Telefono de Empresa">
            </asp:TextBox>
        </div>

        <h4>Tipo de Empresa</h4>
        <asp:DropDownList ID="EmpresaComboBox" runat="server" CssClass="form-control"
            OnDataBound="EmpresaComboBox_DataBound"
            DataValueField="TipoHijosId"
            DataTextField="Nombre">
        </asp:DropDownList>        

        <asp:Label ID="lbVal" runat="server" Text="" ForeColor="Red"></asp:Label>
        <br />
        <asp:Button ID="btnRegistrar" runat="server"
            Text="Registrar Empresa"
            CssClass="btn btn-primary"
            OnClick="btnRegistrar_Click" />

    </div>
</asp:Content>

