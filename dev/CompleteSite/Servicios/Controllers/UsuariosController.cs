
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
    public class EmpresaController : ApiController
    {
        // GET api/values

        [HttpGet()]
        [Route("usuarios")]
        public HttpResponseMessage getUsuarios()
        {
            HttpResponseMessage msg = null;
            try
            {
                List<Usuario> listaUsuarios = UsuarioBLL.getAllUsuarios();
                return Request.CreateResponse<List<Usuario>>(HttpStatusCode.OK, listaUsuarios);
            }
            catch (Exception ex)
            {
                Request.CreateResponse(HttpStatusCode.BadRequest, "");
                throw ex;
            }
        }

    }
}