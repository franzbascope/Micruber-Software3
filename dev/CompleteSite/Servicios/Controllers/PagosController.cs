using CapaAcceso.App_Code.BLL.PagosBLL;
using CapaAcceso.App_Code.Model.Pagos;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Servicios.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
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
                    PagosBLL.insertPago(pago.correo, pago.monto, pago.userRecargo);
                    return Request.CreateResponse<int>(HttpStatusCode.OK, 1);
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