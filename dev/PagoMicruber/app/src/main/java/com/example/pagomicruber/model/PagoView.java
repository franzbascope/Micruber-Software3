package com.example.pagomicruber.model;

public class PagoView {
    private int monto;
    private String correo;

    public PagoView(int monto, String correo) {
        this.monto = monto;
        this.correo = correo;
    }

    public int getMonto() {
        return monto;
    }

    public void setMonto(int monto) {
        this.monto = monto;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }
}
