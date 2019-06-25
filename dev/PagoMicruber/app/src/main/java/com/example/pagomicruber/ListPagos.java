package com.example.pagomicruber;

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
import com.example.pagomicruber.R;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;

import com.example.pagomicruber.adapter.PagoAdapter;
import com.example.pagomicruber.model.PagoView;
import com.example.pagomicruber.utiles.Preferences;
import com.example.pagomicruber.utiles.Util;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import android.util.Log;
import android.view.View;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

public class ListPagos extends AppCompatActivity {

    private ListView lvItems;
    private PagoAdapter adapPago;
    private ProgressDialog progreso;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list_pagos);

        lvItems = (ListView) findViewById(R.id.lvItems);
        //Lista de pagos voley

        listarPagos();



        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                goPago();
            }
        });
    }

    @Override
    protected void onRestart() {
        super.onRestart();
        listarPagos();
    }

    public void goPago() {
        Intent intent = new Intent(ListPagos.this, Recargo.class);
        startActivity(intent);
    }

    public void listarPagos() {
        Usuario usuario = Preferences.getUsuario(this);
        final ArrayList<PagoView> listaPago = new ArrayList<>();
        String url = getString(R.string.url_master) + "/obtenerPagos";
        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);

            JSONObject jsonBody = new JSONObject();
            jsonBody.put("usuarioId", usuario.getUsuarioId());


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

                        if (!response.trim().isEmpty()) {


                            JSONArray jsonarray = new JSONArray(response);
                            for (int i = 0; i < jsonarray.length(); i++) {
                                JSONObject jsonobject = jsonarray.getJSONObject(i);
                                listaPago.add(new PagoView(jsonobject.getInt("monto"), jsonobject.getString("correo")));
                            }

                            progreso.dismiss();

                            adapPago = new PagoAdapter(listaPago, ListPagos.this);

                            lvItems.setAdapter(adapPago);


                        } else {
                            Toast.makeText(ListPagos.this, "Credenciales incorrectos", Toast.LENGTH_LONG).show();
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
                        Util.mostrarDialogoSinInternet(ListPagos.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        Toast.makeText(ListPagos.this, "Crendenciales incorrectos", Toast.LENGTH_SHORT).show();
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
