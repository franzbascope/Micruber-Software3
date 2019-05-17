package com.example.micruber.Objetos;

public class Vehiculo {

    private int vehiculoId;
    private int capacidad;
    private String placa;

    public Vehiculo() {
    }

    public Vehiculo(int vehiculoId, int capacidad, String placa) {
        this.vehiculoId = vehiculoId;
        this.capacidad = capacidad;
        this.placa = placa;
    }

    public int getVehiculoId() {
        return vehiculoId;
    }

    public void setVehiculoId(int vehiculoId) {
        this.vehiculoId = vehiculoId;
    }

    public int getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(int capacidad) {
        this.capacidad = capacidad;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }
}
