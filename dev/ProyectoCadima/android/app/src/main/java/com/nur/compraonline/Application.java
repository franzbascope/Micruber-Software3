package com.nur.compraonline;


import android.content.Context;
import android.location.Location;
import android.util.Log;

public class Application extends android.app.Application {

    public final static String tag = "SuiteProformas";
    public final static String databaseName = "megasystem";
    public final static String apkName = "proforma.apk";
    public final static String excelFile = "profroma.xls";
    public final static String webServicesPrivate = "http://192.168.43.226/pedidosnur";
    public final static String webServicesPublic = "http://192.168.43.226/pedidosnur";
    public final static String downloadUrl = "http://192.168.1.201/download";
    public final static String formatDate = "yyyy-MM-dd'T'HH:mm:ss";
    public final static String formatDateShort = "yyyy-MM-dd";
    public final static String formatLatinDateShort = "dd/MM/yyyy";
    public final static int locationUpdateTime = 900000;
    public final static int locationMinDistance = 0;
    public final static int timeout = 60000;

    public Location myLocation;

    private static Application instance = null;

    public static Application getInstance() {
        if (instance == null) {
            instance = new Application();
        }
        return instance;
    }
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);

    }
    @Override
    public void onCreate() {
        super.onCreate();
        Log.i(Application.tag, getString(R.string.app_name));
        Thread.setDefaultUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() {
            @Override
            public void uncaughtException(Thread thread, Throwable e) {
                handleUncaughtException(thread, e);
            }
        });
      //  Multidex.install(this);

    }

    @Override
    public void onTerminate() {
        super.onTerminate();
    }

    public void handleUncaughtException(Thread thread, Throwable e) {
        e.printStackTrace();
        Log.e(Application.tag, e.getMessage());
        System.exit(1);
    }
}
