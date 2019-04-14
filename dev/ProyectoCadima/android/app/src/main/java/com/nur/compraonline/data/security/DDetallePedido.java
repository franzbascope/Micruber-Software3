package com.nur.compraonline.data.security;

import android.content.Context;

import com.nur.compraonline.data.Wrapper;
import com.nur.compraonline.model.security.DetallePedido;
import com.nur.compraonline.model.security.Producto;

import java.util.List;


public class DDetallePedido extends Wrapper {


    public DDetallePedido(Context context) {
        super(context, DetallePedido.class);
    }

    public List<DetallePedido> list() {
        return super.list("select * from " + tableName);
    }



    public DetallePedido get() {
        return (DetallePedido) this.get("select * from " + tableName);
    }


}
