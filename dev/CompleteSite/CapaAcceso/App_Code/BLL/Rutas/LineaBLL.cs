using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VentasNur.Model;
using DAL.Seguridad;
using DAL.Seguridad.UsuarioDSTableAdapters;
using System.Net.Mail;
using System.Net;
using DAL.Rutas;
using DAL.Rutas.LineasDSTableAdapters;

/// <summary>
/// Descripción breve de UsuarioBLL
/// </summary>
public class LineaBLL
{
    public LineaBLL()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }
    private static Linea getLineaFromRow(LineasDS.LineasRow row)
    {
        return new Linea()
        {
            lineaId = row.lineaId,
            numeroLinea = row.numeroLinea,
            perteneceLinea=row.perteneceLinea
        };
    }
    public static List<Linea> getLineaByVehiculoId(int vehiculoId)
    {
        if (vehiculoId <=0)
            throw new Exception("el vehiculo id no puede ser <= 0");

        LineasTableAdapter localAdapter = new LineasTableAdapter();
        LineasDS.LineasDataTable table = localAdapter.getLineasByVehiculoId(vehiculoId);

        List<Linea> list = new List<Linea>();
        foreach (var row in table)
        {
            Linea obj = getLineaFromRow(row);
            list.Add(obj);
        }
        return list;
    }
    public static List<Linea> getAllLineasByVehiculoId(int id)
    {
        LineasTableAdapter adapter = new LineasTableAdapter();
        LineasDS.LineasDataTable table = adapter.GetLineaByVehiculoIdAsignar(id);

        List<Linea> list = new List<Linea>();
        foreach (var row in table)
        {
            Linea obj = getLineaFromRow(row);
            list.Add(obj);
        }
        return list;
        }

}