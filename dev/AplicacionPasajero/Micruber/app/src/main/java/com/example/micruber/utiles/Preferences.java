package com.example.micruber.utiles;

import android.content.Context;
import android.content.SharedPreferences;

import com.example.micruber.Objetos.Linea;
import com.example.micruber.Objetos.Usuario;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.util.ArrayList;


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
    public static void setLineasCercanas(Context context, ArrayList<Linea> obj) {
        SharedPreferences preferencias2 = context.getSharedPreferences("myPref", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor2 = preferencias2.edit();
        Gson gson = new Gson();

        editor2.putString("lineas_cercanas", gson.toJson(obj));
        editor2.commit();
    }

    public static ArrayList<Linea> getLineasCercanas(Context context) {
        SharedPreferences pref = context.getSharedPreferences("myPref", context.MODE_PRIVATE);
        String objJson = pref.getString("lineas_cercanas", "");
        if (objJson.length() <= 0) {
            return null;
        } else {
            Gson gson = new Gson();
            ArrayList<Linea> obj = gson.fromJson(objJson, new TypeToken<ArrayList<Linea>>() {
            }.getType());
            return obj;
        }
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

}
