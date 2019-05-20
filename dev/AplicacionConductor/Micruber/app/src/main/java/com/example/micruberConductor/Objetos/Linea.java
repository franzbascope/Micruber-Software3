package com.example.micruberConductor.Objetos;

public class Linea {
    private int lineaId;
    private String nroLinea;

    public int getLineaId() {
        return lineaId;
    }

    public void setLineaId(int lineaId) {
        this.lineaId = lineaId;
    }

    public String getNroLinea() {
        return nroLinea;
    }

    public void setNroLinea(String nroLinea) {
        this.nroLinea = nroLinea;
    }

    public Linea(int lineaId, String nroLinea) {
        this.lineaId = lineaId;
        this.nroLinea = nroLinea;
    }

    public Linea() {
    }
    @Override
    public String toString() {
        return nroLinea;
    }
}
