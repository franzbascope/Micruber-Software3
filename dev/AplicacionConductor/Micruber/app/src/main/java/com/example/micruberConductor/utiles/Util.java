package com.example.micruberConductor.utiles;

import android.app.Dialog;
import android.content.Context;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;


import com.example.micruberConductor.R;

import androidx.appcompat.widget.AppCompatButton;

public class Util {

    public static String primeraMayuscula(String texto) {
        if (texto.isEmpty()) {
            return "";
        }

        return texto.substring(0,1).toUpperCase() + texto.substring(1).toLowerCase();
    }

    public static void mostrarDialogoSinInternet(Context context) {
        final Dialog dialog = new Dialog(context);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE); // before
        dialog.setContentView(R.layout.dialog_no_internet);
        dialog.setCancelable(true);

        WindowManager.LayoutParams lp = new WindowManager.LayoutParams();
        lp.copyFrom(dialog.getWindow().getAttributes());
        lp.width = WindowManager.LayoutParams.WRAP_CONTENT;
        lp.height = WindowManager.LayoutParams.WRAP_CONTENT;

        ((AppCompatButton) dialog.findViewById(R.id.bt_close)).setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }

        });

        dialog.show();
        dialog.getWindow().setAttributes(lp);
    }

}
