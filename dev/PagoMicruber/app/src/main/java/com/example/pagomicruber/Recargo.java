package com.example.pagomicruber;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
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
import com.example.pagomicruber.utiles.Preferences;
import com.example.pagomicruber.utiles.Util;
import com.google.android.material.textfield.TextInputEditText;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;

public class Recargo extends AppCompatActivity implements Listener {

    private TextInputEditText et_correo, monto;
    private ProgressDialog progreso;
    private boolean isDialogDisplayed = false;
    private boolean isWrite = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recargo);
        et_correo = findViewById(R.id.et_correo);
        monto = findViewById(R.id.monto);
    }

    public void recargo(View view) {
        int montos = 0;
        String correo = et_correo.getText().toString().trim();
        if (correo.isEmpty()) {
            Toast.makeText(Recargo.this, "Debe ingresar su correo o usuario", Toast.LENGTH_LONG).show();
            return;
        }
        if (!monto.getText().toString().trim().isEmpty()) {
            montos = Integer.parseInt(monto.getText().toString().trim());
        }


        if (montos < 0) {
            Toast.makeText(Recargo.this, "Debe ingresar un monto mayor a 0", Toast.LENGTH_LONG).show();
            return;
        }
        recargoService(correo, montos);
    }

    public void recargoService(String correo, int monto) {
        String url = getString(R.string.url_master) + "/pagos";
        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);

            JSONObject jsonBody = new JSONObject();
            jsonBody.put("correo", correo);
            jsonBody.put("monto", monto);
            jsonBody.put("userRecargo", Preferences.getUsuario(this).getUsuarioId());

            progreso = new ProgressDialog(this);
            progreso.setIndeterminate(true);
            progreso.setTitle("Recargando...");
            progreso.setCancelable(false);
            progreso.show();

            final String mRequestBody = jsonBody.toString();

            StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {

                    if (!response.trim().isEmpty()) {
                        int estado = Integer.parseInt(response);

                        if (estado != 1) {
                            Toast.makeText(Recargo.this, "Fallo el insert", Toast.LENGTH_LONG).show();
                        }

                        progreso.dismiss();

                        finish();


                    } else {
                        Toast.makeText(Recargo.this, "Credenciales incorrectos", Toast.LENGTH_LONG).show();
                    }


                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    progreso.dismiss();

                    if (error instanceof NetworkError) {
                        Util.mostrarDialogoSinInternet(Recargo.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        Toast.makeText(Recargo.this, "Crendenciales incorrectos", Toast.LENGTH_SHORT).show();
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

    @Override
    public void onDialogDisplayed() {
        isDialogDisplayed = true;
    }

    @Override
    public void onDialogDismissed() {
        isDialogDisplayed = false;
        isWrite = false;
    }
}