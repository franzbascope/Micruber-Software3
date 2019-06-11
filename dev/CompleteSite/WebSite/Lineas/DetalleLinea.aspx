<%@ Page Title="Usuarios" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="DetalleLinea.aspx.cs" Inherits="Lineas_DetalleLineas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5>
                <asp:Literal runat="server" ID="LabelTitle"></asp:Literal>
                Linea
            </h5>            
            <asp:HyperLink runat="server" NavigateUrl="~/Lineas/ListaLineas.aspx">
                Volver a la Lista de Líneas
            </asp:HyperLink>
                    <asp:Panel ID="PanelError" runat="server" Visible="false" CssClass="alert alert-danger" role="alert">
                <asp:Literal ID="MsgLiteral" runat="server"></asp:Literal>
            </asp:Panel>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="NumeroLineaTextBox">Número de Línea</asp:Label>
                        <asp:TextBox ID="NumeroLineaTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                        <div class="text-danger">
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic"
                                ErrorMessage="Debe ingresar el número de línea"
                                ValidationGroup="Linea"
                                ControlToValidate="NumeroLineaTextBox">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:LinkButton ID="SaveButton" runat="server" OnClick="SaveButton_Click"
                            CssClass="btn btn-primary"
                            ValidationGroup="Usuario">
                    Guardar
                        </asp:LinkButton>
                        <asp:HyperLink runat="server" NavigateUrl="~/Lineas/ListaLineas.aspx" CssClass="btn">
                    Cancelar
                        </asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <asp:HiddenField ID="LineaIdHiddenField" runat="server" Value="0" />
</asp:Content>
