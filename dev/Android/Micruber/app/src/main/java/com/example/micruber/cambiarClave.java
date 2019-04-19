package com.example.micruber;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
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

import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;

public class cambiarClave extends AppCompatActivity {
    private TextInputEditText senhaOld;
    private TextInputEditText senhaNueva;
    private TextInputEditText senhaNueva_r;
    private Usuario userx;
    private ProgressDialog progreso;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_cambiar_clave);
        //Shared empty?
        userx = Preferences.getUsuario(this);
        if (userx == null){
            Log.e("LOG_VOLLEY", "Object shared is null");
            finish();
        }
        senhaOld = findViewById(R.id.et_pin_actual);
        senhaNueva = findViewById(R.id.et_nuevo_pin);
        senhaNueva_r = findViewById(R.id.et_nuevo_pin_r);
        //url_cambSenha
    }
    //Onclick button
    public void cambiarSenha(View view){
        String cSenhaOld = senhaOld.getText().toString().trim();
        String cSenhaNew = senhaNueva.getText().toString().trim();
        String cSenhaNewr = senhaNueva_r.getText().toString().trim();

        if(cSenhaOld.isEmpty()){
            Toast.makeText(cambiarClave.this, "Debe ingresar su contraseña", Toast.LENGTH_LONG).show();
            return;
        }
        if(cSenhaNew.isEmpty() && cSenhaNew.length() < 6){
            Toast.makeText(cambiarClave.this, "Debe ingresar una contraseña, mayor que 6 caracteres", Toast.LENGTH_LONG).show();
            return;
        }
        if(cSenhaNewr.isEmpty() && cSenhaNewr.length() < 6){
            Toast.makeText(cambiarClave.this, "Debe ingresar una contraseña, mayor que 6 caracteres", Toast.LENGTH_LONG).show();
            return;
        }
        if(cSenhaNewr != cSenhaNew){
            Toast.makeText(cambiarClave.this, "Contraseñas diferentes", Toast.LENGTH_LONG).show();
            return;
        }

        changeSenha(userx.getUsuarioId(),cSenhaOld,cSenhaNew);
        //changeSenha(correo, password);
        finish();
    }
    ///Volley library
    public void changeSenha(int userId,String oldSenha, String newSenha) {
        String url = getString(R.string.url_cambSenha); //Strings configure ip for services
        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);

            JSONObject jsonBody = new JSONObject();
            //POSTMAN{
            //	"userId": 3,
            //	"oldPassword":"12345",
            //	"newPassword" :"riverplate1"
            //}
            jsonBody.put("userId", userId);
            jsonBody.put("oldPassword", oldSenha);
            jsonBody.put("newPassword", newSenha);

            progreso = new ProgressDialog(this);
            progreso.setIndeterminate(true);
            progreso.setTitle("Iniciando sesion...");
            progreso.setCancelable(false);
            progreso.show();



            final String mRequestBody = jsonBody.toString();

            StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    try {

                        JSONObject respuesta = new JSONObject(response);

                        progreso.dismiss();
                        Toast.makeText(cambiarClave.this, "Contraseña actualizada", Toast.LENGTH_LONG).show();
                        Log.e("LOG_VOLLEY", "Successful change pass");
                        finish();

                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    progreso.dismiss();

                    if (error instanceof NetworkError) {
                        Util.mostrarDialogoSinInternet(cambiarClave.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        Toast.makeText(cambiarClave.this, "Crendenciales incorrectos", Toast.LENGTH_SHORT).show();
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
                        Log.e("LOG_VOLLEY","Unsupported Encoding while trying to get the bytes of %s using %s" );
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
