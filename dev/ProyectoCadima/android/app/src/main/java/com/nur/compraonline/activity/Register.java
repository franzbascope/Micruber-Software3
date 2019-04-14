package com.nur.compraonline.activity;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.nur.compraonline.Application;
import com.nur.compraonline.R;
import com.nur.compraonline.model.Action;
import com.nur.compraonline.model.security.Usuario;
import com.nur.compraonline.service.Service;


public class Register extends AppCompatActivity {

    private Usuario customer;

    private EditText etNombre;
    private EditText etApellido;
    private EditText etCorreo;
    private EditText etPassword;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        getSupportActionBar().setTitle(getResources().getString(R.string.register));

        //customer = (Customer) getIntent().getExtras().getSerializable("customer");
        customer = new Usuario();
        //cargamos los componentes
        etNombre = (EditText) findViewById(R.id.etNombre);
        etApellido = (EditText) findViewById(R.id.etApellido);
        etCorreo = (EditText) findViewById(R.id.etCorreo);
        etPassword = (EditText) findViewById(R.id.etPassword);
        customer.setAction(Action.Insert);
        ((Button) findViewById(R.id.cancel)).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        ((Button) findViewById(R.id.save)).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                customer.setNombre(etNombre.getText().toString());
                customer.setApellido(etApellido.getText().toString());
                customer.setEmail(etCorreo.getText().toString());
                customer.setContraseña(etPassword.getText().toString());
                customer.setTipoUsuario(1L);

                if (validate()==true) {
                    Call task = new Call(1,Register.this);
                    task.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);

                } else {
                    Toast.makeText(getApplicationContext(), getString(R.string.message_required), Toast.LENGTH_SHORT).show();
                }

            }
        });
    }

    private boolean validate(){
        //campos en blanco vacios
        if (customer.getEmail().length() < 3) {
            return false;
        }
        if (customer.getNombre().length() < 3) {
            return false;
        }
        if (customer.getApellido().length() < 3) {
            return false;
        }
        if (customer.getContraseña().length() < 3) {
            return false;
        }
       /*if (customer.getCorporateName().length() < 3) {
            return false;
        }
        if (customer.getNIT().length() < 3) {
            return false;
        }
        if (customer.getTelephone().length() < 3) {
            return false;
        }
        if (customer.getAddress().length() < 3) {
            return false;
        }*/
        return true;
    }
    private class Call extends AsyncTask<Integer, Void, Boolean> {

        private ProgressDialog progressDialog;
        private int action;
        private Context context;
        private int productRegistries;
        private int countSyncronize = 0;
        public Call(int varAction,Context cont) {
            this.action = varAction;
            this.context= cont;
        }

        @Override
        protected void onPreExecute() {
            progressDialog = ProgressDialog.show(Register.this, null, getString(R.string.enviando));
        }

        @Override
        protected Boolean doInBackground(Integer... arg0) {
            try {
                Service service = new Service(Register.this);
                //Llamada a las Dal
                if (action == 1) {
                    long valor = service.postUser(customer,"","");
                    if (valor > 0){
                        return true;
                    }

                }

            }catch (Exception e){
                return false;
            }
                return false;
        }
        protected void onPostExecute(Boolean result) {
            progressDialog.dismiss();
            if (result) {
                //Sincronizacion Terminada
                Log.i(Application.tag, "Actualizando pantalla principal");
                if (action ==1){
                    Toast toas = Toast.makeText(context,productRegistries + " Registros Obtenidos Correctamente.!",Toast.LENGTH_SHORT);
                    toas.show();
                }

            }
        }

    }

}
