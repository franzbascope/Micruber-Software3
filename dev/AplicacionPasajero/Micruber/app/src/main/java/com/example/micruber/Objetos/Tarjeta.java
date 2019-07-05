package com.example.micruber.Objetos;

public class Tarjeta {
    private String descripcion;
    private boolean estado;

    public Tarjeta(String descripcion, boolean estado) {
        this.descripcion = descripcion;
        this.estado = estado;
    }

    public String getdescripcion() {
        return descripcion;
    }

    public void setdescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }
}
