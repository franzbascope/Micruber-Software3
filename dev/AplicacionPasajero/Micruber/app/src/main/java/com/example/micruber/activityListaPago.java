package com.example.micruber;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.annotation.TargetApi;
import android.icu.util.LocaleData;
import android.os.Build;
import android.os.Bundle;
import android.widget.ListView;

import com.example.micruber.Objetos.Pago;
import com.example.micruber.adapter.ListPagosAdapter;
import com.google.android.gms.tasks.Task;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class activityListaPago extends AppCompatActivity {
    ArrayList<Pago> listDatos = new ArrayList<>();

    ListView listView;

    @TargetApi(Build.VERSION_CODES.O)
    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lista_pago);
        listView=findViewById(R.id.lvData);
        Date date = new Date();
        Pago p=new Pago(1,date,2,"pasaje mayor","10",false,0,0,0,date);
        listDatos.add(p);


        listView.setAdapter(new ListPagosAdapter(this,listDatos));

    }
}
