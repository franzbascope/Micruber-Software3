package com.nur.compraonline.activity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.support.v7.app.AppCompatActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.beardedhen.androidbootstrap.FontAwesomeText;
import com.nur.compraonline.R;
import com.nur.compraonline.component.Menu;
import com.nur.compraonline.model.security.Usuario;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.channels.FileChannel;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;


public class Inicio extends AppCompatActivity {

    private List<Menu> items = new ArrayList<Menu>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_inicio);

        getSupportActionBar().setTitle(getResources().getString(R.string.inicio));



        items.add(new Menu(R.string.ingresar, R.string.ingresar, "fa-copy"));
        items.add(new Menu(R.string.register, R.string.register, "fa-database"));

        ListView listView = (ListView) findViewById(R.id.menu);
        listView.setAdapter(new IconAdapter());

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Menu item = items.get(i);
                Intent intent = null;
                switch (item.getId()) {

                    case R.string.ingresar:
                        intent = new Intent(Inicio.this,Login.class);
                        startActivity(intent);
                        break;
                    case R.string.register:
                        intent = new Intent(Inicio.this,Register.class);
                        startActivity(intent);
                        break;

                }
            }
        });
    }







    public class IconAdapter extends BaseAdapter {

        public int getCount() {
            return items.size();
        }

        public Menu getItem(int position) {
            return items.get(position);
        }

        public long getItemId(int position) {
            return 0;
        }


        public View getView(int position, View convertView, ViewGroup parent) {
            View v = convertView;
            if (v == null) {
                LayoutInflater vi = (LayoutInflater) getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                v = vi.inflate(R.layout.menu_item, null);
            }
            Menu item = items.get(position);
            TextView text = (TextView) v.findViewById(R.id.text);
            FontAwesomeText icon = (FontAwesomeText) v.findViewById(R.id.icon);
            icon.setIcon(item.getIcon());
            text.setText(item.getLabel());
            return v;
        }
    }



}
