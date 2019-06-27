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
import com.example.micruber.adapter.AdaptadorLineas;
import com.example.micruber.utiles.Preferences;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

public class EscogerLinea extends AppCompatActivity {

    private Spinner lineaSpinner;
    private ProgressDialog progreso;
    private RecyclerView lineasRecyclerView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_escoger_linea);

        lineasRecyclerView = findViewById(R.id.lineasRecyclerView);
        RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(this);
        lineasRecyclerView.setLayoutManager(layoutManager);


        //lineaSpinner = (Spinner) findViewById(R.id.spinnerLineas);
        cargarLineas();
    }

    public void guardarLinea(View view) {
        Linea objLinea = (Linea) lineaSpinner.getSelectedItem();
        Preferences.setLinea(EscogerLinea.this, objLinea);
        Intent intent = new Intent(EscogerLinea.this, mapLineaActivity.class);
        startActivity(intent);
        finish();
    }

    public void cargarLineaSpinner()
    {
        /*ArrayAdapter<Linea> adapter =
                new ArrayAdapter<Linea>(getApplicationContext(),  android.R.layout.simple_spinner_dropdown_item, listaLineas);
        adapter.setDropDownViewResource( android.R.layout.simple_spinner_dropdown_item);
        lineaSpinner.setAdapter(adapter);*/
    }

    public void cargarLineas() {

        List<Linea> listaLineas = Preferences.getLineasCercanas(EscogerLinea.this);
        AdaptadorLineas adaptador = new AdaptadorLineas(this, listaLineas);
        lineasRecyclerView.setAdapter(adaptador);
        adaptador.setOnItemClickListener(new AdaptadorLineas.OnItemClickListener() {
            @Override
            public void onItemClick(View view, Linea obj) {
                Preferences.setLinea(EscogerLinea.this, obj);
                Intent intent = new Intent(EscogerLinea.this, mapLineaActivity.class);
                startActivity(intent);
            }
        });
        //cargarLineaSpinner();
    }
}
