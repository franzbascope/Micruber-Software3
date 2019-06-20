package com.example.micruber.Objetos;

public class Linea {

    private int lineaId;
    private String numeroLinea;

    public Linea() {
    }

    public Linea(int lineaId, String numeroLinea) {
        this.lineaId = lineaId;
        this.numeroLinea = numeroLinea;
    }

    public int getLineaId() {
        return lineaId;
    }

    public void setLineaId(int lineaId) {
        this.lineaId = lineaId;
    }

    public String getNumeroLinea() {
        return numeroLinea;
    }

    public void setNumeroLinea(String numeroLinea) {
        this.numeroLinea = numeroLinea;
    }

    @Override
    public String toString() {
        return
                "Linea=" + numeroLinea ;
    }
}
