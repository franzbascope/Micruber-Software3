package com.example.pagomicruber;

import androidx.appcompat.app.AppCompatActivity;

import android.app.PendingIntent;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.IntentFilter;
import android.nfc.NfcAdapter;
import android.nfc.Tag;
import android.nfc.tech.IsoDep;
import android.nfc.tech.MifareClassic;
import android.nfc.tech.MifareUltralight;
import android.nfc.tech.Ndef;
import android.nfc.tech.NfcA;
import android.nfc.tech.NfcB;
import android.nfc.tech.NfcF;
import android.nfc.tech.NfcV;
import android.os.Bundle;
import android.os.Parcelable;
import android.util.Log;
import android.widget.TextView;
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
import com.example.pagomicruber.utiles.Preferences;
import com.example.pagomicruber.utiles.Util;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;

import static android.content.ContentValues.TAG;

public class RegistrarTarjeta extends AppCompatActivity {

    private TextView et_correo;
    private ProgressDialog progreso;

    private final String[][] techList = new String[][] {
            new String[] {
                    NfcA.class.getName(),
                    NfcB.class.getName(),
                    NfcF.class.getName(),
                    NfcV.class.getName(),
                    IsoDep.class.getName(),
                    MifareClassic.class.getName(),
                    MifareUltralight.class.getName(), Ndef.class.getName()
            }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registrar_tarjeta);

        et_correo = (TextView) findViewById(R.id.et_correo);
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.d("onResume", "1");

        //mTextView.setText("onResume:");
        // creating pending intent:
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, new Intent(this, getClass()).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP), 0);
        // creating intent receiver for NFC events:
        IntentFilter filter = new IntentFilter();
        filter.addAction(NfcAdapter.ACTION_TAG_DISCOVERED);
        filter.addAction(NfcAdapter.ACTION_NDEF_DISCOVERED);
        filter.addAction(NfcAdapter.ACTION_TECH_DISCOVERED);
        // enabling foreground dispatch for getting intent from NFC event:
        NfcAdapter nfcAdapter = NfcAdapter.getDefaultAdapter(this);
        nfcAdapter.enableForegroundDispatch(this, pendingIntent, new IntentFilter[]{filter}, this.techList);
    }

    @Override
    protected void onPause() {
        super.onPause();

        Log.d("onPause", "1");

        // disabling foreground dispatch:
        NfcAdapter nfcAdapter = NfcAdapter.getDefaultAdapter(this);
        nfcAdapter.disableForegroundDispatch(this);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        Log.d("onNewIntent", "1");

        if (intent.getAction().equals(NfcAdapter.ACTION_TAG_DISCOVERED)) {
            Log.d("onNewIntent", "2");
            Parcelable tagN = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG);
            if (tagN != null) {
                dumpTagData(tagN);
            }
            else {
                Log.d(TAG, "Parcelable NULL");
            }
        }
    }

    private void dumpTagData(Parcelable p) {
        String correo = et_correo.getText().toString().trim();
        if(correo.isEmpty()){
            Toast.makeText(RegistrarTarjeta.this, "Debe ingresar su correo", Toast.LENGTH_LONG).show();
            return;
        }
        if(!this.isEmailValid(correo)){
            Toast.makeText(RegistrarTarjeta.this, "Debe ingresar un correo válido", Toast.LENGTH_LONG).show();
            return;
        }
        //DENAR
        Tag tag = (Tag) p;
        byte[] id = tag.getId();
        String codigoNFC = getHex(id).replaceAll(" ", "");
        //Toast.makeText(RegistrarTarjeta.this, codigoNFC, Toast.LENGTH_LONG).show();
        registrarNFC(correo, codigoNFC);
        //mTextView.setText(codigo);
    }


    private String getHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (int i = bytes.length - 1; i >= 0; --i) {
            int b = bytes[i] & 0xff;
            if (b < 0x10)
                sb.append('0');
            sb.append(Integer.toHexString(b));
            if (i > 0) {
                sb.append(" ");
            }
        }
        return sb.toString();
    }
    private boolean isEmailValid(String email) {
        //TODO: Replace this with your own logic
        return email.contains("@");
    }

    public void registrarNFC(String correo, String codigoNFC) {
        String url = getString(R.string.url_master) + "/usuarios/linkNFC";
        try {
            RequestQueue requestQueue = Volley.newRequestQueue(this);

            JSONObject jsonBody = new JSONObject();
            jsonBody.put("correo", correo);
            jsonBody.put("codigoNFC", codigoNFC);

            progreso = new ProgressDialog(this);
            progreso.setIndeterminate(true);
            progreso.setTitle("Enviando datos...");
            progreso.setCancelable(false);
            progreso.show();

            final String mRequestBody = jsonBody.toString();

            StringRequest stringRequest = new StringRequest(Request.Method.POST, url, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    //Toast.makeText(LoginActivity.this, response, Toast.LENGTH_LONG).show();
                    if (!response.trim().isEmpty()) {
                        int estado = Integer.parseInt(response);
                        if (estado != 1) {
                            Toast.makeText(RegistrarTarjeta.this, "No se pudo registrar la tarjeta", Toast.LENGTH_LONG).show();
                        }else{
                            progreso.dismiss();
                            Toast.makeText(RegistrarTarjeta.this, "Tarjeta registrada con éxito", Toast.LENGTH_LONG).show();
                            finish();
                        }
                    } else {
                        Toast.makeText(RegistrarTarjeta.this, "Hubo un problema al registrar la tarjeta", Toast.LENGTH_LONG).show();
                    }

                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    progreso.dismiss();

                    if (error instanceof NetworkError) {
                        Util.mostrarDialogoSinInternet(RegistrarTarjeta.this);
                    } else if (error instanceof TimeoutError) {

                    } else if (error instanceof ServerError) {
                        Toast.makeText(RegistrarTarjeta.this, "Hubo un problema", Toast.LENGTH_SHORT).show();
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
