package com.example.micruber;

import android.Manifest;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import androidx.core.app.ActivityCompat;
import androidx.fragment.app.FragmentActivity;

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
import com.example.micruber.Objetos.Coordenadas;
import com.example.micruber.Objetos.Linea;
import com.example.micruber.utiles.Preferences;
import com.example.micruber.utiles.Util;
import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.Polyline;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

public class MapsActivityRuta extends FragmentActivity implements OnMapReadyCallback {
    private ProgressDialog progreso;

    private GoogleMap mMap, mapCU;
    private static final int Request_CODE = 101;
    double latitude, longitude, longiAmandar, latiAmandar;
    LatLng miPosicion, dondeVoy;
    private Polyline currentPolyline;
    Marker dondequieroir = null;
    Location currentLocation;
    Button btnCalcular;
    FusedLocationProviderClient fusedLocationProviderClient;
    List<Coordenadas> coordenadasMandar=new ArrayList<>();
    Coordenadas cordOrigen, cordDestino;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_maps_ruta);

        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);
        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        btnCalcular = findViewById(R.id.btnCalcular);

        btnCalcular.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (dondequieroir != null) {
                    getLinea();

                } else {
                    Toast.makeText(MapsActivityRuta.this, "Seleccione a donde quiere ir", Toast.LENGTH_LONG).show();
                }
            }
        });


    }


    /**
     * Manipulates the map once available.
     * This callback is triggered when the map is ready to be used.
     * This is where we can add markers or lines, add listeners or move the camera. In this case,
     * we just add a marker near Sydney, Australia.
     * If Google Play services is not installed on the device, the user will be prompted to install
     * it inside the SupportMapFragment. This method will only be triggered once the user has
     * installed Google Play services and returned to the app.
     */
    @Override
    public void onMapReady(GoogleMap googleMap) {
        fusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(MapsActivityRuta.this);

        mMap = googleMap;
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    Activity#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for Activity#requestPermissions for more details.
            return;
        }
        mMap.setMyLocationEnabled(true);


        Task<Location> task = fusedLocationProviderClient.getLastLocation();
        task.addOnSuccessListener(new OnSuccessListener<Location>() {
            @Override
            public void onSuccess(Location location) {
                if (location != null) {
                    currentLocation = location;
                    longitude = location.getLongitude();
                    latitude = location.getLatitude();
                    miPosicion = new LatLng(latitude, longitude);
                    mMap.addMarker(new MarkerOptions().position(miPosicion).title("Yo"));
                    mMap.moveCamera(CameraUpdateFactory.newLatLng(miPosicion));


                }
            }
        });
        mMap.setOnMapLongClickListener(new GoogleMap.OnMapLongClickListener() {
            @Override
            public void onMapLongClick(LatLng latLng) {

                if (dondequieroir != null) {
                    dondequieroir.remove();
                    dondequieroir = null;
                }
                if (dondequieroir == null) {
                    dondequieroir = mMap.addMarker(new MarkerOptions().position(latLng).icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_GREEN)));
                }
                // if (dondequieroir.position(latLng) != null)

                longiAmandar = latLng.longitude;
                latiAmandar = latLng.latitude;


                // mMap.addMarker(dondequieroir);
                dondeVoy = new LatLng(latiAmandar, longiAmandar);

                // ... get a map.
                // Add a thin red line from London to New York.
                /*Polyline line = mMap.addPolyline(new PolylineOptions()
                        .add(new LatLng(latitude, longitude), new LatLng(latiAmandar, longiAmandar))
                        .width(5)
                        .color(Color.RED));*/


            }
        });
        // Add a marker in Sydney and move the camera
        // LatLng sydney = new LatLng(-34, 151);
        // mMap.addMarker(new MarkerOptions().position(sydney).title("Marker in Sydney"));
        //  mMap.moveCamera(CameraUpdateFactory.newLatLng(sydney));
    }
    public void getLinea() {
        String url = getString(R.string.url_master) + "/ruta";
        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);

            JSONObject jsonBody = new JSONObject();
            jsonBody.put("latitud", latitude);
            jsonBody.put("longitud", longitude);
            jsonBody.put("latitudFin", latiAmandar);
            jsonBody.put("longitudFin", longiAmandar);

            progreso = new ProgressDialog(this);
            progreso.setIndeterminate(true);
            progreso.setTitle("Consiguiendo Linea...");
            progreso.setCancelable(false);
            progreso.show();



            final String mRequestBody = jsonBody.toString();

            StringRequest stringRequest = new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    try {
                        //Toast.makeText(LoginActivity.this, response, Toast.LENGTH_LONG).show();

                        if(!response.trim().isEmpty()){
                            JSONArray jsonArray = new JSONArray(response);
                            ArrayList<Linea> lineas = new ArrayList<>();
                            for (int i = 0; i < jsonArray.length(); i++)
                            {
                                try {
                                    JSONObject jsonObjectHijo = jsonArray.getJSONObject(i);
                                    Linea lin = new Linea();
                                    lin.setLineaId(jsonObjectHijo.getInt("lineaId"));
                                    lin.setNumeroLinea(jsonObjectHijo.getString("numeroLinea"));
                                    lineas.add(lin);
                                } catch (JSONException e) {
                                    Log.e("Parser JSON", e.toString());
                                }
                            }
                            // startActivity(intent2);
                            Preferences.setLineasCercanas(MapsActivityRuta.this, lineas);
                            progreso.dismiss();
                            Intent intent2=new Intent(MapsActivityRuta.this,EscogerLinea.class);
                            //Toast.makeText(MapsActivityRuta.this, lin.getLineaId()+"..."+lin.getNumeroLinea(), Toast.LENGTH_LONG).show();
                            startActivity(intent2);
                            finish();


                        }else{
                            Toast.makeText(MapsActivityRuta.this, "Algo paso", Toast.LENGTH_LONG).show();
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
                        Util.mostrarDialogoSinInternet(MapsActivityRuta.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        Toast.makeText(MapsActivityRuta.this, "Crendenciales incorrectos", Toast.LENGTH_SHORT).show();
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
   /* public void getLinea() {
        String url = getString(R.string.url_master) + "/ruta";
        RequestQueue requestQueue = Volley.newRequestQueue(this);
        List<Coordenadas> coordenadasCargar=new ArrayList<>();

        cordOrigen=new Coordenadas(latitude,longitude);
        cordDestino=new Coordenadas(latiAmandar,longiAmandar);
        coordenadasMandar.add(cordOrigen);
        coordenadasMandar.add(cordDestino);

        JSONObject obj=new JSONObject();



        for(int i=0;i<coordenadasMandar.size();i++){
            try {


                obj.put("latitud",coordenadasMandar.get(i).getLatitud());
                obj.put("longitud",coordenadasMandar.get(i).getLongitud());
            } catch (JSONException e) {
                e.printStackTrace();
            }

        }

        progreso = new ProgressDialog(this);
        progreso.setIndeterminate(true);
        progreso.setTitle("Consiguiendo micro...");
        progreso.setCancelable(false);
        progreso.show();


        final String mRequestBody = obj.toString();

        StringRequest jobReq = new StringRequest(Request.Method.POST, url,new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        try {
                            JSONArray arregloRespuesta = new JSONArray(response);
                            Linea lin = new Linea();
                            for (int i = 0; i < arregloRespuesta.length(); i++) {
                                try {
                                    JSONObject jsonObjectHijo = arregloRespuesta.getJSONObject(i);
                                    lin.setLineaId(jsonObjectHijo.getInt("lineaId"));
                                    lin.setNumeroLinea(jsonObjectHijo.getString("numeroLinea"));

                                } catch (JSONException e) {
                                    Log.e("Parser JSON", e.toString());
                                }

                                Toast.makeText(MapsActivityRuta.this, lin.getLineaId() + "  " + lin.getNumeroLinea(), Toast.LENGTH_LONG).show();
                            }

                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }

                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        progreso.dismiss();

                        if (error instanceof NetworkError) {
                            Util.mostrarDialogoSinInternet(MapsActivityRuta.this);
                        } else if (error instanceof TimeoutError) {

                        } else if (error instanceof ServerError) {
                            Toast.makeText(MapsActivityRuta.this, "Algo salio mal", Toast.LENGTH_SHORT).show();
                        }
                        Log.e("LOG_VOLLEY", error.toString());
                    }
                })
                ;
/*
        StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                try {
                        JSONArray arregloRespuesta = new JSONArray(response);
                        Linea lin = new Linea();
                        for (int i = 0; i < arregloRespuesta.length(); i++) {
                            try {
                                JSONObject jsonObjectHijo = arregloRespuesta.getJSONObject(i);
                                lin.setLineaId(jsonObjectHijo.getInt("lineaId"));
                                lin.setNumeroLinea(jsonObjectHijo.getString("numeroLinea"));

                            } catch (JSONException e) {
                                Log.e("Parser JSON", e.toString());
                            }

                            Toast.makeText(MapsActivityRuta.this, lin.getLineaId() + "  " + lin.getNumeroLinea(), Toast.LENGTH_LONG).show();
                        }

                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }


        }
                , new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                progreso.dismiss();

                if (error instanceof NetworkError) {
                    Util.mostrarDialogoSinInternet(MapsActivityRuta.this);
                } else if (error instanceof TimeoutError) {

                } else if (error instanceof ServerError) {
                    Toast.makeText(MapsActivityRuta.this, "Algo salio mal", Toast.LENGTH_SHORT).show();
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
        requestQueue.add(jobReq);
    }

*/
}
