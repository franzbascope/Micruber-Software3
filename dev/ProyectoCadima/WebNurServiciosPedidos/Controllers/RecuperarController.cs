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
using WebNurServiciosPedidos.Providers;
using WebNurServiciosPedidos.Results;
using ES = Entidades.Seguridad;
using NS = Negocio.Seguridad;
using System.Net;

namespace WebNurServiciosPedidos.Controllers
{
    [Authorize]
    [RoutePrefix("api/recuperar")]
    public class RecuperarController : ApiController
    {
      
      

        // POST api/values
        public IHttpActionResult Post([FromBody]ES.User objUsuario)
        {
           // HttpResponseMessage msg = null;
            NS.UserBRL bcUser;
            try
            {
                bcUser = new NS.UserBRL();
                if (ModelState.IsValid)
                {
                    ES.User user = null;
                    user = bcUser.getUserByEmail(objUsuario.Email);
                    if (user != null)
                    {
                        //msg = Request.CreateResponse
                        return CreatedAtRoute("PostUsuario", new { id = user.UsuarioId }, user);
                    }else
                    {
                        return NotFound();
                    }     
                 
                    
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