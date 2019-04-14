package com.nur.compraonline.model.security;

import com.nur.compraonline.model.Entity;

/**
 * Created by dpedrazas on 16/10/2017.
 */

public class Clasificadores extends Entity {
    private Integer TipoHijosId;
    private Integer TipoMaestroId;
    private String Nombre ;
    private String Valor ;
    private Boolean Estado ;

    public Clasificadores() {
    }

    public Integer getTipoHijosId() {
        return TipoHijosId;
    }

    public void setTipoHijosId(Integer tipoHijosId) {
        TipoHijosId = tipoHijosId;
    }

    public Integer getTipoMaestroId() {
        return TipoMaestroId;
    }

    public void setTipoMaestroId(Integer tipoMaestroId) {
        TipoMaestroId = tipoMaestroId;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String nombre) {
        Nombre = nombre;
    }

    public String getValor() {
        return Valor;
    }

    public void setValor(String valor) {
        Valor = valor;
    }

    public Boolean getEstado() {
        return Estado;
    }

    public void setEstado(Boolean estado) {
        Estado = estado;
    }
}
