<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetalleVehiculo.aspx.cs" Inherits="Ruta_DetalleVehiculo" MasterPageFile="~/MasterPages/MasterPage.master"  %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    
    <asp:GridView runat="server" ID="AsignarLineaGridView" CssClass="table table-striped" GridLines="None" AutoGenerateColumns="false"
                 >
                <Columns>
                    <asp:TemplateField HeaderText="Asignar">
                        
                        <ItemTemplate>
                            <asp:CheckBox  runat="server" ID="chkRow"  Checked='<%# Eval("perteneceLinea") %>' />
                       
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="LineaId"  DataField="lineaId" />
                    <asp:BoundField HeaderText="NumeroLinea" DataField="numeroLinea" />
                </Columns>
            </asp:GridView>
    
        <div class="form-group">
                        <asp:LinkButton ID="SaveButton" runat="server" OnClick="SaveButton_Click"
                            CssClass="btn btn-primary"
                            ValidationGroup="Usuario">
                    Guardar
                        </asp:LinkButton>
                        <asp:HyperLink runat="server" NavigateUrl="~/Ruta/ListaVehiculos.aspx" CssClass="btn">
                    Cancelar
                        </asp:HyperLink>
        </div>
         <asp:HiddenField ID="RoleIdHiddenField" runat="server" Value="0" />

    </asp:Content>