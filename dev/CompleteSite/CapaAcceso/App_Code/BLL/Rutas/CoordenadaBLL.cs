using DAL.Rutas;
using DAL.Rutas.CoordenadasDSTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VentasNur.Model;

public class CoordenadaBLL
{
    public CoordenadaBLL()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    private static Coordenada getCoordenadaFromRow(CoordenadasDS.CoordenadasRow row)
    {
        return new Coordenada()
        {
            lineaId = row.lineaId,
            coordenadaId = row.coodenadaId,
            latitud = row.latitud,
            longitud = row.longitud
        };
    }

    public static List<Coordenada> getCoordenadasByLineaId(int lineaId)
    {
        CoordenadasTableAdapter adapter = new CoordenadasTableAdapter();
        CoordenadasDS.CoordenadasDataTable table = adapter.getCoordenadasByLineaId(lineaId);
        List<Coordenada> list = new List<Coordenada>();
        foreach (var row in table)
        {
            Coordenada obj = getCoordenadaFromRow(row);
            list.Add(obj);
        }
        return list;
    }

    public static int insertCoordenada(Coordenada obj)
    {
        if (obj.lineaId <= 0)
            throw new ArgumentException("El número de línea no puede ser nulo o vacio");


        int? id = null;
        CoordenadasTableAdapter adapter = new CoordenadasTableAdapter();
        adapter.insertCoordenada(obj.lineaId, obj.latitud, obj.longitud, ref id);

        if (id == null || id.Value <= 0)
            throw new Exception("La llave primaria no se generó correctamente");
        else
            return id.Value;
    }

    public static void deleteCoordenadasByLineaId(int lineaId)
    {
        CoordenadasTableAdapter adapter = new CoordenadasTableAdapter();
        adapter.deleteCoordenadasByLineaId(lineaId);
    }

}
