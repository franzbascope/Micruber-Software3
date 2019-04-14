package com.nur.compraonline.model.security;

import com.nur.compraonline.model.Entity;
import com.nur.compraonline.model.annotation.Ignore;

import java.util.Date;

/**
 * Created by dpedrazas on 12/09/2017.
 */

public class DetallePedido extends Entity {

    public Integer DetallePedidoId;
    public Integer PedidoId ;
    public Integer ProductoId ;
    public Double Precio ;
    public Double Cantidad ;
    public Double SubTotal ;
    @Ignore
    public  Producto producto;

    public DetallePedido() {
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public Integer getDetallePedidoId() {
        return DetallePedidoId;
    }

    public void setDetallePedidoId(Integer detallePedidoId) {
        DetallePedidoId = detallePedidoId;
    }

    public Integer getPedidoId() {
        return PedidoId;
    }

    public void setPedidoId(Integer pedidoId) {
        PedidoId = pedidoId;
    }

    public Integer getProductoId() {
        return ProductoId;
    }

    public void setProductoId(Integer productoId) {
        ProductoId = productoId;
    }

    public Double getPrecio() {
        return Precio;
    }

    public void setPrecio(Double precio) {
        Precio = precio;
    }

    public Double getCantidad() {
        return Cantidad;
    }

    public void setCantidad(Double cantidad) {
        Cantidad = cantidad;
    }

    public Double getSubTotal() {
        return SubTotal;
    }

    public void setSubTotal(Double subTotal) {
        SubTotal = subTotal;
    }
}
