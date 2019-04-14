package com.nur.compraonline.activity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.nur.compraonline.R;


public class RegistroPedido extends AppCompatActivity {

   private Button btnRecuperar;
    private  Button btnIngresar;
    private EditText etEmail;
    private  EditText etPassword;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
       this.setTitle("ACT. REGISTRO DE PEDIDO");
    }

    @Override
    protected void onResume() {
        super.onResume();

    }

    @Override
    protected void onStart() {
        super.onStart();
     /*   if (serviceIntent != null) {
            startService(serviceIntent);
        }*/
    }

    @Override
    public void onDestroy() {
      super.onDestroy();
        /*  if (serviceIntent != null) {
            stopService(serviceIntent);
        }*/
        //startActivity(new Intent(Main.this, Main.class));
    }

    @Override
    public void onBackPressed() {
        new AlertDialog.Builder(this).setTitle(null).setMessage(R.string.message_close).setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                finish();
            }
        }).setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {

            }
        }).setIcon(android.R.drawable.ic_dialog_alert).show();
    }




}
