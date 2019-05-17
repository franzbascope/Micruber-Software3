using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VentasNur.Model;
using DAL.Seguridad;
using DAL.Seguridad.UsuarioDSTableAdapters;
using System.Net.Mail;
using System.Net;
using DAL.Rutas.VehiculoDSTableAdapters;
using DAL.Rutas;

/// <summary>
/// Descripción breve de UsuarioBLL
/// </summary>
public class VehiculoBLL
{
    public VehiculoBLL()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }
    private static Vehiculo getVehiculoFromRow(VehiculoDS.VehiculoRow row)
    {
        return new Vehiculo()
        {
            vechiduloId = row.vehiculoId,
            placa = row.placa,
            capacidad = row.capacidad
        };
    }
    public static Vehiculo getVehiculoByPlaca(string placa)
    {
        if (String.IsNullOrEmpty(placa))
            throw new Exception("La placa no puede ser vacia ni nula");

        VehiculoTableAdapter localAdapter = new VehiculoTableAdapter();
        VehiculoDS.VehiculoDataTable table = localAdapter.getVehiculoByPlaca(placa);

        List<Vehiculo> list = new List<Vehiculo>();
        foreach (var row in table)
        {
            Vehiculo obj = getVehiculoFromRow(row);
            list.Add(obj);
        }
        return list[0];
    }

}