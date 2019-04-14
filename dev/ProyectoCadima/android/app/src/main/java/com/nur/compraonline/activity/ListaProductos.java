package com.nur.compraonline.activity;

import android.app.Dialog;
import android.app.ProgressDialog;

import android.content.Context;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ListView;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;
import com.nur.compraonline.service.Service;
import com.nur.compraonline.R;
import com.nur.compraonline.data.security.DProducto;
import com.nur.compraonline.data.security.DUser;
import com.nur.compraonline.model.security.DetallePedido;
import com.nur.compraonline.model.security.Empresa;
import com.nur.compraonline.model.security.Pedido;
import com.nur.compraonline.model.security.Producto;
import com.nur.compraonline.model.security.Usuario;
import com.nur.compraonline.util.Util;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class ListaProductos extends AppCompatActivity {

    private List<Producto> productos = new ArrayList<Producto>();
    private ListView list;
    private Empresa empresa;
    private Producto selected;
    private Dialog detailDialog;
    private Dialog dialogDetallePedido;
    private EditText dPrice;
    private EditText dQuantity;
    private TextView dProduct;
    private Button btnDetalle;
    private Button btnCancelar;
    private Button btnEnviar;
    private Pedido objPedido;
    private List<DetallePedido> lstDetallePedido;
    private TextView tvTotal;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lista_productos);
        empresa = (Empresa) getIntent().getExtras().getSerializable("empresa");
        this.setTitle("Lista de Productos - " + empresa.getNombre() );

        objPedido = new Pedido();
        DProducto dal = new DProducto(ListaProductos.this);
        Usuario objUsuario = new DUser(ListaProductos.this).get();
        productos = dal.listByEmpresa(empresa.getEmpresaId());
        list = (ListView) findViewById(R.id.list);
        list.setAdapter(new Adapter(ListaProductos.this, productos));
        lstDetallePedido = new ArrayList<DetallePedido>();
        objPedido.setAtendido(false);
        objPedido.setEmpresaId(empresa.getEmpresaId());
        objPedido.setClienteId(objUsuario.getUsuarioId());
        objPedido.setFecha(new Date());
        btnDetalle = (Button) findViewById(R.id.detalle);
        btnCancelar = (Button) findViewById(R.id.cancel);
        btnEnviar = (Button) findViewById(R.id.send);

        EditText filter = (EditText) findViewById(R.id.filter);
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
        btnDetalle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                loadGrid();
                dialogDetallePedido.show();
            }
        });
        btnCancelar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ListaProductos.this.finish();
            }
        });
        btnEnviar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (Util.isConnectedToWifi(ListaProductos.this)){
                    Process asyncTask = new Process();
                    asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
                }else{
                    Toast.makeText(ListaProductos.this,"No conectado al Wifi!",Toast.LENGTH_SHORT).show();
                }

            }
        });
        initSaleDetail();
        initReporte();
    }
    private void initSaleDetail() {
        detailDialog = new Dialog(ListaProductos.this);
        detailDialog.setContentView(R.layout.dialog_detalle);
        detailDialog.setTitle(getString(R.string.add_product));
        dProduct = (TextView) detailDialog.findViewById(R.id.product);
        dPrice = (EditText) detailDialog.findViewById(R.id.price);
        dQuantity = (EditText) detailDialog.findViewById(R.id.quantity);
        dPrice.setEnabled(false);
        if (selected != null && selected.getId().intValue() > 0){
            dProduct.setText(selected.getNombre());
            dPrice.setText(Util.formatDouble(selected.getPrecio()));
        }
        Button cancel = (Button) detailDialog.findViewById(R.id.cancel);
        cancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                detailDialog.cancel();
                selected = null;
            }
        });

        Button save = (Button) detailDialog.findViewById(R.id.save);
        save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //validamos los datos
                //validamos la cantidad
                //validamos nros
                dQuantity.setText(dQuantity.getText().toString().replaceAll("^\\.|^,", "0."));
                if (!((dQuantity.getText().toString().length() > 0) && (Float.parseFloat(dQuantity.getText().toString().trim()) > 0))) {
                    Toast.makeText(getApplicationContext(), getString(R.string.message_no_quantity), Toast.LENGTH_SHORT).show();
                    return;
                }






                addProduct();
                selected = null;
                detailDialog.dismiss();
            }
        });


    }
    private void initReporte() {
        dialogDetallePedido = new Dialog(ListaProductos.this);
        dialogDetallePedido.setContentView(R.layout.dialog_reporte_pedido);
        dialogDetallePedido.setTitle(getString(R.string.detallepedido));
        tvTotal = (TextView) dialogDetallePedido.findViewById(R.id.total);




    }
    public void loadGrid() {
        TableLayout table = (TableLayout) dialogDetallePedido.findViewById(R.id.table);
        LayoutInflater inflater = getLayoutInflater();
        double total = 0;
        TableRow row;
        table.removeAllViews();
        boolean sw = true;
        TextView txtCode;
        TextView txtName;
        TextView txtPrice;
        TextView txtQuantity;
        TextView txtSubtotal;

        // List<Proforma> lstnuew = dalGasto.list();
        // loadObject();
        for (DetallePedido obj : lstDetallePedido) {
            row = (TableRow) inflater.inflate(R.layout.item_reporte, table, false);
            registerForContextMenu(row);
            row.setBackgroundColor((sw = !sw) ? Color.WHITE : Color.LTGRAY);

            txtCode = (TextView) row.findViewById(R.id.tvFecha);
            // txtDate.setText(dateFormated);
            txtCode.setText(Util.formatDouble(obj.getCantidad()));

            txtName = (TextView) row.findViewById(R.id.tvDescripcion);
            txtName.setText(obj.getProducto().getNombre() );



            txtQuantity = (TextView) row.findViewById(R.id.tvMonto);
            txtQuantity.setText(Util.formatDouble(obj.getPrecio()));

            txtQuantity = (TextView) row.findViewById(R.id.tvSubTotal);
            txtQuantity.setText(Util.formatDouble(obj.getSubTotal()));

            total = total + obj.getSubTotal();
            // row.setTag(R.id.clientCode, obj);
            // row.setTag(R.id.clientName, i);



            row.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {
                    v.requestFocus();
                }
            });

            row.setOnLongClickListener(new View.OnLongClickListener() {

                @Override
                public boolean onLongClick(View v) {
                    v.requestFocus();
                    return true;
                }
            });

            table.addView(row);

        }
        tvTotal.setText(Util.formatDouble(total));
    }
    private boolean addProduct() {
        Producto product = getProduct(selected.getProductoId());
        if (product == null){
                DetallePedido detail = new DetallePedido();
                detail.setProductoId(selected.getProductoId());
                detail.setProducto(selected);
                detail.setCantidad(Double.parseDouble(dQuantity.getText().toString()));
                detail.setPrecio(Double.parseDouble(dPrice.getText().toString()));
                detail.setSubTotal(detail.getCantidad() * (detail.getPrecio()));
                lstDetallePedido.add(detail);
                objPedido.setLstDetalle(lstDetallePedido);

        }else{
            for (DetallePedido detail : lstDetallePedido) {
                if (detail.getProducto().getId().intValue()== product.getProductoId().intValue()) {
                    detail.setCantidad(Double.parseDouble(dQuantity.getText().toString()));
                    detail.setSubTotal(detail.getCantidad() * (detail.getPrecio()) );


                }
            }
        }

        return false;
    }
    private Producto getProduct(long code) {
        for (DetallePedido obj : lstDetallePedido) {
            if (obj.getProducto().getId()==code) {
                return obj.getProducto();
            }
        }
        return null;
    }
    public class Adapter extends ArrayAdapter<Producto> implements Filterable {

        private ItemFilter filter = new ItemFilter();

        private List<Producto> items;

        public Adapter(Context context, List<Producto> registries) {
            super(context, R.layout.empresa_item, registries);
            items = registries;
        }


        public View getView(int position, View convertView, ViewGroup parent) {
            View v = convertView;
            if (v == null) {
                LayoutInflater vi = (LayoutInflater) ListaProductos.this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                v = vi.inflate(R.layout.product_item, null);
            }
            Producto obj = items.get(position);
            ((TextView) v.findViewById(R.id.name)).setText( obj.getNombre());
            ((TextView) v.findViewById(R.id.price)).setText(Util.formatDouble(obj.getPrecio()));

            v.setOnTouchListener(new View.OnTouchListener() {
                @Override
                public boolean onTouch(View view, MotionEvent event) {
                    if (event.getAction() == MotionEvent.ACTION_DOWN) {
                        selected = (Producto) view.getTag();
                        if (selected != null && selected.getId().intValue() > 0){
                            dProduct.setText(selected.getNombre());
                            dPrice.setText(Util.formatDouble(selected.getPrecio()));
                        }

                        detailDialog.show();
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
                int count = productos.size();
                final ArrayList<Producto> nlist = new ArrayList<Producto>(count);
                String filterableString;

                for (int i = 0; i < count; i++) {
                    filterableString = productos.get(i).getNombre();
                    if (filterableString.contains(filterString)) {
                        nlist.add(productos.get(i));
                    }
                }
                results.values = nlist;
                results.count = nlist.size();
                return results;
            }

            @SuppressWarnings("unchecked")
            @Override
            protected void publishResults(CharSequence constraint, FilterResults results) {
                list.setAdapter(new Adapter(ListaProductos.this, (ArrayList<Producto>) results.values));
            }
        }
    }
    private class Process extends AsyncTask<String, Float, Boolean> {


        private ProgressDialog progressDialog;
        private double totalAmount = 0;

        @Override
        protected void onPreExecute() {
            progressDialog = ProgressDialog.show(ListaProductos.this, null, getString(R.string.procesando));
        }

        @Override
        protected Boolean doInBackground(String... params) {
            try {
                Service service = new Service(ListaProductos.this);
                long valor = service.postPedido(objPedido,"","");
                if (valor > 0){
                    return true;
                }

            } catch (Exception ex) {
                return false;
            }
            return false;
        }

        protected void onPostExecute(Boolean result) {
            progressDialog.dismiss();
            if (result) {
               Toast.makeText(ListaProductos.this,"Pedido Enviado Correctamente!",Toast.LENGTH_SHORT).show();
                ListaProductos.this.finish();
            }else{
                Toast.makeText(ListaProductos.this,"Pedido Enviado Correctamente!",Toast.LENGTH_SHORT).show();
                ListaProductos.this.finish();
            }
        }
    }

    }

