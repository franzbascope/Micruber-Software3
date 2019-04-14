package com.nur.compraonline.activity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ListView;
import android.widget.TextView;

import com.beardedhen.androidbootstrap.FontAwesomeText;
import com.nur.compraonline.R;
import com.nur.compraonline.component.Menu;
import com.nur.compraonline.data.security.DEmpresa;
import com.nur.compraonline.data.security.DUser;
import com.nur.compraonline.model.security.Empresa;

import java.util.ArrayList;
import java.util.List;


public class ListaEmpresas extends AppCompatActivity {

    private List<Empresa> empresas = new ArrayList<Empresa>();
    private ListView list;
    private Empresa selected;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lista_empresas);
        this.setTitle("Lista de Empresas");
        DEmpresa dal = new DEmpresa(ListaEmpresas.this);
        empresas = dal.list();
        list = (ListView) findViewById(R.id.list);
        list.setAdapter(new Adapter(ListaEmpresas.this, empresas));
        EditText filter = (EditText) findViewById(R.id.filter);
        FontAwesomeText logOut =(FontAwesomeText) findViewById(R.id.icon);
        logOut.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                new AlertDialog.Builder(ListaEmpresas.this).setTitle(null).setMessage(R.string.message_close_sesion).setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        DUser dal = new DUser(ListaEmpresas.this);
                        dal.clean();
                        Intent intent = new Intent(ListaEmpresas.this,Inicio.class);
                        startActivity(intent);
                    }
                }).setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {

                    }
                }).setIcon(android.R.drawable.ic_dialog_alert).show();
            }
        });
        filter.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                ((Adapter) list.getAdapter()).getFilter().filter(charSequence.toString());
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });

    }
    @Override
    public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, view, menuInfo);
        menu.setHeaderTitle(selected.getNombre());
        MenuInflater inflater = ListaEmpresas.this.getMenuInflater();
        inflater.inflate(R.menu.menu_empresas, menu);
    }
    @Override
    public void onBackPressed() {
        new AlertDialog.Builder(this).setTitle(null).setMessage(R.string.message_close).setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                finish();
            }
        }).setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {

            }
        }).setIcon(android.R.drawable.ic_dialog_alert).show();
    }
    @Override
    public boolean onContextItemSelected(MenuItem item) {


            switch (item.getItemId()) {
                case R.id.pedido: {
                    Intent intent = new Intent(ListaEmpresas.this,ListaProductos.class);
                    intent.putExtra("empresa", selected);
                    startActivity(intent);
                    break;
                }

            }

            return true;
    }


    public class Adapter extends ArrayAdapter<Empresa> implements Filterable {

        private ItemFilter filter = new ItemFilter();

        private List<Empresa> items;

        public Adapter(Context context, List<Empresa> registries) {
            super(context, R.layout.empresa_item, registries);
            items = registries;
        }


        public View getView(int position, View convertView, ViewGroup parent) {
            View v = convertView;
            if (v == null) {
                LayoutInflater vi = (LayoutInflater) ListaEmpresas.this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                v = vi.inflate(R.layout.empresa_item, null);
            }
            Empresa obj = items.get(position);
            ((TextView) v.findViewById(R.id.name)).setText("[" + obj.getNit() + "] " + obj.getNombre());
            ((TextView) v.findViewById(R.id.address)).setText(obj.getTelefono());

            v.setOnTouchListener(new View.OnTouchListener() {
                @Override
                public boolean onTouch(View view, MotionEvent event) {
                    if (event.getAction() == MotionEvent.ACTION_UP) {
                        selected = (Empresa) view.getTag();
                        registerForContextMenu(view);
                        ListaEmpresas.this.openContextMenu(view);
                        unregisterForContextMenu(view);
                        return true;
                    }
                    return false;
                }
            });

            v.setTag(obj);

            return v;
        }

        public Filter getFilter() {
            return filter;
        }

        private class ItemFilter extends Filter {

            @Override
            protected FilterResults performFiltering(CharSequence constraint) {

                String filterString = constraint.toString().toUpperCase();
                FilterResults results = new FilterResults();
                int count = empresas.size();
                final ArrayList<Empresa> nlist = new ArrayList<Empresa>(count);
                String filterableString;

                for (int i = 0; i < count; i++) {
                    filterableString = empresas.get(i).getNombre();
                    if (filterableString.contains(filterString)) {
                        nlist.add(empresas.get(i));
                    }
                }
                results.values = nlist;
                results.count = nlist.size();
                return results;
            }

            @SuppressWarnings("unchecked")
            @Override
            protected void publishResults(CharSequence constraint, FilterResults results) {
                list.setAdapter(new Adapter(ListaEmpresas.this, (ArrayList<Empresa>) results.values));
            }
        }
    }


    }

