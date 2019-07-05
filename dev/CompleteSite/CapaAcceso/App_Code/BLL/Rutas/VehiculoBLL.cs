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
            vehiculoId = row.vehiculoId,
            capacidad = row.capacidad,
            placa = row.placa,
            desactivado = row.IsdesactivadoNull() ? false : row.desactivado
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

    public static List<Vehiculo> getAllVehiculos()
    {
        VehiculoTableAdapter adapter = new VehiculoTableAdapter();
        VehiculoDS.VehiculoDataTable table = adapter.getAllVehiculos();

        List<Vehiculo> list = new List<Vehiculo>();
        foreach (var row in table)
        {
            Vehiculo obj = getVehiculoFromRow(row);
            list.Add(obj);
        }
        return list;
    }
    public static int insertVehiculo(Vehiculo obj)
    {
        if (string.IsNullOrEmpty(obj.placa))
            throw new ArgumentException("La placa no puede ser nulo o vacio");



        int? id = null;
        VehiculoTableAdapter adapter = new VehiculoTableAdapter();
        adapter.InsertVehiculo(obj.capacidad, obj.placa, ref id);

        if (id == null || id.Value <= 0)
            throw new Exception("La llave primaria no se generó correctamente");


        return id.Value;
    }
    public static void updateVehiculo(Vehiculo obj)
    {
        VehiculoTableAdapter adapter = new VehiculoTableAdapter();
        try
        {
            adapter.UpdateVehiculo(obj.capacidad, obj.placa, obj.vehiculoId);
        }
        catch (Exception ex)
        {
            Console.WriteLine("error al updateVehiculo" + ex);
            return;
        }


    }

    public static Vehiculo getVehiculoById(int vehiculoId)
    {
        VehiculoTableAdapter adapter = new VehiculoTableAdapter();
        VehiculoDS.VehiculoDataTable table = adapter.getVehiculoById(vehiculoId);

        List<Vehiculo> list = new List<Vehiculo>();
        foreach (var row in table)
        {
            Vehiculo obj = getVehiculoFromRow(row);
            list.Add(obj);
        }
        return list[0];
    }

    public static void deleteVehiculo(int vehiculoId)
    {
        VehiculoTableAdapter adapter = new VehiculoTableAdapter();
        adapter.DeleteVehiculo(vehiculoId);
    }

    public static int insertLineaVehiculo(int lineaId, int vehiculoId)
    {
        if (lineaId <= 0)
            throw new ArgumentException("La lineaId no puede ser <=0");

        if (vehiculoId <= 0)
            throw new ArgumentException("la rutaId no puede ser nulo o vacio");


        int? id = null;
        VehiculoTableAdapter adapter = new VehiculoTableAdapter();
        adapter.InsertLineaVehiculo(lineaId, vehiculoId, ref id);

        if (id == null || id.Value <= 0)
            throw new Exception("No se ingreso correctamente");

        return id.Value;
    }
}