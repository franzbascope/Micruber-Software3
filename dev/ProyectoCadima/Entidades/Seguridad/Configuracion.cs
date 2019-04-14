using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class Configuracion
    {
        public Configuracion()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static VersionInfo GetVersionInfo()
        {
            try
            {
                int versionMayor = Convert.ToInt32(ConfigurationManager.AppSettings["versionMayor"]);
                int versionMenor = Convert.ToInt32(ConfigurationManager.AppSettings["versionMenor"]);
                int patch = Convert.ToInt32(ConfigurationManager.AppSettings["patch"]);

                return new VersionInfo()
                {
                    VersionMayor = versionMayor,
                    VersionMenor = versionMenor,
                    Patch = patch
                };
            }
            catch (Exception)
            {
                throw new Exception("La informacion de la version no esta definida para la aplicacion");
            }

            return null;
        }
    }
}
