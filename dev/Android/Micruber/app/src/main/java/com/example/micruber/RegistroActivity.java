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
import java.util.regex.Pattern;

public class RegistroActivity extends AppCompatActivity {

    private TextInputEditText et_nombre, et_correo, et_password;
    private ProgressDialog progreso;
    private static final Pattern emailPattern = Pattern.compile("^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$");
    private static final Pattern passwordPattern = Pattern.compile("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{4,15}$");
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registro);

        et_nombre = findViewById(R.id.et_nombre);
        et_correo = findViewById(R.id.et_correo);
        et_password = findViewById(R.id.et_password);

    }

    private boolean isEmailValid(String email) {
        //TODO: Replace this with your own logic
        return email.contains("@");
    }

    public void registrarse(View view){
        String nombreCompleto = et_nombre.getText().toString().trim();
        String correo = et_correo.getText().toString().trim();
        if(!emailPattern.matcher(correo).matches())
        {
            Toast.makeText(RegistroActivity.this, "Ingrese un formato de mail correcto", Toast.LENGTH_SHORT).show();
            return;
        }
        String password = et_password.getText().toString().trim();

        if(!passwordPattern.matcher(password).matches())
        {
            Toast.makeText(RegistroActivity.this, "La contraseña debe tener al menos una letra mayuscula,un numero y minimo 6 caratcters", Toast.LENGTH_LONG).show();
            return;
        }
        if(nombreCompleto.isEmpty())
        {
            Toast.makeText(RegistroActivity.this, "El nombre no puede ser vacio", Toast.LENGTH_SHORT).show();
            return;
        }
        registrarUsuario(nombreCompleto, correo, password);

    }

    public void registrarUsuario(String nombreCompleto, String correo, String password) {
        String url = getString(R.string.url_master) + "/usuarios";
        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);

            JSONObject jsonBody = new JSONObject();
            jsonBody.put("nombreCompleto", nombreCompleto);
            jsonBody.put("correo", correo);
            jsonBody.put("password", password);

            progreso = new ProgressDialog(this);
            progreso.setIndeterminate(true);
            progreso.setTitle("Enviando datos...");
            progreso.setCancelable(false);
            progreso.show();

            final String mRequestBody = jsonBody.toString();

            StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    try {
                        JSONObject respuesta = new JSONObject(response);

                        if(respuesta.getInt("usuarioId") > 0){
                            progreso.dismiss();
                            Toast.makeText(RegistroActivity.this, "Por favor confirme su correo", Toast.LENGTH_LONG).show();
                            Intent intent = new Intent(RegistroActivity.this, LoginActivity.class);
                            startActivity(intent);
                            finish();
                        }else{
                            Toast.makeText(RegistroActivity.this, "Hubo un problema al crear su cuenta", Toast.LENGTH_LONG).show();
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
                        Util.mostrarDialogoSinInternet(RegistroActivity.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        //TODO Verificar el servicio de creacion de usuario, tarda mucho y da error en el servidor
                        //Toast.makeText(RegistroActivity.this, error.getLocalizedMessage(), Toast.LENGTH_SHORT).show();
                        Toast.makeText(RegistroActivity.this, "Por favor confirme su correo", Toast.LENGTH_LONG).show();
                        //TODO Al corregir el servicio, borrar el cambio de pantalla y avisar que hubo error
                        Intent intent = new Intent(RegistroActivity.this, LoginActivity.class);
                        startActivity(intent);
                        finish();
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
