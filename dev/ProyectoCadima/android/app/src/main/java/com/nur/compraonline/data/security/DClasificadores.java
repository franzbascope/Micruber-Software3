package com.nur.compraonline.data.security;

import android.content.Context;

import com.nur.compraonline.data.Wrapper;
import com.nur.compraonline.model.security.Clasificadores;
import com.nur.compraonline.model.security.Producto;

import java.util.List;


public class DClasificadores extends Wrapper {


    public DClasificadores(Context context) {
        super(context, Clasificadores.class);
    }

    public List<Clasificadores> list() {
        return super.list("select * from " + tableName);
    }

    public Clasificadores get() {
        return (Clasificadores) this.get("select * from " + tableName);
    }


}
