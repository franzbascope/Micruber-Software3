using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WebEjtor.Startup))]
namespace WebEjtor
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
