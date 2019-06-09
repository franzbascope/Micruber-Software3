using DAL.Rutas;
using DAL.Rutas.RutaDSTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VentasNur.Model;

public class RutaBLL
{
    public RutaBLL()
    {
    }
    private static Recorrido getLineaFromRow(RutaDS.RutaRow row)
    {
        return new Recorrido()
        {
            lat = (double)row.lat,
            lng = (double)row.lng
        };
    }
    public static List<Recorrido> getRecorridos(int rutaId)
    {
        if (rutaId <= 0)
            throw new Exception("La rutaId no puede ser <= 0");

        RutasTableAdapter localAdapter = new RutasTableAdapter();

        RutaDS.RutaDataTable table = localAdapter.getRutaById(rutaId);

        List<Recorrido> list = new List<Recorrido>();
        foreach (var row in table)
        {
            Recorrido obj = getLineaFromRow(row);
            list.Add(obj);
        }
        return list;
    }
}

