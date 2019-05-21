package com.example.micruber;

import android.content.Intent;
import android.os.Bundle;

import com.example.micruber.utiles.Preferences;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Toast;

public class MicrosActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_micros);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_basic, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_cambiar_clave:
                Intent intent = new Intent(MicrosActivity.this, cambiarClave.class);
                startActivity(intent);
                break;

            case R.id.action_logout:
                cerrarSesion();
                break;
            case R.id.action_verRuta:
                Intent intentRuta = new Intent(MicrosActivity.this, MapsActivityRuta.class);
                startActivity(intentRuta);
                break;

            default:
                break;
        }

        return super.onOptionsItemSelected(item);
    }

    public void cerrarSesion() {
        Preferences.deleteUsuario(this);
        Intent intent = new Intent(MicrosActivity.this, LoginActivity.class);
        startActivity(intent);
        finish();
    }

}
