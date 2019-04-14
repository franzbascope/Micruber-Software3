package com.nur.compraonline.data.security;

import android.content.Context;

import com.nur.compraonline.data.Wrapper;
import com.nur.compraonline.model.security.Producto;
import com.nur.compraonline.model.security.Usuario;

import java.util.List;


public class DProducto extends Wrapper {


    public DProducto(Context context) {
        super(context, Producto.class);
    }

    public List<Producto> list() {
        return super.list("select * from " + tableName);
    }

    public List<Producto> listByEmpresa(int EmpresaId) {
        return super.list("select * from " + tableName + " where EmpresaId = " + EmpresaId);
    }

    public Producto get() {
        return (Producto) this.get("select * from " + tableName);
    }


}
