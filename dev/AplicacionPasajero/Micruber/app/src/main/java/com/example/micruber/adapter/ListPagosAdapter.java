package com.example.micruber.adapter;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.example.micruber.Objetos.Pago;
import com.example.micruber.R;

import java.util.List;

public class ListPagosAdapter extends BaseAdapter {

    private Context context;
    private List<Pago> lstPagos;

    public ListPagosAdapter(Context context, List<Pago> lstPagos) {
        this.context = context;
        this.lstPagos = lstPagos;
    }

    @Override
    public int getCount() {
        return this.lstPagos.size();
    }

    @Override
    public Object getItem(int position) {
        return this.lstPagos.get(position);
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View view=null;
        LayoutInflater inflater=((Activity)context).getLayoutInflater();
        view=inflater.inflate(R.layout.itemlist,null,true);

        TextView tvFecha=view.findViewById(R.id.idFecha);
        TextView tvLinea=view.findViewById(R.id.txtLinea);

        Pago pago=(Pago) getItem(position);
        tvFecha.setText(pago.getFechaPago()+"");
        tvLinea.setText(pago.getNumeroLinea());

        view.setTag(pago);

        return view;



    }
}
