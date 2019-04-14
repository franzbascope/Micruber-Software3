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
using ES = Access.Seguridad;
using NS = Access.Seguridad;
using System.Net;

namespace WebNurServiciosPedidos.Controllers
{

    [RoutePrefix("api/clasificadores")]
    public class ClasificadoresController : ApiController
    {
        // GET api/values

        [HttpGet()]
        [Route("getClasificadores/")]
        public HttpResponseMessage getClasificadores()
        {
            HttpResponseMessage msg = null;
         //   NS.ProductoBRL bcProduct = new NS.ProductoBRL();


            try
            {
                List<Entidades.Seguridad.TipoHijos> lstHijos = NS.TipoHijoBRL.geTipoHijos();
                msg = Request.CreateResponse<List<Entidades.Seguridad.TipoHijos>>(HttpStatusCode.OK, lstHijos);
                return msg;



                return msg;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        // POST api/values
    }
}