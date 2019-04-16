package com.example.micruber.utiles;

import android.content.Context;
import android.content.SharedPreferences;

import com.example.micruber.Objetos.Usuario;
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

}
