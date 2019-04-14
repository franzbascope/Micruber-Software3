package com.nur.compraonline.service;

import android.content.Context;

import com.google.android.gms.analytics.ecommerce.Product;
import com.google.gson.reflect.TypeToken;
import com.nur.compraonline.Application;
import com.nur.compraonline.model.security.Clasificadores;
import com.nur.compraonline.model.security.Empresa;
import com.nur.compraonline.model.security.Pedido;
import com.nur.compraonline.model.security.Producto;
import com.nur.compraonline.model.security.Usuario;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class Service extends Web {

    private SimpleDateFormat dateFormat;

    public Service(Context context) {
        super(context);
        dateFormat = new SimpleDateFormat(Application.formatDateShort);
    }

    public Date getServerDay() throws Exception {
        return (Date) super.getObject("/api/default/serverdate", Date.class,"","");
    }

    public Date getNextday(String user, String password) throws Exception {
        return (Date) super.getObject("/api/default/nextday", Date.class, user, password);
    }

    public Date getDay(String user, String password) throws Exception {
        return (Date) super.getObject("/api/default/day", Date.class, user, password);
    }

    public Usuario getUser(String email,String password) throws Exception {
            return super.get("/api/usuario/getByEmailPass/" + email +"/"+password, Usuario.class,"","");
    }

    public long postUser(Usuario entity, String user, String password) throws Exception {
    return super.post("/api/usuario", entity.getClass(), entity, "", "");
    }
    public long postPedido(Pedido entity, String user, String password) throws Exception {
        return super.post("/api/pedido", entity.getClass(), entity, "", "");
    }
    public long postRestorePass(Usuario entity, String user, String password) throws Exception {
        return super.post("/api/recuperar", entity.getClass(), entity, "", "");
    }
    public List<Clasificadores> getClasificadores( String user, String password) throws Exception {
        return super.getList("/api/clasificadores/getClasificadores" , new TypeToken<ArrayList<Clasificadores>>() {
        }.getType(), user, password);
    }
    public List<Empresa> getEmpresas(String user, String password) throws Exception {
        return super.getList("/api/empresa/getEmpresas" , new TypeToken<ArrayList<Empresa>>() {
        }.getType(), user, password);
    }
    public List<Producto> getProductos(String user, String password) throws Exception {
        return super.getList("/api/product/getProductos" , new TypeToken<ArrayList<Producto>>() {
        }.getType(), user, password);
    }
}
