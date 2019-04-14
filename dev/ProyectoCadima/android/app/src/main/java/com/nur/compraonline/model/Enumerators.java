package com.nur.compraonline.model;


import java.io.Serializable;


public class Enumerators implements Serializable {
    public static final class SaleStatus{
        public final static long Disable=0;
        public final static long Enable=1;
        public final static long Sent=2;
    }

}
