using CapaAcceso.App_Code.Model.Pagos;
using DAL.Pagos;
using DAL.Pagos.TarjetasDSTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAcceso.App_Code.BLL.Pagos
{
    public class TarjetaBLL
    {
        private static Tarjeta getTarjetaFromRow(TarjetasDS.TarjetasRow row)
        {
            return new Tarjeta()
            {
                tarjetaId = row.id,
                codigoNFC = row.codigoNFC,
                estado = row.estado
            };
        }
        public static List<Tarjeta> getTarjetasByUsuarioId(int usuarioId)
        {
            if (usuarioId <= 0)
                throw new Exception("El usuarioId no puede ser <=0");

            TarjetasTableAdapter localAdapter = new TarjetasTableAdapter();
            TarjetasDS.TarjetasDataTable table = localAdapter.getTarjetasByUsuarioId(usuarioId);

            List<Tarjeta> list = new List<Tarjeta>();
            foreach (var row in table)
            {
                Tarjeta obj = getTarjetaFromRow(row);
                list.Add(obj);
            }
            return list;
        }
        public static void cambiarEstadoTarjeta( int tarjetaId,int estado)
        {
            if (tarjetaId <= 0)
                throw new Exception("El tarjetaId no puede ser <=0");

            TarjetasTableAdapter localAdapter = new TarjetasTableAdapter();
            localAdapter.cambiarEstadoTarjeta(tarjetaId,estado);
        }
        
    }
}
