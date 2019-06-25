package com.example.micruber;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.drawable.BitmapDrawable;
import android.location.Location;
import android.os.Bundle;
import android.util.Log;
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
import com.example.micruber.Objetos.Coordenadas;
import com.example.micruber.utiles.Preferences;
import com.example.micruber.utiles.Util;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapView;
import com.google.android.gms.maps.MapsInitializer;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.CameraPosition;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.LatLngBounds;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.PolylineOptions;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentActivity;


public class mapLineaActivity extends AppCompatActivity{

    MapView mMapView;
    private PolylineOptions opts;
    private GoogleMap googleMap;
    private int id_carrera;
    private JSONArray carrera;
    private ProgressDialog progreso;


    private DatabaseReference mDatabase;
    private LatLng ubicacionMicro;
    //TODO obtener la llave con el web service de Beto
    private String key = "-LiBzlK5fU2CmWn8Rubo";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_map_linea);

        mDatabase = FirebaseDatabase.getInstance().getReference("coordenadas");

        /*JSONObject trama = new JSONObject();
        try {
            trama.put("lat", -17.823733);
            trama.put("lng", -63.143949);
        } catch (JSONException ex) {
            ex.printStackTrace();
        }


        JSONObject trama2 = new JSONObject();
        try {
            trama2.put("lat", -17.819595);
            trama2.put("lng", -63.147648);
        } catch (JSONException ex) {
            ex.printStackTrace();
        }

        JSONObject trama3 = new JSONObject();
        try {
            trama3.put("lat", -17.817858);
            trama3.put("lng", -63.150332);
        } catch (JSONException ex) {
            ex.printStackTrace();
        }


        JSONArray tramas = new JSONArray();
        tramas.put(trama);
        tramas.put(trama2);
        tramas.put(trama3);

        JSONObject tramasObj = new JSONObject();
        try {
            tramasObj.put("recorrido", tramas);
        } catch (JSONException e) {
            e.printStackTrace();
        }*/

        drawRoute("", savedInstanceState, this.getApplicationContext());
    }

    public void drawRoute(String correo, final Bundle savedInstanceState, final Context contexto) {
        String url = getString(R.string.url_master) + "/drawRoute";

        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);
            //Pasando parametros
            JSONObject jsonBody = new JSONObject();
            jsonBody.put("rutaId", 3);
            ////////////
            url += "?id=" + Preferences.getLinea(this).getLineaId(); //Preferences.getLinea(this);

            final String mRequestBody = jsonBody.toString();

            StringRequest stringRequest = new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    try {
                        JSONArray arr = new JSONArray(response);
                        //JSONObject respuesta = new JSONObject(response);
                        carrera = arr;
                        mMapView = findViewById(R.id.mapviewdetalle);
                        mMapView.onCreate(savedInstanceState);
                        mMapView.onResume();
                        MapsInitializer.initialize(contexto);
                        try {
                            mMapView.getMapAsync(new OnMapReadyCallback() {
                                //JSONArray arr = carrera.getJSONArray("recorrido");
                                JSONObject obj = carrera.getJSONObject(0);

                                @Override
                                public void onMapReady(GoogleMap mMap) {
                                    googleMap = mMap;
                                    CameraPosition cameraPosition = null;                   // Creates a CameraPosition from the builder
                                    try {
                                        cameraPosition = new CameraPosition.Builder()
                                                .target(new LatLng(obj.getDouble("latitud"), obj.getDouble("longitud")))      // Sets the center of the map to Mountain View
                                                .zoom(17)                   // Sets the zoom
                                                .build();
                                    } catch (JSONException e) {
                                        e.printStackTrace();
                                    }
                                    googleMap.animateCamera(CameraUpdateFactory.newCameraPosition(cameraPosition));
                                    if (carrera != null) {
                                        try {
                                            ArrayList<LatLng> points = new ArrayList<>();
                                            //JSONArray arr = carrera.getJSONArray("recorrido");
                                            JSONObject obj;
                                            //JSONObject obj2;
                                            LatLng latlng1;
                                            Location location1;
                                            //Location location2;
                                            double dist = 0;
                                            BitmapDrawable bitmapdraw = (BitmapDrawable) getResources().getDrawable(R.drawable.ic_action_name);
                                            Bitmap b = bitmapdraw.getBitmap();
                                            Bitmap smallMarker = Bitmap.createScaledBitmap(b, 10, 10, false);
                                            for (int i = 0; i < carrera.length(); i++) {
                                                obj = carrera.getJSONObject(i);
                                                //obj2 = arr.getJSONObject(i + 1);
                                                location1 = new Location("a");
                                                //location2 = new Location("b");
                                                location1.setLatitude(obj.getDouble("latitud"));
                                                location1.setLongitude(obj.getDouble("longitud"));
                                                /*location2.setLatitude(obj2.getDouble("lat"));
                                                location2.setLongitude(obj2.getDouble("lng"));*/

                                                //dist += location1.distanceTo(location2);
                                                if (i < 1) {
                                                    latlng1 = new LatLng(obj.getDouble("latitud"), obj.getDouble("longitud"));
                                                    googleMap.addMarker(new MarkerOptions()
                                                            .position(latlng1)
                                                            .title("Micruber")
                                                            .icon(BitmapDescriptorFactory.fromBitmap(smallMarker))
                                                    );
                                                    points.add(latlng1);

                                                } else {
                                                    latlng1 = new LatLng(obj.getDouble("latitud"), obj.getDouble("longitud"));
                                                    points.add(latlng1);
                                                }

                                            }

                                            if (points.size() > 0) {
                                                opts = new PolylineOptions().addAll(points).color(Color.BLUE).width(8);
                                                mMap.addPolyline(opts);
                                            }
                                            LatLngBounds.Builder builder = new LatLngBounds.Builder();
                                            builder.include(points.get(0));
                                            builder.include(points.get(points.size() - 1));
                                            LatLngBounds bounds = builder.build();

                                            seguimiento();


                                        } catch (JSONException e) {
                                            e.printStackTrace();
                                        }
                                    }

                                }
                            });
                        } catch (JSONException e) {
                            e.printStackTrace();
                        } catch (Resources.NotFoundException e) {
                            e.printStackTrace();
                        }

                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {

                    if (error instanceof NetworkError) {
                        Util.mostrarDialogoSinInternet(mapLineaActivity.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        Toast.makeText(mapLineaActivity.this, "ERROR CARGAR MAPA", Toast.LENGTH_SHORT).show();
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

    private void seguimiento(){
        ValueEventListener postListener = new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                googleMap.clear();
                googleMap.addPolyline(opts);
                Coordenadas coordenadas = dataSnapshot.child(key).getValue(Coordenadas.class);
                if(coordenadas != null){
                    ubicacionMicro = new LatLng(coordenadas.getLatitud(), coordenadas.getLongitud());
                    //Toast.makeText(MapaActivity.this, String.valueOf(ubicacionMicro.latitude), Toast.LENGTH_SHORT).show();
                    //mMap.addMarker(new MarkerOptions().position(ubicacionMicro).title("Linea 10"));
                    //PointOfInterest pointOfInterest = new PointOfInterest(ubicacionMicro, "linea10", "Linea 10");
                    MarkerOptions marker = new MarkerOptions().position(ubicacionMicro);
                    marker.icon(BitmapDescriptorFactory.fromResource(R.drawable.ic_bus));
                    googleMap.addMarker(marker);
                    googleMap.moveCamera(CameraUpdateFactory.newLatLng(ubicacionMicro));
                    googleMap.animateCamera(CameraUpdateFactory.zoomTo(16));
                }else{
                    googleMap.clear();
                    googleMap.addPolyline(opts);
                    Toast.makeText(mapLineaActivity.this, "Su micro ha terminado el servicio", Toast.LENGTH_SHORT).show();
                }
            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        };
        mDatabase.addValueEventListener(postListener);
    }

}
