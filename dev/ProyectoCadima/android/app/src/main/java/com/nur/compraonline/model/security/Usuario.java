package com.nur.compraonline.model.security;

import com.nur.compraonline.model.Entity;

import java.util.Date;

/**
 * Created by dpedrazas on 12/09/2017.
 */

public class Usuario extends Entity {


    private Long UsuarioId;
    private String Nombre;
    private String Apellido;
    private String Email;
    private String Contraseña;
    private Long TipoUsuario;

    public Usuario() {
    }

    public Long getUsuarioId() {
        return UsuarioId;
    }

    public void setUsuarioId(Long usuarioId) {
        UsuarioId = usuarioId;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String nombre) {
        Nombre = nombre;
    }

    public String getApellido() {
        return Apellido;
    }

    public void setApellido(String apellido) {
        Apellido = apellido;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getContraseña() {
        return Contraseña;
    }

    public void setContraseña(String contraseña) {
        Contraseña = contraseña;
    }

    public Long getTipoUsuario() {
        return TipoUsuario;
    }

    public void setTipoUsuario(Long tipoUsuario) {
        TipoUsuario = tipoUsuario;
    }
}
