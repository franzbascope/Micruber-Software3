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
using CapaAcceso.App_Code.BLL.Pagos;
namespace Servicios.Controllers
{
    [RoutePrefix("api")]
    public class TarjetaController : ApiController
    {
        // GET api/values

        [HttpGet()]
        [Route("tarjetas")]
        public HttpResponseMessage getTarjetasByUsuarioId(int usuarioId)
        {
            if (usuarioId <= 0)
                return Request.CreateResponse(HttpStatusCode.NotFound, usuarioId);
            else
            {
                List<Tarjeta> listaTarjetas = TarjetaBLL.getTarjetasByUsuarioId(usuarioId);
                return Request.CreateResponse<List<Tarjeta>>(HttpStatusCode.OK, listaTarjetas);
            }
        }
        [HttpPost()]
        [Route("cambiarEstadoTarjeta")]
       public HttpResponseMessage cambiarEstadoTarjeta([FromBody]Tarjeta tarjeta)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    TarjetaBLL.cambiarEstadoTarjeta(tarjeta.tarjetaId, tarjeta.estado);
                    return Request.CreateResponse<Tarjeta>(HttpStatusCode.OK, tarjeta);
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