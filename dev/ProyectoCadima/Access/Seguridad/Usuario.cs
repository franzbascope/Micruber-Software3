using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio.Seguridad
{
    public class Usuario 
    {
        public void Save(Entidades.Seguridad.User objUsuario)
        {
            try
            {
                using (var DALObject = new Data.Seguridad.Usuario())
                {
                    DALObject.Save(objUsuario);
                }
            }
            catch (Exception ex)
            {
                
                throw new Exception("Ha ocurrido un error al guardar la informacion, por favor consulte con el administrador del sistema", ex);
            }
        }
    }
}
