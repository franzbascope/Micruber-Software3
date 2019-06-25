package com.example.micruber;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Intent;
import android.icu.util.LocaleData;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ListView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.ServerError;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.micruber.Objetos.Linea;
import com.example.micruber.Objetos.Pago;
import com.example.micruber.Objetos.Usuario;
import com.example.micruber.adapter.ListPagosAdapter;
import com.example.micruber.utiles.Preferences;
import com.example.micruber.utiles.Util;
import com.google.android.gms.tasks.Task;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

public class activityListaPago extends AppCompatActivity {

    ListView listView;
    ProgressDialog progreso;
    FloatingActionButton fab;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lista_pago);
        fab=findViewById(R.id.fabRango);
        listView=findViewById(R.id.lvData);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i=new Intent(activityListaPago.this,rangoPago.class);
                startActivity(i);
                finish();
            }
        });


        Date date =Calendar.getInstance().getTime();
        Calendar cal=Calendar.getInstance();
        cal.add(Calendar.DATE,-1);

        Date dateactual = new Date();
        String modifiedDate= new SimpleDateFormat("yyyy-MM-dd").format(dateactual);

        Usuario usr = Preferences.getUsuario(this);
        Intent intent=getIntent();
        String fechaInicio=intent.getStringExtra("fechaInicio");
        if(fechaInicio==null ){
            llenarList(usr.getUsuarioId(),getYesterdayDateString(),modifiedDate.toString());

        }
        else{
            llenarList(usr.getUsuarioId(),fechaInicio,modifiedDate.toString());

        }




    }


    private Date yesterday() {
        final Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);
        return cal.getTime();
    }
    private String getYesterdayDateString() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(yesterday());
    }



    public void llenarList(int id,String fechaDesde,String fechaHasta) {
        String url =getString(R.string.url_master)+"/obtenerPagosPasajeros/";
        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);

            JSONObject jsonBody = new JSONObject();
            jsonBody.put("usuarioId", id+"");
            jsonBody.put("fechaDesde",fechaDesde);
            jsonBody.put("fechaHasta",fechaHasta);


            progreso = new ProgressDialog(this);
            progreso.setIndeterminate(true);
            progreso.setTitle("Llenando lista...");
            progreso.setCancelable(false);
            progreso.show();

            final String mRequestBody = jsonBody.toString();

            StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    try {
                        //Toast.makeText(LoginActivity.this, response, Toast.LENGTH_LONG).show();
                        if(!response.trim().isEmpty()){
                            JSONArray jsonArray = new JSONArray(response);
                            ArrayList<Pago> listDatos = new ArrayList<>();

                            for (int i = 0; i < jsonArray.length(); i++) {
                                String pagonormal="";
                                String pagodisplay="";
                                JSONObject respuesta = jsonArray.getJSONObject(i);
                                Pago pago = new Pago();
                                pago.setPagoId(respuesta.getInt("usuarioId"));
                                pago.setFechaPago(respuesta.getString("fechaPago"));

                                pagonormal=pago.getFechaPago().substring(0,10);
                                pago.setFechaPago(pagonormal);




                                pago.setConceptoId(respuesta.getInt("conceptoId"));
                                pago.setConceptoDescripcion(respuesta.getString("conceptoDescripcion"));
                                pago.setNumeroLinea(respuesta.getString("numeroLinea"));
                                pago.setEsIngreso(respuesta.getBoolean("esIngreso"));
                                pago.setUsuarioId(respuesta.getInt("usuarioId"));
                                pago.setVehiculoId(respuesta.getInt("vehiculoId"));
                                pago.setFechaPagoForDisplay(respuesta.getString("fechaPagoForDisplay"));
                                pagodisplay=pago.getFechaPagoForDisplay().substring(0,10);
                                pago.setFechaPagoForDisplay(pagodisplay);


                                listDatos.add(pago);


                                progreso.dismiss();
                                }
                            listView.setAdapter(new ListPagosAdapter(activityListaPago.this,listDatos));

                        }
                                else {
                                    Toast.makeText(activityListaPago.this, "Algo malio sal ", Toast.LENGTH_LONG).show();
                                }


                        } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }

                    //progreso.dismiss();

                    // finish();

                }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    progreso.dismiss();

                    if (error instanceof NetworkError) {
                        Util.mostrarDialogoSinInternet(activityListaPago.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        Toast.makeText(activityListaPago.this, "error: "+error, Toast.LENGTH_SHORT).show();
                    }

                    Log.e("LOG_VOLLEY", error.toString());
                }
            }) {
                @Override
                public String getBodyContentType() {
                    return "application/json; charset=utf-8";
                }

                @Override
                public byte[] getBody() throws AuthFailureError {
                    try {
                        return mRequestBody == null ? null : mRequestBody.getBytes("utf-8");
                    } catch (UnsupportedEncodingException uee) {
                        VolleyLog.wtf("Unsupported Encoding while trying to get the bytes of %s using %s", mRequestBody, "utf-8");
                        return null;
                    }
                }
            };
            requestQueue.add(stringRequest);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}
