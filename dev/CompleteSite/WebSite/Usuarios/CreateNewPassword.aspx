<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="CreateNewPassword.aspx.cs" Inherits="Usuarios_CreateNewPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     <link rel="stylesheet" type="text/css" href="../Assets/css/B.style.css"/>
    <title>Inicia Sesion</title>
    <link rel="icon" href="../Assets/Imagenes/favicon.png" type="image/png">
     <style>
        body {
            background: url(../Assets/Imagenes/fondo.png)
        }
    </style>
</head>
<body class="signin text-center">
    <form id="form1" runat="server" class="form-signin">
        <img style="margin-bottom:30px;width:80%;" src="../Assets/Imagenes/mic.png" alt="NUR" >
        <asp:Panel ID="panelCodigoCorrecto" runat="server" Visible="false">
                        <asp:TextBox ID="PasswordTextBox" required="required" placeHolder="Nueva Contraseña"  style="border-radius:5px !important;background-color:white" type="password" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:TextBox ID="ConfirmPasswordTextBox" required="required" placeHolder="Repita su contraseña" style="border-radius:5px !important;background-color:white"  type="password" runat="server" CssClass="form-control"></asp:TextBox>
                        <div class="text-danger">
                             <asp:Label ID="MsgError" runat="server"></asp:Label>
                        </div>
                        <div class="text-danger">
                            <asp:RegularExpressionValidator ID="PasswordValidor" ValidationGroup="Usuario" runat="server" ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,15}$"  ControlToValidate="PasswordTextBox" ErrorMessage="La contraseña debe tener al menos una letra mayuscula, un numero
                                y tener mas de 6 caracteres y un maximo de 15 caracteres">
                            </asp:RegularExpressionValidator>	
                        </div>
        <asp:Button type="submit" runat="server" style="background-color:#8AC53F"  CssClass="btn btn-lg  btn-success btn-block" Text="Cambiar Contraseña"
            ID="BtnIngresar"   ValidationGroup="Usuario" OnClick="BtnIngresar_Click"/>
        </asp:Panel>
        <asp:Panel ID="PanelCodigoIncorrecto" runat="server" Visible="false"> 
            <h3 style="color:white"> <asp:Label ID="ConfirmacionLabel" Text="Codigo Incorrecto o Expirado, vuelve a recuperar tu contraseña" runat="server" /></h3>
        </asp:Panel>
        <asp:Panel ID="panelSuccess" runat="server" Visible="false">
            <div class="alert alert-info" role="alert">
              Felicidades, cambiaste tu contraseña
            </div>
               <asp:HyperLink runat="server" style="background-color:#8AC53F"  CssClass="btn btn-lg  btn-success btn-block" NavigateUrl="~/Login.aspx" >
                Inicia Sesion
            </asp:HyperLink>
        </asp:Panel>
        <asp:HiddenField ID="CodigoRecuperaciondHiddenField" runat="server" Value="" />   
    </form>
       
</body>
</html>