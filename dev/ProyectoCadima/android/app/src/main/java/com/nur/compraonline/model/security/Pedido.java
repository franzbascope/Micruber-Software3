package com.nur.compraonline.model.security;

import com.nur.compraonline.model.Entity;
import com.nur.compraonline.model.annotation.Ignore;

import java.util.Date;
import java.util.List;

/**
 * Created by dpedrazas on 12/09/2017.
 */

public class Pedido extends Entity {

    public Integer PedidoId ;
    public Long ClienteId ;
    public Integer EmpresaId;
    public String UsuarioId ;
    public Date Fecha ;
    public Boolean Atendido ;
    @Ignore
    public List<DetallePedido> lstDetalle ;

    public Pedido() {
    }

    public Integer getPedidoId() {
        return PedidoId;
    }

    public void setPedidoId(Integer pedidoId) {
        PedidoId = pedidoId;
    }

    public Long getClienteId() {
        return ClienteId;
    }

    public void setClienteId(Long clienteId) {
        ClienteId = clienteId;
    }

    public Integer getEmpresaId() {
        return EmpresaId;
    }

    public void setEmpresaId(Integer empresaId) {
        EmpresaId = empresaId;
    }

    public String getUsuarioId() {
        return UsuarioId;
    }

    public void setUsuarioId(String usuarioId) {
        UsuarioId = usuarioId;
    }

    public Date getFecha() {
        return Fecha;
    }

    public void setFecha(Date fecha) {
        Fecha = fecha;
    }

    public Boolean getAtendido() {
        return Atendido;
    }

    public void setAtendido(Boolean atendido) {
        Atendido = atendido;
    }

    public List<DetallePedido> getLstDetalle() {
        return lstDetalle;
    }

    public void setLstDetalle(List<DetallePedido> lstDetalle) {
        this.lstDetalle = lstDetalle;
    }
}
