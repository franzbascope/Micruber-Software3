using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VentasNur.Model;
using DAL.Seguridad;
using DAL.Seguridad.UsuarioDSTableAdapters;
using System.Net.Mail;
using System.Net;
using CapaAcceso.App_Code.BLL.Seguridad;

/// <summary>
/// Descripción breve de UsuarioBLL
/// </summary>
public class UsuarioBLL
{
    public UsuarioBLL()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }
    private static Usuario GetUsuarioFromRow(UsuarioDS.UsuarioRow row)
    {
        return new Usuario()
        {
            correo = row.correo,
            usuarioId = row.usuarioId,
            nombreCompleto = row.nombre,
            codigoActivacion = row.IscodigoActivacionNull() ? "" : row.codigoActivacion,
            codigoRecuperacion = row.IscodigoRecuperacionNull() ? "" : row.codigoRecuperacion,
            rolId = row.IsrolIdNull() ? 0 : row.rolId,
            rolDescripcion = row.IsrolNull() ? "" : row.rol,
            tempPassword = row.IstempPasswordNull()? "" : row.tempPassword,
            esEstudiante = row.IsesEstudianteNull() ? false : row.esEstudiante,
            saldoActual = row.IssaldoActualNull() ? 0 : row.saldoActual,
            
        };
    }

    public static List<Usuario> getAllUsuarios()
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        UsuarioDS.UsuarioDataTable table = adapter.getAllUsuarios();

        List<Usuario> list = new List<Usuario>();
        foreach (var row in table)
        {
            Usuario obj = GetUsuarioFromRow(row);
            list.Add(obj);
        }
        return list;
    }




    public static Usuario getUsuarioById(int usuarioId)
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        UsuarioDS.UsuarioDataTable table = adapter.getUsuarioById(usuarioId);

        List<Usuario> list = new List<Usuario>();
        foreach (var row in table)
        {
            Usuario obj = GetUsuarioFromRow(row);
            list.Add(obj);
        }
        return list[0];
    }

    public static Usuario getUsuarioByCodigoNFC(string codigoNFC)
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        UsuarioDS.UsuarioDataTable table = adapter.getUsuarioByCodigoNFC(codigoNFC);

        List<Usuario> list = new List<Usuario>();
        foreach (var row in table)
        {
            Usuario obj = GetUsuarioFromRow(row);
            list.Add(obj);
        }
        return list[0];
    }


    public static Usuario autenticarUsuario(string username, string password)
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        UsuarioDS.UsuarioDataTable table = adapter.autenticarUsuario(username, password);

        if (table == null || table.Rows.Count > 1)
        {
            throw new Exception("La consulta retornó un numero incorrecto de filas");
        }
        UsuarioDS.UsuarioRow row = table[0];
        return new Usuario()
        {
            correo = row.correo,
            usuarioId = row.usuarioId,
            nombreCompleto = row.nombre,
            saldoActual = row.saldoActual,
            tipoUsuario = row.tipoUsuario
        };
  
    }

    public static void deleteUsuario(int usuarioId)
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        adapter.deleteUsuario(usuarioId);
    }


    public static string  changePassword(int usuarioId,string oldPassword,string newPassword)
    {
        string error = "";
        try
        {
            UsuarioTableAdapter adapter = new UsuarioTableAdapter();
            adapter.changePassword(usuarioId, oldPassword, newPassword);
        }
        catch (Exception ex)
        {
            error = ex.Message;
        }
        return error;
    }
    public static int insertUsuario(Usuario obj)
    {
        if (string.IsNullOrEmpty(obj.nombreCompleto))
            throw new ArgumentException("El nombre no puede ser nulo o vacio");

        if (string.IsNullOrEmpty(obj.correo))
            throw new ArgumentException("El correo no puede ser nulo o vacio");


        int? id = null;
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        adapter.insertUsuario(obj.correo, obj.nombreCompleto, ref id);

        if (id == null || id.Value <= 0)
            throw new Exception("La llave primaria no se generó correctamente");
        else
            enviarEmail(id.Value);
        return id.Value;
    }
    public static int insertUsuarioAdministracion(Usuario obj)
    {
        if (string.IsNullOrEmpty(obj.nombreCompleto))
            throw new ArgumentException("El nombre no puede ser nulo o vacio");

        if (string.IsNullOrEmpty(obj.correo))
            throw new ArgumentException("El correo no puede ser nulo o vacio");


        int? id = null;
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        adapter.insertUsuarioAdministracion(obj.correo, obj.nombreCompleto,obj.rolId, ref id);

        if (id == null || id.Value <= 0)
            throw new Exception("La llave primaria no se generó correctamente");
        else
            enviarEmailNuevoUsuario(id.Value);
        return id.Value;
    }

    public static void updateUsuario(Usuario obj)
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        adapter.updateUsuario(obj.correo, obj.nombreCompleto, obj.usuarioId,obj.rolId);
    }
    public static bool validateCodigoActivacion(string codigoActivacion)
    {
        bool? esCodigoCorrecto = false;
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        adapter.validateCodigoActivacion(codigoActivacion, ref esCodigoCorrecto);
        return esCodigoCorrecto.Value;

    }
    public static bool validateCodigoRecuperacion(string codigoRecuperacion)
    {
        bool? esCodigoCorrecto = null;
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        adapter.validateCodigoRecuperacion(codigoRecuperacion, ref esCodigoCorrecto);
        return esCodigoCorrecto.Value;

    }
    public static bool validateEmail(string email)
    {
        bool? existeMail = null;
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        adapter.validateEmail(ref existeMail, email);
        return existeMail == null ? false : true;

    }
    public static void updateCodigoRecuperacion(string email)
    {
        int? id = null;
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        try
        {
            adapter.updateCodigoRecuperacion(email, ref id);
            enviarEmailRecuperacion(id.Value);
        }
        catch (Exception ex)
        {
            Console.WriteLine("error al actualizar codigo recuperacion" + ex);
            return;
        }


    }
    public static void updatePassword(string codigoRecuperacion, string password)
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        try
        {
            adapter.updatePassword(codigoRecuperacion, password);
        }
        catch (Exception ex)
        {
            Console.WriteLine("error al updatePassword" + ex);
            return;
        }


    }
    public static void enviarEmailNuevoUsuario(int usuarioId)
    {
        try
        {
            Usuario user = UsuarioBLL.getUsuarioById(usuarioId);

            MailMessage mail = new MailMessage();
            SmtpClient smtpCli = new SmtpClient();
            mail.From = new MailAddress("jose.cadima@aetest.net");
            mail.To.Add(new MailAddress(user.correo));

            string message =
                "<p>" +
                    "Felicidades por tu nueva cuenta en MICRUBER ,aqui tienes los credenciales para iniciar sesion" +
                    "Correo: "+user.correo+"</br>" +
                    "Contraseña: "+user.tempPassword+"" +
                    "Te recomendamos cambiar de contraseña al iniciar sesion" +
                "</p>" +
                "http://localhost:63191/Login.aspx";
            mail.Body = message;
            mail.IsBodyHtml = true;
            mail.Subject = "Activacion de Cuenta";
            smtpCli.Host = "mail.aetest.net";
            smtpCli.Port = 587; //Lo use gmail por defecto
            smtpCli.Credentials = new NetworkCredential("jose.cadima@aetest.net", "ysNwm0axilRj");
            smtpCli.EnableSsl = true;
            smtpCli.Send(mail);
        }
        catch (Exception e)
        {
            Console.WriteLine("Error: " + e.Message);
        }
    }
    public static void enviarEmail(int usuarioId)
    {
        try
        {
            Usuario user = UsuarioBLL.getUsuarioById(usuarioId);

            MailMessage mail = new MailMessage();
            SmtpClient smtpCli = new SmtpClient();
            mail.From = new MailAddress("franz.bascope@aetest.net");
            mail.To.Add(new MailAddress(user.correo));

            string message =
                "<p>" +
                    "Felicidades tu cuenta en MICRUBER ha sido activada, haz click en el siguiente link para confirmarla" +
                "</p>" +
                "http://localhost:63191/Usuarios/ConfirmarCuenta.aspx?code=" + user.codigoActivacion;
            mail.Body = message;
            mail.IsBodyHtml = true;
            mail.Subject = "Activacion de Cuenta";
            smtpCli.Host = "mail.aetest.net";
            smtpCli.Port = 587; //Lo use gmail por defecto
            smtpCli.Credentials = new NetworkCredential("franz.bascope@aetest.net", "Ln4PCWZZhF4D");
            smtpCli.EnableSsl = true;
            smtpCli.Send(mail);
        }
        catch (Exception e)
        {
            Console.WriteLine("Error: " + e.Message);
        }
    }
    public static void enviarEmailRecuperacion(int usuarioId)
    {
        try
        {
            Usuario user = UsuarioBLL.getUsuarioById(usuarioId);

            MailMessage mail = new MailMessage();
            SmtpClient smtpCli = new SmtpClient();
            mail.From = new MailAddress("franz.bascope@aetest.net");
            mail.To.Add(new MailAddress(user.correo));

            string message =
                "<p>" +
                    "Hemos encontrado tu cuenta, haz click en el siguiente link para crear tu nueva contraseña" +
                "</p>" +
                "http://localhost:63191/Usuarios/CreateNewPassword.aspx?code=" + user.codigoRecuperacion;
            mail.Body = message;
            mail.IsBodyHtml = true;
            mail.Subject = "Recupreacion de Cuenta";
            smtpCli.Host = "mail.aetest.net";
            smtpCli.Port = 587; //Lo use gmail por defecto
            smtpCli.Credentials = new NetworkCredential("franz.bascope@aetest.net", "Ln4PCWZZhF4D");
            smtpCli.EnableSsl = true;
            smtpCli.Send(mail);
        }
        catch (Exception e)
        {
            Console.WriteLine("Error: " + e.Message);
        }
    }

    public static int updateSenha(int usuarioId, String newPass, String oldPass)
    {
        if (string.IsNullOrEmpty(newPass))
            throw new ArgumentException("La contraseña no puede ser nulo o vacio");

        if (string.IsNullOrEmpty(oldPass))
            throw new ArgumentException("La contraseña no puede ser nulo o vacio");

        int? id = null;
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        adapter.updateSenha(usuarioId, oldPass, newPass, ref id);

        if (id == null || id.Value <= 0)
            throw new Exception("La llave primaria no se generó correctamente");

        return id.Value;
    }
    




}