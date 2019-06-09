using DAL.Pagos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaAcceso.App_Code.Model.Pagos;
using DAL.Pagos.PagosDSTableAdapters;
using VentasNur.Model;
using System.Configuration;

namespace CapaAcceso.App_Code.BLL.PagosBLL
{
    public class PagosBLL
    {
        public PagosBLL()
        {

        }
        private static Pagos getPagoFromRow(PagosDS.PagosRow row)
        {
            return new Pagos()
            {
                pagoId = row.pagoId,
                fechaPago = row.fechaPago,
                conceptoId = row.conceptoId,
                conceptoDescripcion = row.concepto,
                numeroLinea = row.numeroLinea,
                esIngreso = row.esIngreso
            };
        }
        public static List<Pagos> getPagosByUsuarioId(int usuarioId, DateTime fechaDesde, DateTime fechaHasta)
        {
            if (usuarioId <= 0)
                throw new Exception("El usuarioId no puede ser <=0");

            PagosTableAdapter localAdapter = new PagosTableAdapter();
            PagosDS.PagosDataTable table = localAdapter.getPagosByUsuarioId(usuarioId, fechaDesde, fechaHasta);

            List<Pagos> list = new List<Pagos>();
            foreach (var row in table)
            {
                Pagos obj = getPagoFromRow(row);
                list.Add(obj);
            }
            return list;
        }

        public static void insertPago(int usuarioId, int vehiculoId, int lineaId)
        {
            Usuario objUsuario;
            if (usuarioId <= 0)
                throw new Exception("El usuarioId no puede ser <=0");
            try {
                 objUsuario = UsuarioBLL.getUsuarioById(usuarioId);
            }
            catch (Exception ex)
            {
                Console.WriteLine("error al insertar pago" + ex);
                return;
            }
            int conceptoId = string.IsNullOrEmpty(ConfigurationSettings.AppSettings["conceptoIdMayores"]) ?
                    -1 : Convert.ToInt32(ConfigurationSettings.AppSettings["conceptoIdMayores"]);
            conceptoId = 1;
            if (objUsuario.esEstudiante)
            {
                conceptoId = string.IsNullOrEmpty(ConfigurationSettings.AppSettings["conceptoIdEstudiantes"]) ?
                 -1 : Convert.ToInt32(ConfigurationSettings.AppSettings["conceptoIdEstudiantes"]);
                conceptoId = 2;
            }

            try
            {
                PagosTableAdapter localAdapter = new PagosTableAdapter();
                localAdapter.insertPago(usuarioId, vehiculoId, conceptoId, lineaId);

            }
            catch (Exception ex)
            {
                Console.WriteLine("error al insertar pago" + ex);
            }


        }
    }
}
