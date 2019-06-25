package com.example.micruber.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.example.micruber.Objetos.Linea;
import com.example.micruber.R;

import java.util.List;


public class AdaptadorLineas extends RecyclerView.Adapter<AdaptadorLineas.MyViewHolder> {

    private List<Linea> listaLineas;
    private Context contexto;
    private AdaptadorLineas.OnItemClickListener onItemClickListener;

    public void setOnItemClickListener(OnItemClickListener onItemClickListener) {
        this.onItemClickListener = onItemClickListener;
    }

    public AdaptadorLineas(Context contexto, List<Linea> lineas) {
        this.contexto = contexto;
        listaLineas = lineas;
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.layout_item_lineas, parent, false);

        return new MyViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MyViewHolder holder, int position) {
        final Linea obj = listaLineas.get(position);
        holder.tvNroLinea.setText("Linea: " + obj.getNumeroLinea());
        holder.tvTiempo.setText("Tiempo de llegada a destino: " + String.valueOf(obj.getTiempoCaminata() + obj.getTiempoRecorrido()) + " Min.");

        holder.cardView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (onItemClickListener != null) {
                    onItemClickListener.onItemClick(view, obj);
                }
            }
        });
    }

    static class MyViewHolder extends RecyclerView.ViewHolder {

        TextView tvNroLinea;
        TextView tvTiempo;
        CardView cardView;

        MyViewHolder(View v) {
            super(v);
            tvNroLinea = v.findViewById(R.id.tvNroLinea);
            tvTiempo = v.findViewById(R.id.tvTiempo);

            cardView = v.findViewById(R.id.cardView);
        }
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public int getItemCount() {
        return listaLineas.size();
    }

    public interface OnItemClickListener {
        void onItemClick(View view, Linea obj);
    }

}
