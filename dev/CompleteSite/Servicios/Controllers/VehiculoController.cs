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
    public class VehiculoController : ApiController
    {
   
        [HttpGet()]
        [Route("vehiculoByPlaca")]
        public HttpResponseMessage getVehiculoByPlaca(string placa)
        {
            if (String.IsNullOrEmpty(placa))
                return Request.CreateResponse(HttpStatusCode.NotFound, placa);
            else
            {
                try
                {
                    Vehiculo objVehiculo = VehiculoBLL.getVehiculoByPlaca(placa);
                    return Request.CreateResponse<Vehiculo>(HttpStatusCode.OK, objVehiculo);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("error al obtener el vehiculo by placa" + placa);
                    return Request.CreateResponse(HttpStatusCode.NotFound, placa);
                }
               
            }
        }
    }
}