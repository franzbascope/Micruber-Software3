package com.example.micruber.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.example.micruber.Objetos.Tarjeta;
import com.example.micruber.R;

import java.util.ArrayList;

public class TarjetaAdapter extends BaseAdapter {

    private ArrayList<Tarjeta> listTarjeta;
    private Context contexto;

    public TarjetaAdapter(ArrayList<Tarjeta> listTarjeta, Context contexto) {
        this.listTarjeta = listTarjeta;
        this.contexto = contexto;
    }

    @Override
    public int getCount() {
        return listTarjeta.size();
    }

    @Override
    public Tarjeta getItem(int i) {
        return listTarjeta.get(i);
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        Tarjeta item = (Tarjeta) getItem(i);

        view = LayoutInflater.from(contexto).inflate(R.layout.item,null);

        TextView descripcion = (TextView) view.findViewById(R.id.descText);
        TextView estado = (TextView) view.findViewById(R.id.estadoText);
        String estate= "";
        if(item.isEstado()){
            estate = "Habilitada";
        }else{
            estate = "Deshabilitado";
        }
        estado.setText(estate);
        descripcion.setText(item.getdescripcion());

        return view;
    }

    public void swapItems(ArrayList<Tarjeta> items) {
        this.listTarjeta.clear();
        this.listTarjeta = items;
        notifyDataSetChanged();
    }
}
