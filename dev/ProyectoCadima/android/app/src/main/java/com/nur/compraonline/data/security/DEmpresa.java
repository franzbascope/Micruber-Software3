package com.nur.compraonline.data.security;

import android.content.Context;

import com.nur.compraonline.data.Wrapper;
import com.nur.compraonline.model.security.Empresa;
import com.nur.compraonline.model.security.Producto;

import java.util.List;


public class DEmpresa extends Wrapper {


    public DEmpresa(Context context) {
        super(context, Empresa.class);
    }

    public List<Empresa> list() {
        return super.list("select * from " + tableName);
    }

    public Empresa get() {
        return (Empresa) this.get("select * from " + tableName);
    }


}
