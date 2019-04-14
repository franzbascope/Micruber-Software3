package com.nur.compraonline.data.security;

import android.content.Context;

import com.nur.compraonline.data.Wrapper;
import com.nur.compraonline.model.security.Usuario;

import java.util.List;


public class DUser extends Wrapper {


    public DUser(Context context) {
        super(context, Usuario.class);
    }

    public List<Usuario> list() {
        return super.list("select * from " + tableName);
    }

    public Usuario get() {
        return (Usuario) this.get("select * from " + tableName);
    }


}
