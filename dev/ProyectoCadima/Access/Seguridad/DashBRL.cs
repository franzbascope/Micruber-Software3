using Data.Seguridad;
using Data.Seguridad.DashDSTableAdapters;
using Entidades.Seguridad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Access.Seguridad
{
    public class DashBRL
    {
        public DashBRL()
        {

        }

        public static int InsertDash(DashButton obj)
        {
            if (obj  == null)
            {
                throw new ArgumentException("El objeto dash no debe ser nulo");
            }

            int? DashId = 0;

            DashTableAdapter adapter = new DashTableAdapter();
            adapter.Insert(obj.Codigo, obj.Estado, ref DashId);

            if (DashId <= 0)
            {
                throw new ArgumentException("Error al generar la llave primaria del Dash");
            }

            return DashId.Value;
        }

        public static DashButton GetDashByCode(string code)
        {
            if (string.IsNullOrEmpty(code))
            {
                throw new ArgumentException("El codigo no debe ser nulo");
            }

            DashTableAdapter adapter = new DashTableAdapter();
            DashDS.DashDataTable table = adapter.GetDashByCode(code);

            if (table.Rows.Count <= 0)
            {
                return null;
            }

            DashDS.DashRow row = table[0];
            DashButton obj = new DashButton()
            {
                DashId = row.dashId,
                Codigo = row.codigo,
                Estado = row.estado
            };

            return obj;
        }

        public static List<DashButton> GetAllDash()
        {
            DashTableAdapter adapter = new DashTableAdapter();
            DashDS.DashDataTable table = adapter.GetAllDash();

            List<DashButton> listDash = new List<DashButton>();

            DashButton obj;
            foreach (var row in table)
            {
                obj = new DashButton()
                {
                    DashId = row.dashId,
                    Codigo = row.codigo,
                    Estado = row.estado
                };

                listDash.Add(obj);
            }

            return listDash;
        }
    }
}
