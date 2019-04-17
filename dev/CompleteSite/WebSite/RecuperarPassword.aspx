<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="RecuperarPassword.aspx.cs" Inherits="RecuperarPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
     <link rel="stylesheet" type="text/css" href="Assets/css/B.style.css"/>
    <title>Inicia Sesion</title>
    <link rel="icon" href="/Assets/Imagenes/favicon.png" type="image/png">
     <style>
        body {
            background: url(/Assets/Imagenes/fondo.png)
        }
    </style>
</head>
<body class="signin text-center">
    <form id="form1" runat="server" class="form-signin">
        <img style="margin-bottom:30px;width:80%;" src="Assets/Imagenes/mic.png" alt="NUR" >
                                                    
        <label for="inputEmail" class="sr-only">Nombre de Usuario</label>
        <asp:TextBox ID="UsernameTextBox" style="border-radius:5px !important;background-color:white" runat="server" class="form-control" required="required" type="email"
            placeholder="Ingrese su correo"/>
         <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" style="color:white"
                                ValidationExpression="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"
                                ControlToValidate="UsernameTextBox" ValidationGroup="RecoverPassword" ErrorMessage="Ingrese un correo correcto">
                            </asp:RegularExpressionValidator>
        
          <div class="text-danger">
            <asp:Label ID="MsgError" runat="server"></asp:Label>
        </div>
        <asp:Panel ID="panelEmailSend" CssClass="alert alert-info"  Visible="false" runat="server">
            Te enviamos un correo, haz click en el enlace para recuperar tu contraseña
        </asp:Panel>
        <asp:Button type="submit"   ValidationGroup="RecoverPassword"  runat="server" style="background-color:#8AC53F"  CssClass="btn btn-lg  btn-success btn-block" Text="Recuperar"
            ID="BtnIngresar" OnClick="BtnIngresar_Click"/>

    </form>
</body>
</html>