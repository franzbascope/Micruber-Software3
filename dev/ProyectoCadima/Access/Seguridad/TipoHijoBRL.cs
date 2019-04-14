using Data.Seguridad;
using Data.Seguridad.TipoHijoDSTableAdapters;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Access.Seguridad
{
    public class TipoHijoBRL
    {
        public TipoHijoBRL()
        {
        }

        public static List<TipoHijos> getTipoHijoByIdMaestro(int idMaestro)
        {
            TipoHijosTableAdapter adapter = new TipoHijosTableAdapter();
            TipoHijoDS.TipoHijosDataTable table = adapter.GetTipoHijosByIdMaestro(idMaestro);

            List<TipoHijos> listHijos = new List<TipoHijos>();
            foreach (var row in table)
            {
                TipoHijos obj = new TipoHijos();
                obj.TipoHijosId = row.tipoHijosId;
                obj.TipoMaestroId = row.tipoMaestroId;
                obj.Nombre = row.nombre;
                obj.Valor = row.valor;
                obj.Estado = row.estado;

                listHijos.Add(obj);
            }

            return listHijos;
        }

        public static List<TipoHijos> geTipoHijos()
        {
            TipoHijosTableAdapter adapter = new TipoHijosTableAdapter();
            TipoHijoDS.TipoHijosDataTable table = adapter.GetTipoHijos();

            List<TipoHijos> listHijos = new List<TipoHijos>();
            foreach (var row in table)
            {
                TipoHijos obj = new TipoHijos();
                obj.TipoHijosId = row.tipoHijosId;
                obj.TipoMaestroId = row.tipoMaestroId;
                obj.Nombre = row.nombre;
                obj.Valor = row.valor;
                obj.Estado = row.estado;

                listHijos.Add(obj);
            }

            return listHijos;
        }
    }
}
