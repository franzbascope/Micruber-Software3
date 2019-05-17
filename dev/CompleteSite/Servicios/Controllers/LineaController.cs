using Newtonsoft.Json;
using Servicios.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using VentasNur.Model;

namespace Servicios.Controllers
{
    [RoutePrefix("api")]
    public class LineaController : ApiController
    {
   
        [HttpGet()]
        [Route("lineasByvehiculoId")]
        public HttpResponseMessage getLineasByVehiculoId(int vehiculoId)
        {
            if (vehiculoId <=0)
                return Request.CreateResponse(HttpStatusCode.NotFound, vehiculoId);
            else
            {
                try
                {
                    List<Linea> listaLineas = LineaBLL.getLineaByVehiculoId(vehiculoId);
                    return Request.CreateResponse<List<Linea>>(HttpStatusCode.OK, listaLineas);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("error al obtener la linea by vehiculoId" + vehiculoId);
                    return Request.CreateResponse(HttpStatusCode.NotFound, vehiculoId);
                }
               
            }
        }
    }
}