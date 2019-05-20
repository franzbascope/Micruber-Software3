package com.example.micruberConductor;

import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.os.IBinder;
import android.widget.Toast;

import com.example.micruberConductor.Objetos.Coordenadas;
import com.example.micruberConductor.utiles.Preferences;
import com.google.android.gms.location.LocationResult;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.HashMap;
import java.util.Map;

public class MyLocationService extends BroadcastReceiver {

    FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference myRef = database.getReference("coordenadas");
    public static final String ACTION_PROCESS_UPDATE = "com.example.micruberConductor.UPDATE_LOCATION";
    @Override
    public void onReceive(Context context, Intent intent) {
        Coordenadas objCoordenada = Preferences.getCoordenada(context);

        final String action = intent.getAction();
        if (ACTION_PROCESS_UPDATE.equals(action))
        {
            LocationResult result = LocationResult.extractResult(intent);
            if(result != null)
            {
                Location location = result.getLastLocation();

                try {
                    Map<String, Object> coordeNadaUpdate = new HashMap<>();
                    coordeNadaUpdate.put(objCoordenada.id+"/latitud", location.getLatitude());
                    coordeNadaUpdate.put(objCoordenada.id+"/longitud", location.getLongitude());
                    myRef.updateChildren(coordeNadaUpdate);
//                    MainActivity.getInstance().enviarCoordenadas(location.getLatitude(),location.getLongitude() );

                }catch (Exception ex)
                {
                    Toast.makeText(context,"error", Toast.LENGTH_SHORT).show();
                }
            }
        }
    }


}
