<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetalleRol.aspx.cs" Inherits="Usuarios_DetalleRol" MasterPageFile="~/MasterPages/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    
    <asp:GridView runat="server" ID="AsignarPermisosGridView" CssClass="table table-striped" GridLines="None" AutoGenerateColumns="false"
                OnRowCommand="AsignarPermisosGridView_RowCommand" >
                <Columns>
                    <asp:TemplateField HeaderText="Asignar">
                        
                        <ItemTemplate>
                            <asp:CheckBox  runat="server" ID="chkRow"  Checked='<%# Eval("perteneceRol") %>' />
                       
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Id"  DataField="permisoId" />
                     <asp:BoundField HeaderText="Descripcion Rol" DataField="descripcion" />
                </Columns>
            </asp:GridView>
    
        <div class="form-group">
                        <asp:LinkButton ID="SaveButton" runat="server" OnClick="SaveButton_Click"
                            CssClass="btn btn-primary"
                            ValidationGroup="Usuario">
                    Guardar
                        </asp:LinkButton>
                        <asp:HyperLink runat="server" NavigateUrl="~/Usuarios/ListaRoles.aspx" CssClass="btn">
                    Cancelar
                        </asp:HyperLink>
        </div>
         <asp:HiddenField ID="RoleIdHiddenField" runat="server" Value="0" />

    </asp:Content>
