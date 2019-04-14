<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="ImpReportPedido.aspx.cs" Inherits="Pedido_ImpReportPedido" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="formRegist" class="col-md-10 col-md-offset-1" runat="server" >
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="650px" Width="900px">
            <localreport reportpath="Reportes\ReportPedido.rdlc">                
                
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="DetalleDS" Name="DetallePedidoDS" />
                    <rsweb:ReportDataSource DataSourceId="PedidosODS" Name="PedidosDS" />
                </DataSources>
                
            </localreport>
        </rsweb:ReportViewer>                              
                        
        
        <asp:ObjectDataSource ID="PedidosODS" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetPedidoById" TypeName="Data.Seguridad.PedidoDSTableAdapters.PedidosAdapter">
            <InsertParameters>
                <asp:Parameter Name="clienteId" Type="Int32" />
                <asp:Parameter Name="empresaId" Type="Int32" />
                <asp:Parameter Name="usuarioId" Type="Int32" />
                <asp:Parameter Name="fecha" Type="DateTime" />
                <asp:Parameter Name="Atendido" Type="Boolean" />
                <asp:Parameter Name="latitud" Type="String" />
                <asp:Parameter Name="longitud" Type="String" />
                <asp:Parameter Name="isMovil" Type="Boolean" />
                <asp:Parameter Direction="InputOutput" Name="intPedidoId" Type="Object" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter DefaultValue="" ControlID="PedidoIdHiddenField" Name="pedidoId" Type="Int32" PropertyName="Value" />
                <%--<asp:Parameter DefaultValue="" Name="pedidoId" Type="Int32" />--%>
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="DetalleDS" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDetalle" TypeName="Data.Seguridad.DetallePedidoDSTableAdapters.DetallePedidoAdapter">
            <InsertParameters>
                <asp:Parameter Name="PedidoId" Type="Int32" />
                <asp:Parameter Name="ProductoId" Type="Int32" />
                <asp:Parameter Name="Precio" Type="Decimal" />
                <asp:Parameter Name="Cantidad" Type="Decimal" />
                <asp:Parameter Name="SubTotal" Type="Decimal" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter DefaultValue="" ControlID="PedidoIdHiddenField" Name="pedidoId" Type="Int32" PropertyName="Value" />
               <%-- <asp:Parameter DefaultValue="" Name="PedidoId" Type="Int32" />--%>
            </SelectParameters>
        </asp:ObjectDataSource>
                        
        <asp:HiddenField ID="PedidoIdHiddenField" runat="server" Value="0" />
    </div>
</asp:Content>

