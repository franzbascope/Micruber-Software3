package com.example.pagomicruber.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.example.pagomicruber.R;
import com.example.pagomicruber.model.PagoView;

import java.util.ArrayList;

public class PagoAdapter extends BaseAdapter {

    private ArrayList<PagoView> listPagos;
    private Context contexto;

    public PagoAdapter(ArrayList<PagoView> listPagos, Context contexto) {
        this.listPagos = listPagos;
        this.contexto = contexto;
    }

    @Override
    public int getCount() {
        return listPagos.size();
    }

    @Override
    public Object getItem(int i) {
        return listPagos.get(i);
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        PagoView item = (PagoView) getItem(i);

        view = LayoutInflater.from(contexto).inflate(R.layout.item,null);

        TextView monto = (TextView) view.findViewById(R.id.montodata);
        TextView correo = (TextView) view.findViewById(R.id.correodata);
        correo.setText(item.getCorreo());
        monto.setText(item.getMonto()+"");


        return view;
    }

    public void swapItems(ArrayList<PagoView> items) {
        this.listPagos.clear();
        this.listPagos = items;
        notifyDataSetChanged();
    }
}
