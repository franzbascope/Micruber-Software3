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
    public class RutasController : ApiController
    {
        // GET api/values

        [HttpGet()]
        [Route("drawRoute")]
        public HttpResponseMessage getRutas(int id)
        {
            HttpResponseMessage msg = null;
            try
            {
                List<Recorrido> listaRutas = RutaBLL.getRecorridos(id);
                return Request.CreateResponse<List<Recorrido>>(HttpStatusCode.OK, listaRutas);
            }
            catch (Exception ex)
            {
                Request.CreateResponse(HttpStatusCode.BadRequest, "");
                throw ex;
            }
        }
        
    }
}