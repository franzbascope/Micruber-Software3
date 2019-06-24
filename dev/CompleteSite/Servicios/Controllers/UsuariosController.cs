
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

        [HttpPost()]
        [Route("usuarios/login")]
        public IHttpActionResult PostPedido([FromBody]Usuario usuario)
        {
            string json = JsonConvert.SerializeObject(usuario);
            try
            {
                if (ModelState.IsValid)
                {
                    if (String.IsNullOrEmpty(usuario.correo))
                        return BadRequest();
                    if (String.IsNullOrEmpty(usuario.password))
                        return BadRequest();
                    Usuario user = UsuarioBLL.autenticarUsuario(usuario.correo, usuario.password);
                    if (user == null)
                        return NotFound();
                    else
                        return Ok(user);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return BadRequest();
        }

        [HttpGet()]
        [Route("usuarios")]
        public HttpResponseMessage getUsuarioById(int id)
        {
            if (id <= 0)
                return Request.CreateResponse(HttpStatusCode.NotFound, id);
            else
            {
                Usuario user = UsuarioBLL.getUsuarioById(id);
                return Request.CreateResponse<Usuario>(HttpStatusCode.OK, user);
            }
        }

        [HttpGet()]
        [Route("usuarios")]
        public HttpResponseMessage getUsuarioByCodigoNFC(string codigoNFC)
        {
            if (String.IsNullOrEmpty(codigoNFC))
                return Request.CreateResponse(HttpStatusCode.NotFound, codigoNFC);
            else
            {
                Usuario user = UsuarioBLL.getUsuarioByCodigoNFC(codigoNFC);
                return Request.CreateResponse<Usuario>(HttpStatusCode.OK, user);
            }
        }

        [HttpPost()]
        [Route("usuarios")]
        public IHttpActionResult PostUsuario([FromBody]Usuario usuario)
        {
            string json = JsonConvert.SerializeObject(usuario);
            try
            {
                if (ModelState.IsValid)
                {
                    if (String.IsNullOrEmpty(usuario.nombreCompleto))
                        return BadRequest();
                    if (String.IsNullOrEmpty(usuario.correo))
                        return BadRequest();
                    if (String.IsNullOrEmpty(usuario.password))
                        return BadRequest();
                    int id = UsuarioBLL.insertUsuario(usuario);
                    usuario.usuarioId = id;
                    if (id == 0)
                        return NotFound();
                    else
                        return Ok(usuario);

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return BadRequest();
        }

        [HttpPost()]
        [Route("usuarios/validateNewPassword")]
        public IHttpActionResult PostEmail([FromBody]Usuario user)
        {
            string json = JsonConvert.SerializeObject(user);

            try
            {
                if (String.IsNullOrEmpty(user.correo))
                    return BadRequest();


                UsuarioBLL.updateCodigoRecuperacion(user.correo);

                return Ok("Correo enviado");

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpPost()]
        [Route("usuarios/updateSenha")]
        public int Post([FromBody]Senha value)
        {

            if (String.IsNullOrEmpty(value.newPassword))
            {
                Console.WriteLine("password nuevo vacio");
                return 0;
            }
            if (String.IsNullOrEmpty(value.oldPassword))
            {
                Console.WriteLine("password antiguo vacio");
                return 0;
            }
            if (String.IsNullOrEmpty(value.userId))
            {
                Console.WriteLine("user id vacio");
                return 0;
            }
            int respuesta = UsuarioBLL.updateSenha(int.Parse(value.userId), value.newPassword, value.oldPassword);

            return respuesta;
        }
    }

}