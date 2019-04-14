using Access.Seguridad;
using Data.Seguridad;
using Data.Seguridad.PedidoDSTableAdapters;
using Data.Seguridad.ProductoDSTableAdapters;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Seguridad
{
    public class PedidoBRL
    {
        public PedidoBRL()
        {
        }

        public static int insertPedido(Pedido obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("El objeto Pedido no debe ser nulo");
            }

            int? pedidoId = 0;
            PedidosAdapter adapter = new PedidosAdapter();
            adapter.Insert(obj.ClienteId, obj.EmpresaId, null, obj.Fecha, obj.Atendido, obj.Latitud, obj.Longitud, obj.IsMovil, ref pedidoId);
            //adapter.Insert(obj.ClienteId, obj.EmpresaId,null, obj.Fecha, obj.Atendido, ref productoId);

            if (pedidoId <= 0)
            {
                throw new ArgumentException("Falla al insertar, el pedidoId es menor que 0");
            }
            enviarPedido(pedidoId.Value);

            return pedidoId.Value;
        }
        public static bool enviarPedido(int pedidoId)
        {
            try
            {
                MailMessage mail = new MailMessage();
                SmtpClient smtpCli = new SmtpClient();

                mail.From = new MailAddress("easywebsoft3@gmail.com");
                mail.To.Add(new MailAddress("jose75684847@gmail.com"));

                Pedido objPedido = GetPedidoByID(pedidoId);
                User objCliente = UserBRL.getUserById(objPedido.ClienteId);
                Empresa objEmpresa = EmpresaBRL.getEmpresaById(objPedido.EmpresaId);
                string dispositivo;
                if (objPedido.IsMovil)
                {
                    dispositivo = "Telefono Movil";
                }
                else
                {
                    dispositivo = "Dash-Button";
                }

                string message =
                    "<p><strong>" +
                        "SE HA REALIZADO UN NUEVO PEDIDO: " +
                    "</strong></p>" +
                    "<p>CLIENTE: " + objCliente.Nombre + " " + objCliente.Apellido + "</p>" +
                    "<p>CORREO: " + objCliente.Email + "</p>" +
                    "<p>LATITUD: " + objPedido.Latitud + "</p>" +
                    "<p>LONGITUD: " + objPedido.Longitud + "</p>" +
                    "<p>EMPRESA: " + objEmpresa.Nombre + "</p>" +
                    "<p>DISPOSITIVO: " + dispositivo + "</p><br><br>" +
                    "<p>Enlace: " + "http://localhost:49640/Pedido/FormPedido.aspx?Id=" + pedidoId + "</p>";

                mail.Body = message;
                mail.IsBodyHtml = true;
                mail.Subject = "NUEVO PEDIDO";
                smtpCli.Host = "smtp.gmail.com";
                smtpCli.Port = 587; //Lo use gmail por defecto
                smtpCli.Credentials = new NetworkCredential("easywebsoft3@gmail.com", "easyweb123");
                smtpCli.EnableSsl = true;
                smtpCli.Send(mail);


                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine("Pinshe Error: " + e.Message);
                return false;
            }

        }
        public static Pedido GetPedidoByID(int pedidoId)
        {
            if (pedidoId <= 0)
            {
                throw new ArgumentException("El pedidoId no debe ser menor a 1");
            }

            PedidosAdapter adapter = new PedidosAdapter();
            PedidoDS.PedidosDataTable table = adapter.GetPedidoById(pedidoId);
            if (table.Rows.Count == 0)
            {
                return null;
            }

            PedidoDS.PedidosRow row = table[0];

            Pedido obj = new Pedido();

            try
            {
                obj.UsuarioId = row.usuarioId;
            }
            catch (Exception)
            {
                obj.UsuarioId = 0;
            }
            obj.PedidoId = row.pedidoId;
            obj.ClienteId = row.clienteId;
            obj.EmpresaId = row.empresaId;

            obj.Fecha = row.fecha;
            obj.Atendido = row.Atendido;
            obj.Latitud = row.latitud;
            obj.Longitud = row.longitud;
            obj.IsMovil = row.isMovil;
            
            try
            {
                obj.TotalPago = row.totalPago;
            }
            catch (Exception)
            {
                obj.TotalPago = 0;
            }

            return obj;

        }
        public static List<Pedido> GetPedidos()
        {
            PedidosAdapter adapter = new PedidosAdapter();
            PedidoDS.PedidosDataTable table = adapter.GetPedido();

            List<Pedido> listResult = new List<Pedido>();
            Pedido objPedido;
            User objUser;
            Empresa objEmpresa;
            foreach (var row in table)
            {
                objPedido = new Pedido();
                try{ objPedido.UsuarioId = row.usuarioId; }
                catch (Exception){ objPedido.UsuarioId = 0; }

                objPedido.PedidoId = row.pedidoId;
                objPedido.ClienteId = row.clienteId;
                objPedido.EmpresaId = row.empresaId;
                objPedido.Fecha = row.fecha;
                objPedido.Atendido = row.Atendido;
                objPedido.Latitud = row.latitud;
                objPedido.Longitud = row.longitud;
                objPedido.IsMovil = row.isMovil;
                objPedido.TotalPago = row.totalPago;

                objUser = UserBRL.getUserById(row.clienteId);
                objPedido.T_ClienteName = objUser.Nombre + " " + objUser.Apellido;

                objEmpresa = EmpresaBRL.getEmpresaById(row.empresaId);
                objPedido.T_EmpresaName = objEmpresa.Nombre;
                if (row.Atendido)
                {
                    objPedido.T_EstadoAtencion = "PEDIDO ATENDIDO";
                } else
                {
                    objPedido.T_EstadoAtencion = "PEDIDO PENDIENTE";
                }

                if (row.isMovil)
                {
                    objPedido.T_Dispositivo = "Teléfono Móvil";
                } else
                {
                    objPedido.T_Dispositivo = "Dash-Button";
                }

                listResult.Add(objPedido);
            }

            return listResult;
        }
        public static void AtenderPedido(int pedidoId)
        {
            if (pedidoId <= 0)
            {
                throw new ArgumentException("El pedidoId debe ser mayor a 1");
            }

            PedidosAdapter adapter = new PedidosAdapter();
            adapter.AtenderPedido(pedidoId);
        }
    }
}
