using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VentasNur.Model;
using DAL.Seguridad;
using DAL.Seguridad.UsuarioDSTableAdapters;

/// <summary>
/// Descripción breve de UsuarioBLL
/// </summary>
public class UsuarioBLL
{
    public UsuarioBLL()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }
    private static Usuario GetUsuarioFromRow(UsuarioDS.UsuarioRow row)
    {
        return new Usuario()
        {
            correo = row.correo,
            usuarioId = row.usuarioId,
            nombreCompleto = row.nombre
        };
    }

    public static List<Usuario> getAllUsuarios()
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        UsuarioDS.UsuarioDataTable table = adapter.getAllUsuarios();

        List<Usuario> list = new List<Usuario>();
        foreach (var row in table)
        {
            Usuario obj = GetUsuarioFromRow(row);
            list.Add(obj);
        }
        return list;
    }


    public static Usuario getUsuarioById(int usuarioId)
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        UsuarioDS.UsuarioDataTable table = adapter.getUsuarioById(usuarioId);

        List<Usuario> list = new List<Usuario>();
        foreach (var row in table)
        {
            Usuario obj = GetUsuarioFromRow(row);
            list.Add(obj);
        }
        return list[0];
    }


    public static Usuario autenticarUsuario(string username,string password)
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        UsuarioDS.UsuarioDataTable table = adapter.autenticarUsuario(username, password);

        if (table == null || table.Rows.Count > 1)
        {
            throw new Exception("La consulta retornó un numero incorrecto de filas");
        }
        if (table.Rows.Count == 0)
            return null;
        UsuarioDS.UsuarioRow row = table[0];
        return new Usuario()
        {
            correo = row.correo,
            usuarioId = row.usuarioId,
            nombreCompleto = row.nombre
        };
    }
    public static void deleteUsuario(int usuarioId)
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        adapter.deleteUsuario(usuarioId);
    }
    public static int insertUsuario(Usuario obj)
    {
        if (string.IsNullOrEmpty(obj.nombreCompleto))
            throw new ArgumentException("El nombre no puede ser nulo o vacio");

        if (string.IsNullOrEmpty(obj.correo))
            throw new ArgumentException("El correo no puede ser nulo o vacio");


        int? id = null;
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        adapter.insertUsuario(obj.correo,obj.password,obj.nombreCompleto, ref id);

        if (id == null || id.Value <= 0)
            throw new Exception("La llave primaria no se generó correctamente");

        return id.Value;
    }

    public static void updateUsuario(Usuario obj)
    {
        UsuarioTableAdapter adapter = new UsuarioTableAdapter();
        adapter.updateUsuario(obj.correo, obj.nombreCompleto, obj.usuarioId);
    }

}