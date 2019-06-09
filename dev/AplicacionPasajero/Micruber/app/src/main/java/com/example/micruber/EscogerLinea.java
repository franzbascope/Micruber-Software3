package com.example.micruber;

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
import com.example.micruber.Objetos.Linea;
import com.example.micruber.utiles.Preferences;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.LinkedList;

import androidx.appcompat.app.AppCompatActivity;

public class EscogerLinea extends AppCompatActivity {

    private Spinner lineaSpinner;
    private ProgressDialog progreso;
    private ArrayList<Linea> listaLineas;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_escoger_linea);
        lineaSpinner = (Spinner) findViewById(R.id.spinnerLineas);
        listaLineas = new ArrayList<>();
        cargarLineas();
    }

    public void guardarLinea(View view) {
        Linea objLinea = (Linea) lineaSpinner.getSelectedItem();
        Preferences.setLinea(EscogerLinea.this, objLinea);
        Intent intent = new Intent(EscogerLinea.this, MapaActivity.class);
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
        listaLineas = Preferences.getLineasCercanas(EscogerLinea.this);
        cargarLineaSpinner();
    }
}
