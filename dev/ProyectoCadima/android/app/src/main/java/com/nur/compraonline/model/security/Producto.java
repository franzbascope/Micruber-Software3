package com.nur.compraonline.model.security;

import com.nur.compraonline.model.Entity;

/**
 * Created by dpedrazas on 12/09/2017.
 */

public class Producto extends Entity {

    private Integer ProductoId;
    private Integer TipoIdc ;
    private Integer EmpresaId ;
    private String Nombre ;
    private Double Precio ;
    private Boolean Estado ;

    public Producto() {
    }

    public Integer getProductoId() {
        return ProductoId;
    }

    public void setProductoId(Integer productoId) {
        ProductoId = productoId;
    }

    public Integer getTipoIdc() {
        return TipoIdc;
    }

    public void setTipoIdc(Integer tipoIdc) {
        TipoIdc = tipoIdc;
    }

    public Integer getEmpresaId() {
        return EmpresaId;
    }

    public void setEmpresaId(Integer empresaId) {
        EmpresaId = empresaId;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String nombre) {
        Nombre = nombre;
    }

    public Double getPrecio() {
        return Precio;
    }

    public void setPrecio(Double precio) {
        Precio = precio;
    }

    public Boolean getEstado() {
        return Estado;
    }

    public void setEstado(Boolean estado) {
        Estado = estado;
    }
}
