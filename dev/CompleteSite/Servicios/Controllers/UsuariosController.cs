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
    [RoutePrefix("api/usuarios")]
    public class EmpresaController : ApiController
    {
        // GET api/values

        [HttpGet()]
        [Route("getUsuarios/")]
        public HttpResponseMessage getEmpresas()
        {
            HttpResponseMessage msg = null;
            //   NS.ProductoBRL bcProduct = new NS.ProductoBRL();


            try
            {
                List<Usuario> listaUsuarios = UsuarioBLL.getAllUsuarios();
                msg = Request.CreateResponse<List<Usuario>>(HttpStatusCode.OK, listaUsuarios);
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