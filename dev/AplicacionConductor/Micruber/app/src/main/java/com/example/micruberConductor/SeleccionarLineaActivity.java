package com.example.micruberConductor;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;

import com.android.volley.NetworkError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.ServerError;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.Volley;
import com.example.micruberConductor.Objetos.Linea;
import com.example.micruberConductor.Objetos.Vehiculo;
import com.example.micruberConductor.utiles.Preferences;
import com.example.micruberConductor.utiles.Util;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.LinkedList;

public class SeleccionarLineaActivity extends AppCompatActivity {

    private Spinner lineaSpinner;
    private ProgressDialog progreso;
    private Vehiculo currentVehiculo;
    private LinkedList<Linea> listaLineas;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_seleccionar_linea);
        lineaSpinner = (Spinner) findViewById(R.id.spinnerLineas);
        listaLineas = new LinkedList<>();
        cargarLineas();
    }

    public void guardarLinea(View view) {
        Linea objLinea = (Linea) lineaSpinner.getSelectedItem();
        Preferences.setLinea(SeleccionarLineaActivity.this, objLinea);
        Intent intent = new Intent(SeleccionarLineaActivity.this, MainActivity.class);
        startActivity(intent);
        finish();
    }

    public void cargarLineaSpinner()
    {
        ArrayAdapter<Linea> adapter =
                new ArrayAdapter<Linea>(getApplicationContext(),  android.R.layout.simple_spinner_dropdown_item, listaLineas);
        adapter.setDropDownViewResource( android.R.layout.simple_spinner_dropdown_item);
        lineaSpinner.setAdapter(adapter);
    }

    public void cargarLineas() {
        currentVehiculo = Preferences.getVehiculo(this);
        if (currentVehiculo == null) {
            Log.e("LOG_VOLLEY", "Object shared is null");
            finish();
        }
        String url = getString(R.string.url_master) + "/lineasByvehiculoId?vehiculoId="+currentVehiculo.getVehiculoId();
        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);
            progreso = new ProgressDialog(this);
            progreso.setIndeterminate(true);
            progreso.setTitle("Obteniendo Lineas...");
            progreso.setCancelable(false);
            progreso.show();

            JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(
                    Request.Method.GET,
                    url,
                    null,
                    new Response.Listener<JSONArray>()  {
                @Override
                public void onResponse(JSONArray response) {
                    try {
                        if(response.length()>0){
                            for(int i=0;i<response.length();i++){
                                JSONObject jsonLinea = response.getJSONObject(i);
                                Linea objLinea = new Linea();
                                objLinea.setLineaId((Integer) jsonLinea.get("lineaId"));
                                objLinea.setNroLinea(jsonLinea.getString("numeroLinea"));
                                listaLineas.add(objLinea);
                            }
                            cargarLineaSpinner();
                            progreso.dismiss();
                        }else{
                            Toast.makeText(SeleccionarLineaActivity.this, "No se encontraron lineas registradas", Toast.LENGTH_LONG).show();
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
                        Util.mostrarDialogoSinInternet(SeleccionarLineaActivity.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        Toast.makeText(SeleccionarLineaActivity.this, "Error al obtener lineas", Toast.LENGTH_SHORT).show();
                    }
                    Log.e("LOG_VOLLEY", error.toString());
                }
            }) {
                @Override
                public String getBodyContentType() {
                    return "application/json; charset=utf-8";
                }

            };
            requestQueue.add(jsonArrayRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
