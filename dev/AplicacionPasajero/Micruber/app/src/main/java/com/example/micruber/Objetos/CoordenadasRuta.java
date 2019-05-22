package com.example.micruber.Objetos;

public class CoordenadasRuta {
    private double latitud;
    private double longitud;
    private double latitudFin;
    private double longitudFin;

    public CoordenadasRuta() {
    }

    public CoordenadasRuta(double latitud, double longitud, double latitudFin, double longitudFin) {
        this.latitud = latitud;
        this.longitud = longitud;
        this.latitudFin = latitudFin;
        this.longitudFin = longitudFin;
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

    public double getLatitudFin() {
        return latitudFin;
    }

    public void setLatitudFin(double latitudFin) {
        this.latitudFin = latitudFin;
    }

    public double getLongitudFin() {
        return longitudFin;
    }

    public void setLongitudFin(double longitudFin) {
        this.longitudFin = longitudFin;
    }
}
