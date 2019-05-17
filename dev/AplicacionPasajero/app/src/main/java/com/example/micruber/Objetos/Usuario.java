package com.example.micruber.Objetos;

public class Usuario {

    private int usuarioId;
    private String nombreCompleto;
    private String correo;
    private String password;
    private String codigoActivacion;
    private String codigoRecuperacion;

    public Usuario() {
    }

    public Usuario(int usuarioId, String nombreCompleto, String correo, String password, String codigoActivacion, String codigoRecuperacion) {
        this.usuarioId = usuarioId;
        this.nombreCompleto = nombreCompleto;
        this.correo = correo;
        this.password = password;
        this.codigoActivacion = codigoActivacion;
        this.codigoRecuperacion = codigoRecuperacion;
    }

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCodigoActivacion() {
        return codigoActivacion;
    }

    public void setCodigoActivacion(String codigoActivacion) {
        this.codigoActivacion = codigoActivacion;
    }

    public String getCodigoRecuperacion() {
        return codigoRecuperacion;
    }

    public void setCodigoRecuperacion(String codigoRecuperacion) {
        this.codigoRecuperacion = codigoRecuperacion;
    }
}
