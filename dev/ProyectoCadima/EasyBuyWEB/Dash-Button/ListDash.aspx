<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="ListDash.aspx.cs" Inherits="Dash_ListDash" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="col-md-6 col-md-offset-3">
        <h2 class="text-center">Lista de Dash</h2>
        <asp:HyperLink runat="server" NavigateUrl="~/Dash-Button/FormDash.aspx">
                AÑADIR NUEVO DASH BUTTON +
        </asp:HyperLink>


        <asp:GridView ID="GridDash" runat="server"
            OnRowCommand="GridDash_RowCommand"
            AutoGenerateColumns="false"
            CssClass="table"
            GridLines="None">
            <Columns>
                <asp:BoundField DataField="DashId" HeaderText="ID" />
                <asp:BoundField DataField="Codigo" HeaderText="Code" />
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>

