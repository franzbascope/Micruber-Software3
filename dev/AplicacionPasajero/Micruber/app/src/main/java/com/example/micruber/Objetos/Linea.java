package com.example.micruber.Objetos;

public class Linea {

    private int lineaId;
    private String numeroLinea;
    private double distanciaCaminarMetros;
    private double distanciaRecorridoMetros;
    private int tiempoCaminata;
    private int tiempoRecorrido;

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

    public double getDistanciaCaminarMetros() {
        return distanciaCaminarMetros;
    }

    public void setDistanciaCaminarMetros(double distanciaCaminarMetros) {
        this.distanciaCaminarMetros = distanciaCaminarMetros;
    }

    public double getDistanciaRecorridoMetros() {
        return distanciaRecorridoMetros;
    }

    public void setDistanciaRecorridoMetros(double distanciaRecorridoMetros) {
        this.distanciaRecorridoMetros = distanciaRecorridoMetros;
    }

    public int getTiempoCaminata() {
        return tiempoCaminata;
    }

    public void setTiempoCaminata(int tiempoCaminata) {
        this.tiempoCaminata = tiempoCaminata;
    }

    public int getTiempoRecorrido() {
        return tiempoRecorrido;
    }

    public void setTiempoRecorrido(int tiempoRecorrido) {
        this.tiempoRecorrido = tiempoRecorrido;
    }

    @Override
    public String toString() {
        return
                "Linea=" + numeroLinea ;
    }
}
