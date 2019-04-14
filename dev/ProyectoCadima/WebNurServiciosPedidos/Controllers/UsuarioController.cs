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
using ES = Entidades.Seguridad;
using NS = Negocio.Seguridad;
using System.Net;

namespace WebNurServiciosPedidos.Controllers
{
    
    [RoutePrefix("api/usuario")]
    public class UsuarioController : ApiController
    {
        // GET api/values
        public IEnumerable<ES.User> Get()
        {
            NS.UserBRLNoStatic bcUser = new NS.UserBRLNoStatic();
            List<ES.User> lstAccount = new List<ES.User>();          
            try
            {
                bcUser = new NS.UserBRLNoStatic();
                List<ES.User> beAccount = new List<ES.User>();
                //lstAccount = bcUser.getUsuarios();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return lstAccount;
        }

        [HttpGet()]
        [Route("getByEmail/{email}")]
        public HttpResponseMessage GetByEmail(String email)
        {
            HttpResponseMessage msg = null;
            NS.UserBRLNoStatic bcUser = new NS.UserBRLNoStatic();
            ES.User beUser;
            try
            {
                bcUser = new NS.UserBRLNoStatic();
                beUser = bcUser.getUserByEmail(email);
                if (beUser != null && beUser.UsuarioId > 0)
                {
                    if (bcUser.enviarEmail(email, beUser) == true)
                    {
                        msg = Request.CreateResponse<ES.User>(HttpStatusCode.OK, beUser);
                        return msg;
                    }

                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.NotFound, "Usuario No Encontrado.!");
                    return msg;
                }
                return msg;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet()]
        [Route("getUserByEmail/{email}")]
        public HttpResponseMessage getUserByEmail(String email)
        {
            HttpResponseMessage msg = null;
            NS.UserBRLNoStatic bcUser = new NS.UserBRLNoStatic();            
            ES.User beUser;
            try
            {
                bcUser = new NS.UserBRLNoStatic();            
                beUser = bcUser.getUserByEmail(email);
                if (beUser != null && beUser.UsuarioId > 0)
                {
                    if (bcUser.enviarEmail(email,beUser) == true)
                    {
                        msg = Request.CreateResponse<ES.User>(HttpStatusCode.OK, beUser);
                        return msg;
                    }
                  
                }else { 
                     msg = Request.CreateResponse(HttpStatusCode.NotFound, "Usuario No Encontrado.!");
                    return msg;
                }
                return msg;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet()]
        [Route("getByEmailPass/{email}/{password}")]
        public HttpResponseMessage GetByEmailPass(String email, String password)
        {
            HttpResponseMessage msg = null;
            NS.UserBRLNoStatic bcUser = new NS.UserBRLNoStatic();
            ES.User beUser;
            try
            {
                bcUser = new NS.UserBRLNoStatic();
                beUser = bcUser.getUserByEmailAndPassword(email,password);
                if (beUser != null && beUser.UsuarioId > 0)
                {
                    msg = Request.CreateResponse<ES.User>(HttpStatusCode.OK, beUser);
                    return msg;
                }
                else
                {
                    msg = Request.CreateResponse(HttpStatusCode.NotFound, "Usuario No Encontrado.!");
                    return msg;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        // POST api/values
        [HttpPost()]        
        public IHttpActionResult PostUsuario([FromBody]ES.User objUsuario)
        {
            NS.UserBRLNoStatic bcUser;
            try
            {
                bcUser = new NS.UserBRLNoStatic();
                if (ModelState.IsValid)
                {
                  
                    bcUser.insertUser(objUsuario);
                    return CreatedAtRoute("PostUsuario", new { id = objUsuario.UsuarioId }, objUsuario);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return BadRequest();
        }

        // PUT api/values/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
        }
    }
}