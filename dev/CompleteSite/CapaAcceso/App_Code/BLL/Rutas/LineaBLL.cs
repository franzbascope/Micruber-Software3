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
            perteneceLinea = row.IsperteneceLineaNull() ? false: row.perteneceLinea,
            distanciaCaminarMetros = row.IsdistanciaCaminarMetrosNull() ? 0 : row.distanciaCaminarMetros,
            distanciaRecorridoMetros = row.IsdistanciaRecorridoMetrosNull() ? 0 : row.distanciaRecorridoMetros
        };
    }
    public static List<Linea> getLineaByVehiculoId(int vehiculoId)
    {
        if (vehiculoId <= 0)
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

    public static List<Linea> getLineas()
    {
        LineasTableAdapter localAdapter = new LineasTableAdapter();
        LineasDS.LineasDataTable table = localAdapter.getAllLineas();

        List<Linea> list = new List<Linea>();
        foreach (var row in table)
        {
            Linea obj = getLineaFromRow(row);
            list.Add(obj);
        }
        return list;
    }

    public static List<Linea> getLineasCercanas(decimal latitudInicio,decimal latitudFin,decimal longitudInicio,decimal longitudFin)
    {
        LineasTableAdapter localAdapter = new LineasTableAdapter();
        LineasDS.LineasDataTable table = localAdapter.getLineasCercanas(latitudInicio,longitudInicio,latitudFin,longitudFin);

        List<Linea> list = new List<Linea>();
        foreach (var row in table)
        {
            Linea obj = getLineaFromRow(row);
            list.Add(obj);
        }
        return list;
    }

    public static void deleteLinea(int lineaId)
    {
        LineasTableAdapter adapter = new LineasTableAdapter();
        adapter.deleteLinea(lineaId);
    }

    public static void updateLinea(Linea obj)
    {
        LineasTableAdapter adapter = new LineasTableAdapter();
        adapter.updateLinea(obj.numeroLinea, obj.lineaId);
    }

    public static int insertLinea(Linea obj)
    {
        if (string.IsNullOrEmpty(obj.numeroLinea))
            throw new ArgumentException("El número de línea no puede ser nulo o vacio");


        int? id = null;
        LineasTableAdapter adapter = new LineasTableAdapter();
        adapter.insertLinea(obj.numeroLinea, ref id);

        if (id == null || id.Value <= 0)
            throw new Exception("La llave primaria no se generó correctamente");
        else
            return id.Value;
    }

    public static Linea getLineaById(int lineaId)
    {
        LineasTableAdapter adapter = new LineasTableAdapter();
        LineasDS.LineasDataTable table = adapter.getLineaById(lineaId);

        List<Linea> list = new List<Linea>();
        foreach (var row in table)
        {
            Linea obj = getLineaFromRow(row);
            list.Add(obj);
        }
        return list[0];
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