package com.example.micruber.Objetos;

public class Coordenadas {
    public int vehiculoId;
    public  int lineaId;
    public double latitud;
    public double longitud;
    public String id;

    public Coordenadas() {
    }

    public Coordenadas(double latitud, double longitud) {
        this.latitud = latitud;
        this.longitud = longitud;
    }

    public Coordenadas(int vehiculoId, int lineaId, double latitud, double longitud, String id) {
        this.vehiculoId = vehiculoId;
        this.lineaId = lineaId;
        this.latitud = latitud;
        this.longitud = longitud;
        this.id = id;
    }

    public int getVehiculoId() {
        return vehiculoId;
    }

    public void setVehiculoId(int vehiculoId) {
        this.vehiculoId = vehiculoId;
    }

    public int getLineaId() {
        return lineaId;
    }

    public void setLineaId(int lineaId) {
        this.lineaId = lineaId;
    }

    public double getLatitud() {
        return latitud;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public double getLongitud() {
        return longitud;
    }

    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
