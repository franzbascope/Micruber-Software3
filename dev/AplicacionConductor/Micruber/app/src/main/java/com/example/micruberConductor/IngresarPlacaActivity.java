package com.example.micruberConductor;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.android.volley.NetworkError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.ServerError;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.micruberConductor.Objetos.Linea;
import com.example.micruberConductor.Objetos.Vehiculo;
import com.example.micruberConductor.R;
import com.example.micruberConductor.utiles.Preferences;
import com.example.micruberConductor.utiles.Util;
import com.google.android.material.textfield.TextInputEditText;

import org.json.JSONException;
import org.json.JSONObject;

public class IngresarPlacaActivity extends AppCompatActivity {

    private TextInputEditText et_placa;
    private ProgressDialog progreso;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ingresar_placa);
        et_placa = findViewById(R.id.et_placa);
        Vehiculo objVehiculo = Preferences.getVehiculo(this);
        Linea objLinea = Preferences.getLinea(this);
        if(objVehiculo != null && objLinea!=null ){
            Intent intent = new Intent(IngresarPlacaActivity.this, MainActivity.class);
            startActivity(intent);
        }
    }
    public void goToSeleccionarLineaActivity(){
        Intent intent = new Intent(IngresarPlacaActivity.this, SeleccionarLineaActivity.class);
        startActivity(intent);
        finish();
    }

    public void on_click_btn_login(View view) {
        String placa = et_placa.getText().toString().trim();
        if(placa.isEmpty()){
            Toast.makeText(IngresarPlacaActivity.this, "Debe ingresar la placa de su vehiculo", Toast.LENGTH_LONG).show();
            return;
        }
        obtenerVehiculo(placa);
    }
    public void obtenerVehiculo(String placa) {
        String url = getString(R.string.url_master) + "/vehiculoByPlaca?placa="+placa;
        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);
            progreso = new ProgressDialog(this);
            progreso.setIndeterminate(true);
            progreso.setTitle("Obteniendo Vehiculo...");
            progreso.setCancelable(false);
            progreso.show();

            StringRequest stringRequest = new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    try {
                        if(!response.trim().isEmpty()){
                            JSONObject respuesta = new JSONObject(response);
                            Vehiculo objVehiculo = new Vehiculo();
                            objVehiculo.setCapacidad((Integer) respuesta.get("capacidad"));
                            objVehiculo.setVehiculoId((Integer) respuesta.get("vechiduloId"));
                            objVehiculo.setPlaca(respuesta.getString("placa"));
                            Preferences.setVehiculo(IngresarPlacaActivity.this, objVehiculo);
                            progreso.dismiss();
                            goToSeleccionarLineaActivity();
                        }else{
                            Toast.makeText(IngresarPlacaActivity.this, "No existe la palca ingresada", Toast.LENGTH_LONG).show();
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
                        Util.mostrarDialogoSinInternet(IngresarPlacaActivity.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        Toast.makeText(IngresarPlacaActivity.this, "No existe la placa ingresada", Toast.LENGTH_SHORT).show();
                    }
                    Log.e("LOG_VOLLEY", error.toString());
                }
            }) {
                @Override
                public String getBodyContentType() {
                    return "application/json; charset=utf-8";
                }

            };
            requestQueue.add(stringRequest);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
