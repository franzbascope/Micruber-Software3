using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades.Seguridad
{
    public class User : Entidades.Entidad
    {
        public int UsuarioId { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Email { get; set; }
        public string Contraseña { get; set; }
        public string TipoUsuario { get; set; } //Tipo de Admi en nuestro caso
        public User()
        {

        }
        

    } 

    
    public enum relUsuario
    {        
        Compania
        
    }
}

