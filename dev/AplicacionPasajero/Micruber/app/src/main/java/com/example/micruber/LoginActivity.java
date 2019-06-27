package com.example.micruber;


import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AutoCompleteTextView;
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

import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;

import androidx.appcompat.app.AppCompatActivity;


public class LoginActivity extends AppCompatActivity {

    private TextInputEditText et_correo, et_password;
    private ProgressDialog progreso;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        et_correo = findViewById(R.id.et_correo);
        et_password = findViewById(R.id.et_password);

        Usuario usr = Preferences.getUsuario(this);
        if(usr != null){
            goToMicros();
        }
    }

    private boolean isEmailValid(String email) {
        //TODO: Replace this with your own logic
        return email.contains("@");
    }

    private boolean isPasswordValid(String password) {
        //TODO: Replace this with your own logic
        return password.length() > 4;
    }

    public void recuperarPassword(View view){
        Intent intent = new Intent(LoginActivity.this, recuperarContrasenha.class);
        startActivity(intent);
    }

    public void registrarse(View view){
        Intent intent = new Intent(LoginActivity.this, RegistroActivity.class);
        startActivity(intent);
    }

    public void iniciarSesion(View view){
        String correo = et_correo.getText().toString().trim();
        String password = et_password.getText().toString().trim();
        if(correo.isEmpty()){
            Toast.makeText(LoginActivity.this, "Debe ingresar su correo", Toast.LENGTH_LONG).show();
            return;
        }
        if(!this.isEmailValid(correo)){
            Toast.makeText(LoginActivity.this, "Debe ingresar un correo válido", Toast.LENGTH_LONG).show();
            return;
        }
        if(password.isEmpty()){
            Toast.makeText(LoginActivity.this, "Debe ingresar una contraseña", Toast.LENGTH_LONG).show();
            return;
        }
        login(correo, password);
    }

    public void login(String correo, String password) {
        String url = getString(R.string.url_master) + "/usuarios/login";
        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);

            JSONObject jsonBody = new JSONObject();
            jsonBody.put("correo", correo);
            jsonBody.put("password", password);

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
                        //Toast.makeText(LoginActivity.this, response, Toast.LENGTH_LONG).show();

                        if(!response.trim().isEmpty()){
                            JSONObject respuesta = new JSONObject(response);
                            Usuario usuario = new Usuario();
                            usuario.setUsuarioId(respuesta.getInt("usuarioId"));
                            usuario.setNombreCompleto(respuesta.getString("nombreCompleto"));
                            usuario.setCorreo(respuesta.getString("correo"));
                            Preferences.setUsuario(LoginActivity.this, usuario);
                            progreso.dismiss();
                            goToMicros();
                        }else{
                            Toast.makeText(LoginActivity.this, "Credenciales incorrectos", Toast.LENGTH_LONG).show();
                        }

                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    progreso.dismiss();

                    if (error instanceof NetworkError) {
                        Util.mostrarDialogoSinInternet(LoginActivity.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        Toast.makeText(LoginActivity.this, "Crendenciales incorrectos", Toast.LENGTH_SHORT).show();
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

    public void goToMicros(){
        Intent intent = new Intent(LoginActivity.this, MapsActivityRuta.class);
        startActivity(intent);
        finish();
    }

    /*public void goToMapa(View view){
        Intent intent = new Intent(LoginActivity.this, MapaActivity.class);
        startActivity(intent);
        finish();
    }*/

    public void goToMapa(View view){
        Intent intent = new Intent(LoginActivity.this, mapLineaActivity.class);
        startActivity(intent);
        finish();
    }
}