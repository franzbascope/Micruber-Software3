using Data.Seguridad.VersionDSTableAdapters;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Access.Seguridad
{
    public class VersionBRL
    {
        public VersionBRL()
        {
        }
        public static VersionInfo GetVersionInfo()
        {
            int? versionMayor = null;
            int? versionMenor = null;
            int? patch = null;
            VersionTableAdapter adapter = new VersionTableAdapter();
            //VersionDSTableAdapters.VersionTableAdapter adapter = new VersionDSTableAdapters.VersionTableAdapter();
            adapter.GetVersion(ref versionMayor, ref versionMenor, ref patch);

            if (versionMayor == null || versionMenor == null || patch == null)
                throw new Exception("La informacion de la version no esta definida para la base de datos");

            return new VersionInfo()
            {
                VersionMayor = versionMayor.Value,
                VersionMenor = versionMenor.Value,
                Patch = patch.Value
            };
        }
    }
}
