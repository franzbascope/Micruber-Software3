package com.nur.compraonline.model.security;

import com.nur.compraonline.model.Entity;

/**
 * Created by dpedrazas on 12/09/2017.
 */

public class Empresa extends Entity {

    private Integer EmpresaId ;
    private Integer TipoIdc ;
    private String Nit ;
    private String Nombre ;
    private String Gerente ;
    private String Telefono ;
    private Boolean Estado ;

    public Empresa() {
    }

    public Integer getEmpresaId() {
        return EmpresaId;
    }

    public void setEmpresaId(Integer empresaId) {
        EmpresaId = empresaId;
    }

    public Integer getTipoIdc() {
        return TipoIdc;
    }

    public void setTipoIdc(Integer tipoIdc) {
        TipoIdc = tipoIdc;
    }

    public String getNit() {
        return Nit;
    }

    public void setNit(String nit) {
        Nit = nit;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String nombre) {
        Nombre = nombre;
    }

    public String getGerente() {
        return Gerente;
    }

    public void setGerente(String gerente) {
        Gerente = gerente;
    }

    public String getTelefono() {
        return Telefono;
    }

    public void setTelefono(String telefono) {
        Telefono = telefono;
    }

    public Boolean getEstado() {
        return Estado;
    }

    public void setEstado(Boolean estado) {
        Estado = estado;
    }
}
