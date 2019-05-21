package com.example.micruberConductor.utiles;

import android.content.Context;
import android.content.SharedPreferences;

import com.example.micruberConductor.Objetos.Coordenadas;
import com.example.micruberConductor.Objetos.Linea;
import com.example.micruberConductor.Objetos.Usuario;
import com.example.micruberConductor.Objetos.Vehiculo;
import com.google.gson.Gson;


public class Preferences {

    public static void setUsuario(Context context, Usuario obj) {
        SharedPreferences preferencias2 = context.getSharedPreferences("myPref", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor2 = preferencias2.edit();
        Gson gson = new Gson();

        editor2.putString("usuario_logeado", gson.toJson(obj));
        editor2.commit();
    }

    public static Usuario getUsuario(Context context) {
        SharedPreferences pref = context.getSharedPreferences("myPref", context.MODE_PRIVATE);
        String objJson = pref.getString("usuario_logeado", "");
        if (objJson.length() <= 0) {
            return null;
        } else {
            Gson gson = new Gson();
            Usuario obj = (Usuario) gson.fromJson(objJson, Usuario.class);
            return obj;
        }
    }

    public static void deleteUsuario(Context context) {
        SharedPreferences preferencias2 = context.getSharedPreferences("myPref", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor2 = preferencias2.edit();
        Gson gson = new Gson();

        editor2.putString("usuario_logeado", "");
        editor2.commit();
    }

    public static void setVehiculo(Context context, Vehiculo obj) {
        SharedPreferences preferencias2 = context.getSharedPreferences("myPref", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor2 = preferencias2.edit();
        Gson gson = new Gson();

        editor2.putString("current_vehiculo", gson.toJson(obj));
        editor2.commit();
    }

    public static Vehiculo getVehiculo(Context context) {
        SharedPreferences pref = context.getSharedPreferences("myPref", context.MODE_PRIVATE);
        String objJson = pref.getString("current_vehiculo", "");
        if (objJson.length() <= 0) {
            return null;
        } else {
            Gson gson = new Gson();
            Vehiculo obj = (Vehiculo) gson.fromJson(objJson, Vehiculo.class);
            return obj;
        }
    }

    public static void deleteVehiculo(Context context) {
        SharedPreferences preferencias2 = context.getSharedPreferences("myPref", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor2 = preferencias2.edit();
        Gson gson = new Gson();

        editor2.putString("current_vehiculo", "");
        editor2.commit();
    }
    public static void setLinea(Context context, Linea objLinea) {
        SharedPreferences preferencias = context.getSharedPreferences("myPref", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor2 = preferencias.edit();
        Gson gson = new Gson();
        editor2.putString("current_linea", gson.toJson(objLinea));
        editor2.commit();
    }

    public static Linea getLinea(Context context) {
        SharedPreferences pref = context.getSharedPreferences("myPref", context.MODE_PRIVATE);
        String objJson = pref.getString("current_linea", "");
        if (objJson.length() <= 0) {
            return null;
        } else {
            Gson gson = new Gson();
            Linea obj = (Linea) gson.fromJson(objJson, Linea.class);
            return obj;
        }
    }

    public static void deleteLinea(Context context) {
        SharedPreferences preferencias2 = context.getSharedPreferences("myPref", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor2 = preferencias2.edit();
        Gson gson = new Gson();

        editor2.putString("current_linea", "");
        editor2.commit();
    }
    public static void setCoordenada(Context context, Coordenadas objCoordenada) {
        SharedPreferences preferencias = context.getSharedPreferences("myPref", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor2 = preferencias.edit();
        Gson gson = new Gson();
        editor2.putString("current_coordenada", gson.toJson(objCoordenada));
        editor2.commit();
    }

    public static Coordenadas getCoordenada(Context context) {
        SharedPreferences pref = context.getSharedPreferences("myPref", context.MODE_PRIVATE);
        String objJson = pref.getString("current_coordenada", "");
        if (objJson.length() <= 0) {
            return null;
        } else {
            Gson gson = new Gson();
            Coordenadas obj = (Coordenadas) gson.fromJson(objJson, Coordenadas.class);
            return obj;
        }
    }

    public static void deleteCoordenada(Context context) {
        SharedPreferences preferencias2 = context.getSharedPreferences("myPref", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor2 = preferencias2.edit();
        Gson gson = new Gson();

        editor2.putString("current_coordenada", "");
        editor2.commit();
    }

}
