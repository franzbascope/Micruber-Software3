using CapaAcceso.App_Code.BLL.PagosBLL;
using CapaAcceso.App_Code.Model.Pagos;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using VentasNur.Model;

namespace Servicios.Controllers
{
    [RoutePrefix("api")]
    public class PagosController : ApiController
    {
        // GET api/values

        [HttpPost()]
        [Route("obtenerPagos")]
        public HttpResponseMessage PostPedido([FromBody]JToken body) 
        {
            int usuarioId = body.Value<int>("usuarioId");
            try
            {
                List<PagoUsuario> listaPagos = PagosBLL.getPagosMontoByUsuarioId(usuarioId);
                return Request.CreateResponse<List<PagoUsuario>>(HttpStatusCode.OK, listaPagos);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex);
            }
        }

        [HttpPost()]
        [Route("pagos")]
        public HttpResponseMessage PostPagos([FromBody]PagoUsuario pago)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    PagosBLL.insertPago(pago.correo,pago.monto,pago.userRecargo);
                    return Request.CreateResponse<int>(HttpStatusCode.OK, 1);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return Request.CreateResponse(HttpStatusCode.BadRequest);
        }

        [HttpPost()]
        [Route("obtenerPagosPasajeros")]
        public HttpResponseMessage obtenerPagos([FromBody]JToken body)
        {
            int usuarioId = body.Value<int>("usuarioId");
            string fechaDesde = body.Value<string>("fechaDesde");
            string fechaHasta = body.Value<string>("fechaHasta");
            DateTime dateDesde = DateTime.ParseExact(fechaDesde, "yyyy-MM-dd", CultureInfo.InvariantCulture);
            DateTime dateHasta = DateTime.ParseExact(fechaHasta, "yyyy-MM-dd", CultureInfo.InvariantCulture);
            try
            {
                List<Pagos> listaPagos = PagosBLL.getPagosByUsuarioId(usuarioId, dateDesde, dateHasta);
                return Request.CreateResponse<List<Pagos>>(HttpStatusCode.OK, listaPagos);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex);
            }
        }
        [HttpPost()]
        [Route("pagosUsuario")]
        public HttpResponseMessage PostPagosUsuarios([FromBody]Pagos pago)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    PagosBLL.insertPagoUsuario(pago.usuarioId, pago.vehiculoId, pago.lineaId);
                    Usuario objUsuario = UsuarioBLL.getUsuarioById(pago.usuarioId);
                    return Request.CreateResponse<Usuario>(HttpStatusCode.OK, objUsuario);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return Request.CreateResponse(HttpStatusCode.BadRequest);
        }

    }
}