using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(WebNurServiciosPedidos.Startup))]

namespace WebNurServiciosPedidos
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
           // app.UseCors(CorsOptions.AllowAll);
            // ConfigureAuth(app);
        }
    }
}
