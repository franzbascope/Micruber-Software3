package com.example.micruberConductor;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.app.ActivityCompat;

import android.Manifest;
import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import com.example.micruberConductor.Objetos.Coordenadas;
import com.example.micruberConductor.Objetos.Linea;
import com.example.micruberConductor.Objetos.Vehiculo;
import com.example.micruberConductor.utiles.Preferences;
import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.karumi.dexter.Dexter;
import com.karumi.dexter.PermissionToken;
import com.karumi.dexter.listener.PermissionDeniedResponse;
import com.karumi.dexter.listener.PermissionGrantedResponse;
import com.karumi.dexter.listener.PermissionRequest;
import com.karumi.dexter.listener.single.PermissionListener;

import java.util.HashMap;
import java.util.Map;

public class MainActivity extends AppCompatActivity {

    static MainActivity instance;
    LocationRequest locationRequest;
    FusedLocationProviderClient fusedLocationProviderClient;
    FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference myRef = database.getReference("coordenadas");
    public Coordenadas objCoordenada ;
    public Vehiculo objVehiculo;
    public Linea objLinea;
    private boolean isLoggedOut = false;
    public static MainActivity getInstance() {
        return instance;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        activarReceiver();
        cargarModelos();
        Coordenadas objCoordenada= Preferences.getCoordenada(this);
        if(objCoordenada == null)
        {
            DatabaseReference newPostRef = myRef.push();
            objCoordenada = new Coordenadas();
            objCoordenada.lineaId = objLinea.getLineaId();
            objCoordenada.vehiculoId = objVehiculo.getVehiculoId();
            objCoordenada.id = newPostRef.getKey();
            Preferences.setCoordenada(this,objCoordenada);
            Map<String, Object> coordeNadaUpdate = new HashMap<>();
            coordeNadaUpdate.put(objCoordenada.id+"/vehiculoId", objCoordenada.vehiculoId);
            coordeNadaUpdate.put(objCoordenada.id+"/lineaId", objCoordenada.lineaId);
            myRef.updateChildren(coordeNadaUpdate);
        }



        instance = this;
        Dexter.withActivity(this).withPermission(Manifest.permission.ACCESS_FINE_LOCATION).withListener(new PermissionListener() {
            @Override
            public void onPermissionGranted(PermissionGrantedResponse response) {
                updateLocation();
            }

            @Override
            public void onPermissionDenied(PermissionDeniedResponse response) {
                Toast.makeText(MainActivity.this, "Enciente tu GPS", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onPermissionRationaleShouldBeShown(PermissionRequest permission, PermissionToken token) {

            }
        }).check();
    }

    private void updateLocation() {
        buildLocationRequest();
        fusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(this);
        if (ActivityCompat.checkSelfPermission(this,Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this,Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            return;
        }
        fusedLocationProviderClient.requestLocationUpdates(locationRequest,getPendingIntent());
    }

    private PendingIntent getPendingIntent() {
        Intent intent = new Intent(this,MyLocationService.class);
        intent.setAction(MyLocationService.ACTION_PROCESS_UPDATE);
        return PendingIntent.getBroadcast(this,0,intent,PendingIntent.FLAG_UPDATE_CURRENT);
    }


    private void buildLocationRequest() {
        locationRequest = new LocationRequest();
        locationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
        locationRequest.setInterval(500);
        locationRequest.setFastestInterval(100);
        locationRequest.setSmallestDisplacement(100f);
    }
    public void cargarModelos()
    {
        this.objVehiculo = Preferences.getVehiculo(this);
        this.objLinea = Preferences.getLinea(this);
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_basic, menu);
        return true;
    }
    public String getCoordenadaId()
    {
        String id= Preferences.getCoordenada(this).id;
        return id;
    }
    //    public void enviarCoordenadas(final double latitud, final double longitud)
//    {
//        MainActivity.this.runOnUiThread(new Runnable() {
//            @Override
//            public void run() {
//                String coordenadaId = getCoordenadaId();
//                Map<String, Object> coordeNadaUpdate = new HashMap<>();
//                coordeNadaUpdate.put(coordenadaId+"/latitud", latitud);
//                coordeNadaUpdate.put(coordenadaId+"/longitud", longitud);
//                myRef.updateChildren(coordeNadaUpdate);
//            }
//        });
//    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_cambiar_linea:
                desactivarReceiver();
                Preferences.deleteLinea(this);
                Intent intent = new Intent(MainActivity.this,SeleccionarLineaActivity.class);
                startActivity(intent);
                break;

            case R.id.action_logout:
                cerrarSesion();
                break;

            default:
                break;
        }

        return super.onOptionsItemSelected(item);
    }

    public void cerrarSesion(){
        desactivarReceiver();
        Preferences.deleteUsuario(this);
        Preferences.deleteLinea(this);
        Preferences.deleteCoordenada(this);
        Intent intent = new Intent(MainActivity.this, IngresarPlacaActivity.class);
        startActivity(intent);
    }
    public void desactivarReceiver()
    {
        DatabaseReference deleteRef = myRef.child(getCoordenadaId());
        deleteRef.removeValue();
        PackageManager pm  = MainActivity.this.getPackageManager();
        ComponentName componentName = new ComponentName(MainActivity.this, MyLocationService.class);
        pm.setComponentEnabledSetting(componentName,PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                PackageManager.DONT_KILL_APP);
    }
    public void activarReceiver()
    {
        PackageManager pm  = MainActivity.this.getPackageManager();
        ComponentName componentName = new ComponentName(MainActivity.this, MyLocationService.class);
        pm.setComponentEnabledSetting(componentName,PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                PackageManager.DONT_KILL_APP);
    }
}