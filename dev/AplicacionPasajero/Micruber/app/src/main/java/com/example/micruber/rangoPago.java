package com.example.micruber;

import androidx.appcompat.app.AppCompatActivity;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Calendar;

public class rangoPago extends AppCompatActivity implements View.OnClickListener {

    Button btnGuardar;
    TextView tvInicio;
    private int dia, mes, ano;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rango_pago);
        tvInicio=findViewById(R.id.txtFechaForm);
        btnGuardar=findViewById(R.id.btnGuardar);

        btnGuardar.setOnClickListener(this);
        tvInicio.setOnClickListener(this);


    }
    public String addzero(int numero) {
        String resultado;
        if (numero < 10) {
            resultado = "0" + String.valueOf(numero);
        } else {
            resultado = String.valueOf(numero);
        }
        return resultado;

    }


    @Override
    public void onClick(View v) {
        if(v==tvInicio){
            final Calendar c = Calendar.getInstance();
            dia = c.get(Calendar.DAY_OF_MONTH);
            mes = c.get(Calendar.MONTH);
            ano = c.get(Calendar.YEAR);

            DatePickerDialog datePickerDialog = new DatePickerDialog(this, new DatePickerDialog.OnDateSetListener() {
                @Override
                public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
                    tvInicio.setText(year+"-"+addzero(month)+"-"+addzero(dayOfMonth));


                }
            }
                    , ano, mes, dia);
            datePickerDialog.show();

        }
        if(v==btnGuardar){
            if(tvInicio.getText().toString().equals("")){
                Toast.makeText(rangoPago.this,"Seleccione una fecha",Toast.LENGTH_LONG).show();
                return;
            }else{
                Intent intent=new Intent(rangoPago.this, activityListaPago.class);
                intent.putExtra("fechaInicio", tvInicio.getText().toString());
                startActivity(intent);
                finish();
            }
        }


    }
}
