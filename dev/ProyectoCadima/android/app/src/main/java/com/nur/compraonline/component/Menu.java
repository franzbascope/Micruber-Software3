package com.nur.compraonline.component;

import java.io.Serializable;


public class Menu implements Serializable {

    private int id;
    private int label;
    private String icon;

    public Menu(int id, int label, String icon) {
        this.id = id;
        this.label = label;
        this.icon = icon;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getLabel() {
        return label;
    }

    public void setLabel(int label) {
        this.label = label;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }
}
