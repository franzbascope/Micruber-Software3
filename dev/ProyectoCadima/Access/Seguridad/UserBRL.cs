using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades.Seguridad;
using Data.Seguridad.UserDSTableAdapters;
using Data.Seguridad;

using System.Net;
using System.Net.Mail;
using Access.Seguridad;

namespace Negocio.Seguridad
{
    public class UserBRL
    {
        public UserBRL()
        {

        }        

        public static int insertUser(User obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("El objeto a ingresar no puede ser Nulo");
            }

            if (String.IsNullOrEmpty(obj.Nombre))
            {
                throw new ArgumentException("El nombre no puede ser Nulo ni vacio");
            }

            int? usuarioId = 0;

            //Console.Write(obj.Nombre);

            UsuariosTableAdapter adapter = new UsuariosTableAdapter();
            adapter.Insert(obj.Nombre, obj.Apellido, obj.Email, obj.Contraseña, obj.TipoUsuario, ref usuarioId);

            if (usuarioId == null || usuarioId <= 0)
            {
                throw new ArgumentException("La llave primaria no se genero correctamente");
            }

            return usuarioId.Value;

        }

        public static void updateUser(User obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("El objeto Recuperacion a ingresar no puede ser Nulo");
            }
            UsuariosTableAdapter adapter = new UsuariosTableAdapter();
            adapter.Update(obj.Nombre, obj.Apellido, obj.UsuarioId);
        }

        public static List<User> getUsuarios()
        {
            UsuariosTableAdapter adapter = new UsuariosTableAdapter();
            UserDS.UsuariosDataTable table = adapter.GetUsuarios();
            
            List<User> listUsers = new List<User>();
            
            foreach (var row in table)
            {
                User obj = new User();

                obj.UsuarioId = row.usuarioId;
                obj.Nombre = row.nombre;
                obj.Apellido = row.apellido;
                obj.Email = row.correo;
                obj.Contraseña = row.contraseña;
                obj.TipoUsuario = row.tipoUsuario;

                listUsers.Add(obj);
            }
            return listUsers;
        }
        public static User getUserByEmailAndPassword(String correo, String password)
        {
            if (correo.Equals(""))
            {
                throw new ArgumentException("Ingrese un Correo");
            }

            UsuariosTableAdapter adapter = new UsuariosTableAdapter();
            UserDS.UsuariosDataTable table = adapter.GetByEmailPass(correo, password);
            UserDS.UsuariosRow row = table[0];

            User obj = new User();

            obj.UsuarioId = row.usuarioId;
            obj.Nombre = row.nombre;
            obj.Apellido = row.apellido;
            obj.Email = row.correo;
            obj.Contraseña = row.contraseña;
            obj.TipoUsuario = row.tipoUsuario;

            return obj;

        }

        public  static User getUserById(int id)
        {
            if (id <= 0)
            {
                throw new ArgumentException("No se ha encontrado el Usuario");
            }

            UsuariosTableAdapter adapter = new UsuariosTableAdapter();
            UserDS.UsuariosDataTable table = adapter.GetUserById(id);


            if (table.Rows.Count == 0)
            {
                return null;
            }
            UserDS.UsuariosRow row = table[0];
            User obj = new User();

            obj.UsuarioId = row.usuarioId;
            obj.Nombre = row.nombre;
            obj.Apellido = row.apellido;
            obj.Email = row.correo;
            obj.Contraseña = row.contraseña;
            obj.TipoUsuario = row.tipoUsuario;

            return obj;
        }

        public static User getUserByEmail(string correo)
        {
            if (correo.Equals(""))
            {
                throw new ArgumentException("Ingrese un Correo");
            }

            UsuariosTableAdapter adapter = new UsuariosTableAdapter();
            UserDS.UsuariosDataTable table = adapter.GetUsuariosByEmail(correo);
            
            
            if (table.Rows.Count == 0)
            {
                return null;
            }
            UserDS.UsuariosRow row = table[0];
            User obj = new User();

            obj.UsuarioId = row.usuarioId;
            obj.Nombre = row.nombre;
            obj.Apellido = row.apellido;
            obj.Email = row.correo;
            obj.Contraseña = row.contraseña;
            obj.TipoUsuario = row.tipoUsuario;

            return obj;

        }        
        
        public static bool enviarEmail(string emailReceptor, User obj)
        {
            try
            {
                //Generador de Codigos de 12 digitos

                Guid gidCode = Guid.NewGuid();
                string code = gidCode.ToString().Substring(0, 14).Replace("-", "");

                MailMessage mail = new MailMessage();
                SmtpClient smtpCli = new SmtpClient();

                mail.From = new MailAddress("easywebsoft3@gmail.com");
                mail.To.Add(new MailAddress(emailReceptor));

                string message =
                    "<p>" +
                        "Hemos recibido tu solicitud para cambiar la contraseña de tu cuenta. Para cambiar de contraseña" +
                        " use el siguiente link" +
                    "</p>" +
                    "http://localhost:49640/AdminSecurity/ChangePassword.aspx?code=" + code;
                mail.Body = message;
                mail.IsBodyHtml = true;
                mail.Subject = "Change Password";
                smtpCli.Host = "smtp.gmail.com";
                smtpCli.Port = 587; //Lo use gmail por defecto
                smtpCli.Credentials = new NetworkCredential("easywebsoft3@gmail.com", "easyweb123");
                smtpCli.EnableSsl = true;
                smtpCli.Send(mail);
                

                //Creando Recuperacion de contraseña
                DateTime fechaEnvio = DateTime.Now;
                Recuperacion objRecup = new Recuperacion();
                {
                    objRecup.UsuarioId = obj.UsuarioId;
                    objRecup.Codigo = code;
                    objRecup.FechaGenerado = fechaEnvio;
                    objRecup.FechaActual = new DateTime(1900, 1, 1, 0, 0, 0);
                    objRecup.Tiempo = 2; //2 horas del link habilitado
                    objRecup.Estado = '1'; //Link habilitado;
                };
                RecuperacionBRL.insertRecuperacion(objRecup);

                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine("Pinshe Error: "+ e.Message);
                return false;
            }
            
        }        

    }
}
