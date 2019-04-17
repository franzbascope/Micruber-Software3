package com.example.micruber;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.ServerError;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.micruber.Objetos.Usuario;
import com.example.micruber.utiles.Preferences;
import com.example.micruber.utiles.Util;
import com.google.android.material.textfield.TextInputEditText;
import com.google.android.material.textfield.TextInputLayout;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;

import androidx.appcompat.app.AppCompatActivity;

public class recuperarContrasenha extends AppCompatActivity {

    TextInputLayout correo;
    Button btnSgte;
    ProgressDialog progreso;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recuperar_contrasenha);
        correo= findViewById(R.id.correoTextInputLayout);
        btnSgte=findViewById(R.id.btn_enviarToken);

        btnSgte.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if( correo.getEditText().toString().length() == 0 )
                    correo.setError("Ingrese un correo valido por favor");
                else{
                    new AlertDialog.Builder(recuperarContrasenha.this)
                            .setTitle("Recuperacion de contraseña")
                            .setMessage("Si prosigue se le enviara un token para la recuperacion de contraseña")

                            // Specifying a listener allows you to take an action before dismissing the dialog.
                            // The dialog is automatically dismissed when a dialog button is clicked.
                            .setPositiveButton("Enviar Token", new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int which) {
                                    // Continue with delete operation
                                    String datoCorreo=correo.getEditText().getText().toString();
                                    enviarCorreo(datoCorreo);
                                    finish();

                                }
                            })

                            // A null listener allows the button to dismiss the dialog and take no further action.
                            .setNegativeButton("Cancelar", null)
                            .setIcon(android.R.drawable.ic_dialog_alert)
                            .show();

                }

            }
        });



    }
    public void enviarCorreo(String Correo) {
        String url = getString(R.string.url_validar_nueva_Contrasenha);
        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);

            JSONObject jsonBody = new JSONObject();
            jsonBody.put("correo", Correo);


            progreso = new ProgressDialog(this);
            progreso.setIndeterminate(true);
            progreso.setTitle("Enviando Correo...");
            progreso.setCancelable(false);
            progreso.show();

            final String mRequestBody = jsonBody.toString();

            StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    Toast.makeText(recuperarContrasenha.this, "Correo Enviado \n Verifique en su bandeja de spam ", Toast.LENGTH_LONG).show();

                    //progreso.dismiss();

                   // finish();

                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    progreso.dismiss();

                    if (error instanceof NetworkError) {
                        Util.mostrarDialogoSinInternet(recuperarContrasenha.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        Toast.makeText(recuperarContrasenha.this, "Email incorrecto  "+error, Toast.LENGTH_SHORT).show();
                    }

                    Log.e("LOG_VOLLEY", error.toString());
                }
            }) {
                @Override
                public String getBodyContentType() {
                    return "application/json; charset=utf-8";
                }

                @Override
                public byte[] getBody() throws AuthFailureError {
                    try {
                        return mRequestBody == null ? null : mRequestBody.getBytes("utf-8");
                    } catch (UnsupportedEncodingException uee) {
                        VolleyLog.wtf("Unsupported Encoding while trying to get the bytes of %s using %s", mRequestBody, "utf-8");
                        return null;
                    }
                }
            };
            requestQueue.add(stringRequest);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}
