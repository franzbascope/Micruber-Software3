<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage2.master" AutoEventWireup="true" CodeFile="ErrorPage.aspx.cs" Inherits="Error_ErrorPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <h1>
                    <asp:Literal ID="MsgLiteral" runat="server"
                        Text="Base de Datos no Versionada">
                    </asp:Literal>
                </h1>
                
            </div>
        </div>
    </div>

</asp:Content>

