package com.nur.compraonline.util;


import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.widget.DatePicker;


import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Calendar;
import java.util.Date;



public class Util {



    public static boolean isConnectedToWifi(Context context) {
        ConnectivityManager connectivityManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo networkInfo = null;
        if (connectivityManager != null) {
            networkInfo = connectivityManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI);
        }
        return networkInfo == null ? false : networkInfo.isConnected();
    }



    public static double Round(double Rval, int Rpl) {
        double p = (double) Math.pow(10, Rpl);
        Rval = Rval * p;
        double tmp = Math.round(Rval);
        return (double) tmp / p;
    }

    public static int getDecimal(String str) {
        int value = 0;
        if (str != null && !str.isEmpty()) {
            str = str.replace(",", ".");
            if (str.indexOf(".") > 0) {
                str = str.substring(str.indexOf(".") + 1);
            } else {
                str = "0";
            }
            value = Integer.parseInt(str);
        }

        return value;
    }

    public static String formatDouble(double dbl) {
        String doubleString = "";
        DecimalFormatSymbols dfs= DecimalFormatSymbols.getInstance();
        dfs.setDecimalSeparator('.');
        DecimalFormat format = new DecimalFormat("#.00",dfs);
        doubleString = format.format(Math.round(dbl * 100) / 100d);
        if (dbl < 1) {
            doubleString = "0" + doubleString;
        }
        return doubleString;
    }


    public static String formatDoubleHundred(double dbl) {
        String doubleString = "";
        DecimalFormat format = new DecimalFormat("###,###.00");
        doubleString = format.format(Math.round(dbl * 100) / 100d);
        if (dbl < 1) {
            doubleString = "0" + doubleString;
        }
        return doubleString;
    }


    public static Date getDateFromDatePicket(DatePicker datePicker) {
        int day = datePicker.getDayOfMonth();
        int month = datePicker.getMonth();
        int year = datePicker.getYear();

        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month, day);

        return calendar.getTime();
    }
    public static double getValue(String str) {
        double value = 0;
        if (str != null && !str.isEmpty()) {
            str = str.replace(",", ".");
            value = Double.parseDouble(str);
        }
        return value;
    }
}
