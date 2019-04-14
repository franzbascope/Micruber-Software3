using Entidades.Seguridad;
using Data.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Data.Seguridad.RecuperacionDSTableAdapters;
//using Data.Seguridad.RecuperacionDSTableAdapters;

namespace Access.Seguridad
{
    public class RecuperacionBRL
    {
        public RecuperacionBRL()
        {

        }
                
        public static int insertRecuperacion(Recuperacion obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("El objeto Recuperacion a ingresar no puede ser Nulo");
            }

            if (String.IsNullOrEmpty(obj.Codigo))
            {
                throw new ArgumentException("Debe haber un codigo generado");
            }

            int? recuperacionId = 0;

            //Console.Write(obj.Nombre);

            RecuperacionTableAdapter adapter = new RecuperacionTableAdapter();
            adapter.Insert(obj.UsuarioId, obj.Codigo, obj.FechaGenerado, obj.FechaActual, obj.Tiempo, obj.Estado+"", ref recuperacionId);

            if (recuperacionId == null || recuperacionId <= 0)
            {
                throw new ArgumentException("La llave primaria no se genero correctamente");
            }

            return recuperacionId.Value;                
        }
        
        public static Recuperacion getRecuperacionByCode(string code)
        {            

            RecuperacionTableAdapter adapter = new RecuperacionTableAdapter();
            RecuperacionDS.RecuperacionDataTable table = adapter.GetRecuperacionByCode(code);


            if (table.Rows.Count == 0)
            {
                return null;
            }
            RecuperacionDS.RecuperacionRow row = table[0];
            Recuperacion obj = new Recuperacion();

            obj.RecuperacionId = row.recuperacionId;
            obj.UsuarioId = row.usuarioId;
            obj.Codigo = row.codigoGenerado;
            obj.FechaGenerado = row.fechaGenerado;
            obj.FechaActual = DateTime.Now;
            obj.Tiempo = row.tiempo;                        
            obj.Estado = Convert.ToChar((row.estado).Trim());

            return obj;
        }

        public static void updateRecuperacion(Recuperacion obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("El objeto Recuperacion a ingresar no puede ser Nulo");
            }

            RecuperacionTableAdapter adapter = new RecuperacionTableAdapter();
            adapter.Update(obj.Codigo, obj.FechaGenerado, obj.FechaActual, obj.Tiempo, obj.Estado + "", obj.RecuperacionId);

        }
       
    }
}
