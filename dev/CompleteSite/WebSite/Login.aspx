<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

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
        
        <label for="inputPassword" class="sr-only">Contraseña</label>
        <asp:TextBox ID="PasswordTextBox" style="border-radius:5px !important;background-color:white;margin-top:10px;" runat="server" class="form-control" required="required" TextMode="Password"
            placeholder="Ingrese su contraseña"/>

          <div class="text-danger">
            <asp:Label ID="MsgError" runat="server"></asp:Label>
        </div>

        <asp:Button type="submit" runat="server" style="background-color:#8AC53F"  CssClass="btn btn-lg  btn-success btn-block" Text="Entrar"
            ID="BtnIngresar" OnClick="BtnIngresar_Click"/>
           <asp:HyperLink runat="server" NavigateUrl="~/RecuperarPassword.aspx" class="btn btn-link text-light">
                Olvidaste tu contraseña?
            </asp:HyperLink>
    </form>
</body>
</html>