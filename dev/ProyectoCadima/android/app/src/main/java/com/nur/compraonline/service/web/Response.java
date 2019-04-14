package com.nur.compraonline.service.web;

import java.io.Serializable;


public class Response implements Serializable {

    private int code;
    private String url;
    private String method;
    private String location;
    private Long locationId;
    private String message;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Long getLocationId() {
        return locationId;
    }

    public void setLocationId(Long locationId) {
        this.locationId = locationId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "Response{" +
                "code=" + code +
                ", url='" + url + '\'' +
                ", method='" + method + '\'' +
                ", location='" + location + '\'' +
                ", locationId=" + locationId +
                ", message='" + message + '\'' +
                '}';
    }
}
