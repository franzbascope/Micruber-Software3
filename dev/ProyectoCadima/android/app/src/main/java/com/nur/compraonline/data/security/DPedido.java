package com.nur.compraonline.data.security;

import android.content.Context;

import com.nur.compraonline.data.Wrapper;
import com.nur.compraonline.model.security.Pedido;
import com.nur.compraonline.model.security.Producto;

import java.util.List;


public class DPedido extends Wrapper {


    public DPedido(Context context) {
        super(context, Pedido.class);
    }

    public List<Pedido> list() {
        return super.list("select * from " + tableName);
    }

    public List<Pedido> listByEmpresa(int EmpresaId) {
        return super.list("select * from " + tableName + " where EmpresaId = " + EmpresaId);
    }

    public Pedido get() {
        return (Pedido) this.get("select * from " + tableName);
    }


}
