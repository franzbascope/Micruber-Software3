using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
   
        public abstract class Entidad
        {

         

            public Accion statusType { get; set; } = Entidades.Accion.NoAction;

         
            public Entidad Clone()
            {
                return (Entidad)this.MemberwiseClone();
            }

         

        }
    }

