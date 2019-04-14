package com.nur.compraonline.service;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Environment;
import android.util.Base64;
import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.nur.compraonline.Application;
import com.nur.compraonline.model.Entity;
import com.nur.compraonline.service.web.Response;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;

@SuppressWarnings("deprecation")
public abstract class Web {

    private boolean hasConnection = false;
    private Context context;
    private String urlServices;

    protected Gson gson;

    public Web(Context context) {
        this.context = context;
        this.hasConnection = (checkMobile() || checkWifi());
        this.initGson();
        if (checkWifi()) {
            this.hasConnection = true;
            this.urlServices = context.getSharedPreferences("Configurations", Context.MODE_PRIVATE).getString("privateService", Application.webServicesPrivate);
            return;
        }
        if (checkMobile()) {
            this.hasConnection = true;
            this.urlServices = context.getSharedPreferences("Configurations", Context.MODE_PRIVATE).getString("publicService", Application.webServicesPublic);
            return;
        }
    }

    public boolean checkWifi() {
        try {
            ConnectivityManager connectivity = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
            if (connectivity != null) {
                NetworkInfo info = connectivity.getNetworkInfo(ConnectivityManager.TYPE_WIFI);
                if (info != null) {
                    if (info.isConnected()) {
                        return true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean checkMobile() {
        try {
            ConnectivityManager connectivity = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
            if (connectivity != null) {
                NetworkInfo info = connectivity.getNetworkInfo(ConnectivityManager.TYPE_MOBILE);
                if (info != null) {
                    if (info.isConnected()) {
                        return true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isConnected() {
        return this.hasConnection;
    }

    private void initGson() {
        GsonBuilder builder = new GsonBuilder();
        builder.setDateFormat(Application.formatDate);
        //builder.excludeFieldsWithoutExposeAnnotation();
        gson = builder.create();
    }

    private HttpURLConnection prepareConnection(HttpURLConnection connection, String user, String password) {
        connection.setRequestProperty("Accept", "application/json");
        connection.setRequestProperty("Content-type", "application/json");
        return applySecurity(connection, user, password);
    }

    private HttpURLConnection applySecurity(HttpURLConnection request, String user, String password) {
        request.setRequestProperty("Authorization", "Basic " + Base64.encodeToString((user + ":" + password).getBytes(), Base64.NO_WRAP));
        return request;
    }

    private Response response(HttpURLConnection connection) throws Exception {
        StringBuffer buffer = new StringBuffer();
        BufferedReader reader = null;
        try {
            InputStream in = connection.getResponseCode() >= 400 ? connection.getErrorStream() : connection.getInputStream();
            reader = new BufferedReader(new InputStreamReader(in));
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                reader.close();
            }
        }
        Response obj = new Response();
        obj.setCode(connection.getResponseCode());
        obj.setUrl(connection.getURL().toString());
        obj.setMethod(connection.getRequestMethod());
        obj.setMessage(buffer.toString());
        obj.setLocation(connection.getHeaderField("Location"));
        if (obj.getLocation() != null) {
            try {
                String[] parts = obj.getLocation().split("/");
                String id = parts[parts.length - 1];
                obj.setLocationId(Long.parseLong(id));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //Log.i(Configuration.tag, obj.toString());
        return obj;
    }

    public Object getObject(String method, Type type, String user, String password) throws Exception {
        URL url = new URL(urlServices + method);
        try {
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            prepareConnection(connection, user, password);
            connection.setUseCaches(false);
            connection.setDoInput(true);
            connection.disconnect();
            Response response = response(connection);
            if (response.getCode() == HttpURLConnection.HTTP_OK) {
                return gson.fromJson(response.getMessage(), type);
            }
            throw new Exception(String.format("Error->GET Metodo: %s, Code: %s, Mensaje: %s", method, response.getCode(), response.getMessage()));
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
            throw e;
        }
    }

    public <T extends Entity> T get(String method, Type type, String user, String password) throws Exception {
        URL url = new URL(urlServices + method);
        try {
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            prepareConnection(connection, user, password);
            connection.setUseCaches(false);
            connection.setDoInput(true);
            connection.disconnect();
            Response response = response(connection);
            if (response.getCode() == HttpURLConnection.HTTP_OK) {
                T entity = gson.fromJson(response.getMessage(), type);
                return entity;
            }
            throw new Exception(String.format("Error->GET Metodo: %s, Code: %s, Mensaje: %s", method, response.getCode(), response.getMessage()));
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
            throw e;
        }
    }

    public <T extends Entity> List<T> getList(String method, Type type, String user, String password) throws Exception {
        URL url = new URL(urlServices + method);

        try {
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            prepareConnection(connection, user, password);
            connection.setUseCaches(false);
            connection.setDoInput(true);
            connection.setRequestMethod("GET");
            connection.disconnect();
            Response response = response(connection);
            if (response.getCode() == HttpURLConnection.HTTP_OK) {
                List<T> entities = gson.fromJson(response.getMessage(), type);
                return entities;
            }
            throw new Exception(String.format("Error->GET Metodo: %s, Code: %s, Mensaje: %s", method, response.getCode(), response.getMessage()));
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
            throw e;
        }
    }

    public <T extends Entity> long post(String method, Type type, T obj, String user, String password) throws Exception {
        URL url = new URL(urlServices + method);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        try {
            String postData = gson.toJson(obj);
            prepareConnection(connection, user, password);
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestMethod("POST");
            DataOutputStream osw = new DataOutputStream(connection.getOutputStream());
            osw.write(postData.getBytes());
            osw.flush();
            Response response = response(connection);
            if (response.getCode() == HttpURLConnection.HTTP_CREATED) {
                return response.getLocationId();
            }

            if (response.getCode() == HttpURLConnection.HTTP_CONFLICT) {
                return put(method + "/" + response.getLocationId(), type, obj, user, password);
            }
            throw new Exception(String.format("Error->POST Metodo: %s, Code: %s, Mensaje: %s", method, response.getCode(), response.getMessage()));
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
            throw e;
        } finally {
            connection.disconnect();
        }
    }

    public <T extends Entity> long put(String method, Type type, T obj, String user, String password) throws Exception {
        URL url = new URL(urlServices + method);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        try {
            String postData = gson.toJson(obj);
            prepareConnection(connection, user, password);
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestMethod("PUT");
            DataOutputStream osw = new DataOutputStream(connection.getOutputStream());
            osw.write(postData.getBytes());
            osw.flush();
            Response response = response(connection);
            if (response.getCode() == HttpURLConnection.HTTP_ACCEPTED) {
                return response.getLocationId();
            }
            throw new Exception(String.format("Error->PUT Metodo: %s, Code: %s, Mensaje: %s", method, response.getCode(), response.getMessage()));
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
            throw e;
        } finally {
            connection.disconnect();
        }
    }

    public <T extends Object> boolean put(String method, T obj, String user, String password) throws Exception {
        URL url = new URL(urlServices + method);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        try {
            String postData = gson.toJson(obj);
            Log.i(Application.tag, postData);
            prepareConnection(connection, user, password);
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestMethod("PUT");
            DataOutputStream osw = new DataOutputStream(connection.getOutputStream());
            osw.write(postData.getBytes());
            osw.flush();
            Response response = response(connection);
            if (response.getCode() == HttpURLConnection.HTTP_ACCEPTED) {
                return true;
            }
            throw new Exception(String.format("Error->PUT Metodo: %s, Code: %s, Mensaje: %s", method, response.getCode(), response.getMessage()));
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
            throw e;
        } finally {
            connection.disconnect();
        }
    }

    public <T extends Entity> boolean delete(String method, Type type, T obj, String user, String password) throws Exception {
        URL url = new URL(urlServices + method + "/" + obj.getId());
        try {
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            applySecurity(connection, user, password);
            connection.setUseCaches(false);
            connection.setDoInput(true);
            connection.setRequestMethod("DELETE");
            connection.disconnect();
            Response response = response(connection);
            if (response.getCode() == HttpURLConnection.HTTP_OK) {
                return true;
            }
            throw new Exception(String.format("Error->DELETE Metodo: %s, Code: %s, Mensaje: %s", method, response.getCode(), response.getMessage()));
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
            throw e;
        }
    }


    public String post(File file, String user, String password) throws Exception {
        URL url = new URL(urlServices + "/api/files");
        Response response = this.upload(file, url, "POST", user, password);
        return response.getLocation().replace(response.getUrl(), "").replace("/", "");
    }

    public String put(File file, String guid, String user, String password) throws Exception {
        URL url = new URL(urlServices + "/api/files/" + guid);
        Response response = this.upload(file, url, "PUT", user, password);
        return response.getLocation().replace(response.getUrl(), "").replace("/", "");
    }

    public boolean delete(String guid, String user, String password) throws Exception {
        URL url = new URL(urlServices + "/api/files/" + guid);
        try {
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            applySecurity(connection, user, password);
            connection.setUseCaches(false);
            connection.setDoInput(true);
            connection.setRequestMethod("DELETE");
            connection.disconnect();
            Response response = response(connection);
            if (response.getCode() == HttpURLConnection.HTTP_OK) {
                return true;
            }
            throw new Exception(String.format("Error->DELETE Metodo: %s, Code: %s, Mensaje: %s", "/api/files/" + guid, response.getCode(), response.getMessage()));
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
            throw e;
        }
    }

    private Response upload(File file, URL url, String method, String user, String password) throws Exception {
        String boundary = "*****";
        String fileName = file.getName();
        String crlf = "\r\n";
        try {
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            applySecurity(connection, user, password);
            connection.setUseCaches(false);
            connection.setDoInput(true);
            connection.setRequestMethod(method);
            connection.setRequestProperty("Connection", "Keep-Alive");
            connection.setRequestProperty("Cache-Control", "no-cache");
            connection.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
            OutputStream outputStream = connection.getOutputStream();
            PrintWriter writer = new PrintWriter(new OutputStreamWriter(outputStream, "UTF-8"), true);
            writer.append("--" + boundary).append(crlf);
            writer.append("Content-Disposition: form-data; name=\"data\"; filename=\"" + fileName + "\"").append(crlf);
            writer.append("Content-Type: " + URLConnection.guessContentTypeFromName(fileName)).append(crlf);
            writer.append("Content-Transfer-Encoding: binary").append(crlf);
            writer.append(crlf);
            writer.flush();
            FileInputStream inputStream = new FileInputStream(file);
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            outputStream.flush();
            inputStream.close();
            writer.append(crlf);
            writer.flush();
            writer.append(crlf).flush();
            writer.append("--" + boundary + "--").append(crlf);
            writer.close();
            connection.disconnect();
            Response response = response(connection);
            if ((response.getCode() == HttpURLConnection.HTTP_ACCEPTED) || (response.getCode() == HttpURLConnection.HTTP_CREATED)) {
                return response;
            }
            throw new Exception(String.format("Error->POST/PUT Metodo: %s, Code: %s, Mensaje: %s", method, response.getCode(), response.getMessage()));

        } catch (IOException e) {
            Log.e(Application.tag, e.getMessage());
            throw e;
        }
    }


    public boolean downloadExcel(String method, String user, String password) throws Exception {
        URL url = new URL(urlServices + method);
        try {
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            prepareConnection(connection, user, password);
            connection.setUseCaches(false);
            connection.setDoInput(true);
            connection.disconnect();
            if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                //descargamos el archivo
                File pathDir = new File(Environment.getExternalStorageDirectory(), "/avatech");
                pathDir.mkdirs();

                File SDCardRoot = new File(Environment.getExternalStorageDirectory() + "/avatech");
                File fileDel = new File(SDCardRoot, Application.excelFile);
                fileDel.deleteOnExit();

                File file = new File(SDCardRoot, Application.excelFile);
                FileOutputStream fileOutput = new FileOutputStream(file);
                InputStream inputStream = connection.getInputStream();

                // create a buffer...
                byte[] buffer = new byte[1024 * 1024];
                int bufferLength = 0;
                while ((bufferLength = inputStream.read(buffer)) > 0) {
                    fileOutput.write(buffer, 0, bufferLength);
                }
                // close the output stream when complete //
                fileOutput.close();
                return true;
            }
            throw new Exception(String.format("Error->GET Metodo: %s, Code: %s, Mensaje: %s", method, connection.getResponseCode(), connection.getResponseMessage()));
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
            throw e;
        }
    }


}
