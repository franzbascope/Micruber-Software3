using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OAuth;
using WebNurServiciosPedidos.Models;
using WebNurServiciosPedidos.Results;
using ES = Entidades.Seguridad;
using NS = Negocio.Seguridad;
using System.Net;
using Access.Seguridad;

namespace WebNurServiciosPedidos.Controllers
{
    
    [RoutePrefix("api/pedido")]
    public class PedidoController : ApiController
    {        
        // POST api/values
        [HttpPost()]        
        public IHttpActionResult PostPedido([FromBody]ES.Pedido objPedido)
        {
          
            try
            {
                if (ModelState.IsValid)
                {
                    objPedido.IsMovil = true;
                    objPedido.PedidoId = NS.PedidoBRL.insertPedido(objPedido);
                    foreach( Entidades.Seguridad.DetallePedido detallePedido in objPedido.lstDetalle)
                    {
                        detallePedido.PedidoId = objPedido.PedidoId;
                        NS.DetallePedidoBRL.insertDetallePedido(detallePedido);

                    }
                    //bcUser.insertUser(objUsuario);
                    return CreatedAtRoute("PostPedido", new { id = objPedido.PedidoId }, objPedido);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return BadRequest();
        }


        [HttpGet()]
        [Route("pedidoDash/{DashId}")]
        public HttpResponseMessage GetByEmail(String DashId)
        {
            HttpResponseMessage msg = null;
            //Console.Write(DashId);

            int idDash = 0;
            idDash = Convert.ToInt32(DashId);

            ES.ConfigDash objConfig = ConfigDashBRL.GetConfigDashByDashID(idDash);

            ES.Pedido objPedido = new ES.Pedido() {
                ClienteId = objConfig.UserId,
                EmpresaId = objConfig.EmpresaId,
                Fecha = DateTime.Now,
                Atendido = false,
                Latitud = objConfig.Latitud,
                Longitud = objConfig.Longitud,
                IsMovil = false,

            };


            int pedidoID = NS.PedidoBRL.insertPedido(objPedido);
            ES.Producto objProd = ProductoBRL.getProductoById(objConfig.ProductoId);

            ES.DetallePedido objDetalle = new ES.DetallePedido() {
                PedidoId = pedidoID,
                ProductoId = objProd.ProductoId,
                Precio = objProd.Precio,
                Cantidad = objConfig.Cantidad,
                SubTotal = (objProd.Precio * objConfig.Cantidad)
            };

            NS.DetallePedidoBRL.insertDetallePedido(objDetalle);

            msg = Request.CreateResponse(HttpStatusCode.NotFound, "Dash Selecc: " + DashId);
            return msg;            
        }


        [HttpPost()]
        [Route("pedidoDash/dush")]
        public IHttpActionResult POSTDASH([FromBody]ES.ConfigDash objConfig)
        {

            try
            {
                if (ModelState.IsValid)
                {
                    ES.ConfigDash objConf = ConfigDashBRL.GetConfigDashByDashID(objConfig.DashId);
                    if (objConf != null)
                    {
                        ConfigDashBRL.DeleteConfigDash(objConf.ConfigDashId);
                    }
                    int conf = ConfigDashBRL.InsertConfigDash(objConfig);
                    
                    //bcUser.insertUser(objUsuario);
                    return CreatedAtRoute("PostDash", new { id = conf }, objConfig);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return BadRequest();
        }

    }
}