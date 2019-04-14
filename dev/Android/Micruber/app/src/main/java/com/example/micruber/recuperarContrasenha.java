package com.example.micruber;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.google.android.material.textfield.TextInputEditText;
import com.google.android.material.textfield.TextInputLayout;

import androidx.appcompat.app.AppCompatActivity;

public class recuperarContrasenha extends AppCompatActivity {

    TextInputLayout correo;
    Button btnSgte;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recuperar_contrasenha);
        correo= findViewById(R.id.correoTextInputLayout);
        btnSgte=findViewById(R.id.btn_enviarToken);

        btnSgte.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if( correo.getEditText().toString().length() == 0 )
                    correo.setError("Ingrese un correo valido por favor");
                else{
                    new AlertDialog.Builder(recuperarContrasenha.this)
                            .setTitle("Recuperacion de contraseña")
                            .setMessage("Si prosigue se le enviara un token para la recuperacion de contraseña")

                            // Specifying a listener allows you to take an action before dismissing the dialog.
                            // The dialog is automatically dismissed when a dialog button is clicked.
                            .setPositiveButton("Enviar Token", new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int which) {
                                    // Continue with delete operation
                                    Intent intent=new Intent(recuperarContrasenha.this, recuperarContrasenha.class);
                                    startActivity(intent);
                                }
                            })

                            // A null listener allows the button to dismiss the dialog and take no further action.
                            .setNegativeButton("Cancelar", null)
                            .setIcon(android.R.drawable.ic_dialog_alert)
                            .show();

                }

            }
        });



    }
}
