package com.example.micruber;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.FragmentActivity;

import android.location.Location;
import android.os.Bundle;
import android.widget.Toast;

import com.example.micruber.Objetos.Coordenadas;
import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.PointOfInterest;
import com.google.firebase.database.ChildEventListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class MapaActivity extends FragmentActivity implements OnMapReadyCallback {

    private GoogleMap mMap;
    private DatabaseReference mDatabase;
    private ValueEventListener mPostListener;
    private LatLng ubicacionMicro;
    //TODO obtener la llave con el web service de Beto
    private String key = "-LfNOXUO0PERgRevrAwA";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mapa);
        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);

        mDatabase = FirebaseDatabase.getInstance().getReference("coordenadas");




    }

    @Override
    protected void onStart() {
        super.onStart();
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
        mMap = googleMap;
        mMap.setMapType(GoogleMap.MAP_TYPE_NORMAL);

        /*mDatabase.orderByChild("/" + key).addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot chat: dataSnapshot.getChildren()) {
                    mMap.clear();
                    Coordenadas coordenadas = dataSnapshot.getValue(Coordenadas.class);
                    ubicacionMicro = new LatLng(coordenadas.getLatitud(), coordenadas.getLongitud());
                    //Toast.makeText(MapaActivity.this, String.valueOf(ubicacionMicro.latitude), Toast.LENGTH_SHORT).show();
                    //mMap.addMarker(new MarkerOptions().position(ubicacionMicro).title("Linea 10"));
                    //PointOfInterest pointOfInterest = new PointOfInterest(ubicacionMicro, "linea10", "Linea 10");
                    mMap.addMarker(new MarkerOptions().position(ubicacionMicro).icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_AZURE)));
                    mMap.moveCamera(CameraUpdateFactory.newLatLng(ubicacionMicro));
                    mMap.animateCamera(CameraUpdateFactory.zoomTo(5));
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                throw databaseError.toException(); // don't ignore errors
            }
        });*/

        /*mDatabase.child("").addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                mMap.clear();
                Coordenadas coordenadas = dataSnapshot.getValue(Coordenadas.class);
                ubicacionMicro = new LatLng(coordenadas.getLatitud(), coordenadas.getLongitud());
                //Toast.makeText(MapaActivity.this, String.valueOf(ubicacionMicro.latitude), Toast.LENGTH_SHORT).show();
                //mMap.addMarker(new MarkerOptions().position(ubicacionMicro).title("Linea 10"));
                //PointOfInterest pointOfInterest = new PointOfInterest(ubicacionMicro, "linea10", "Linea 10");
                mMap.addMarker(new MarkerOptions().position(ubicacionMicro).icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_AZURE)));
                mMap.moveCamera(CameraUpdateFactory.newLatLng(ubicacionMicro));
                mMap.animateCamera(CameraUpdateFactory.zoomTo(12));
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // ...
            }
        });*/

        ValueEventListener postListener = new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                mMap.clear();
                Coordenadas coordenadas = dataSnapshot.child(key).getValue(Coordenadas.class);
                ubicacionMicro = new LatLng(coordenadas.getLatitud(), coordenadas.getLongitud());
                //Toast.makeText(MapaActivity.this, String.valueOf(ubicacionMicro.latitude), Toast.LENGTH_SHORT).show();
                //mMap.addMarker(new MarkerOptions().position(ubicacionMicro).title("Linea 10"));
                //PointOfInterest pointOfInterest = new PointOfInterest(ubicacionMicro, "linea10", "Linea 10");
                MarkerOptions marker = new MarkerOptions().position(ubicacionMicro);
                marker.icon(BitmapDescriptorFactory.fromResource(R.drawable.ic_bus));
                mMap.addMarker(marker);
                mMap.moveCamera(CameraUpdateFactory.newLatLng(ubicacionMicro));
                mMap.animateCamera(CameraUpdateFactory.zoomTo(16));
            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        };
        mDatabase.addValueEventListener(postListener);
    }
}
