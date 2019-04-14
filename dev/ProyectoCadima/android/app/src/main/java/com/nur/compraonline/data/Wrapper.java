package com.nur.compraonline.data;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.text.TextUtils;
import android.util.Log;

import com.googlecode.openbeans.PropertyDescriptor;
import com.nur.compraonline.Application;
import com.nur.compraonline.model.Action;
import com.nur.compraonline.model.Entity;
import com.nur.compraonline.model.annotation.Ignore;
import com.nur.compraonline.model.annotation.Key;
import com.nur.compraonline.model.annotation.Nullable;
import com.nur.compraonline.model.security.Clasificadores;
import com.nur.compraonline.model.security.DetallePedido;
import com.nur.compraonline.model.security.Empresa;
import com.nur.compraonline.model.security.Pedido;
import com.nur.compraonline.model.security.Producto;
import com.nur.compraonline.model.security.Usuario;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import joquery.CQ;
import joquery.Grouping;
import joquery.ResultTransformer;
import joquery.core.QueryException;


public abstract class Wrapper<T> extends SQLiteOpenHelper {
    protected Class<T> type;
    private SQLiteDatabase connection = null;
    protected String tableName;
    private List<Field> listFields;
    protected Context context;
    private DateFormat dateFormat;
    private static int versionDataBase = 1;


    public Wrapper(Context context, Class<T> type) {
        super(context, Application.databaseName + ".db", null, versionDataBase);
        this.type = type;
        this.context = context;
        tableName = getTableName(type);
        listFields = getListField(type);
        dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.US);

    }

    public Wrapper(Context context) {
        super(context, Application.databaseName + ".db", null, versionDataBase);
        this.context = context;
        dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.US);

    }

    public Wrapper(Context context, SQLiteDatabase connection, Class<T> type) {
        super(context, Application.databaseName + ".db", null, versionDataBase);
        this.connection = connection;
        this.type = type;
        tableName = getTableName(type);
        listFields = getListField(type);
        dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.US);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        updateScripts(db);
    }

    private void updateScripts(SQLiteDatabase db) {
        try {
            List<String> tables = new ArrayList<String>();
            Cursor cursor = db.rawQuery("SELECT * FROM sqlite_master WHERE type='table';", null);
            cursor.moveToFirst();
            while (!cursor.isAfterLast()) {
                String tableName = cursor.getString(1);
                if (!tableName.equals("android_metadata") && !tableName.equals("sqlite_sequence")) {
                    tables.add(tableName);
                }
                cursor.moveToNext();
            }
            cursor.close();
            for (String tableName : tables) {
                db.execSQL("DROP TABLE IF EXISTS " + tableName);
            }
            createScripts(db);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        createScripts(db);
    }

    private void createScripts(SQLiteDatabase db) {

        //Security
        db.execSQL(getCreate(Usuario.class));
        db.execSQL(getCreate(Empresa.class));
        db.execSQL(getCreate(Producto.class));
        db.execSQL(getCreate(Clasificadores.class));
        db.execSQL(getCreate(Pedido.class));
        db.execSQL(getCreate(DetallePedido.class));
    }

    public <T extends Entity> String extract(List<T> list, String metodo) throws QueryException {
        List<Grouping<Object, T>> grouped = (List<Grouping<Object, T>>) CQ
                .<T, T>query(list).group().groupBy(metodo).list();
        String key = CQ
                .<Grouping<Object, T>, Object>query()
                .from(grouped)
                .transformDirect(
                        new ResultTransformer<Grouping<Object, T>, Object>() {
                            @Override
                            public Object transform(Grouping<Object, T> arg0) {
                                return arg0.getKey();
                            }
                        }).list().toString().replaceAll("\\[|\\]", "");
        return "(" + ((key.isEmpty()) ? "0" : key) + ")";

    }

    protected List<Map> loadGenerigMap(String strQuery) {
        List<Map> lstResult = new ArrayList<Map>();
        Map obj;
        SQLiteDatabase objDb = this.getReadableDatabase();
        Cursor cursor = null;
        try {
            cursor = objDb.rawQuery(strQuery, new String[]{});
            if (cursor != null) {
                while (cursor.moveToNext()) {
                    obj = new HashMap();
                    for (int index = 0; index < cursor.getColumnCount(); index++) {
                        obj.put(cursor.getColumnName(index),
                                cursor.getString(index));
                    }
                    lstResult.add(obj);
                }
                cursor.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
        objDb.close();
        this.close();
        return lstResult;
    }

    private List<Field> getListField(Class<T> type) {
        Field[] superFields = type.getSuperclass().getDeclaredFields();
        Field[] fields = type.getDeclaredFields();
        List<Field> listFields = new ArrayList<Field>();
        for (Field field : superFields) {
            if (!isIgnore(field)) {
                listFields.add(field);
            }
        }
        for (Field field : fields) {
            if (!isIgnore(field)) {
                listFields.add(field);
            }
        }
        return listFields;
    }

    public String getTableName(Class<T> type) {
        String namePackage = type.getPackage().getName();
        return namePackage.substring(namePackage.lastIndexOf(".") + 1, namePackage.length()) + "_" + type.getSimpleName().toLowerCase();

    }


    public boolean clean() {
        SQLiteDatabase objDb = this.getWritableDatabase();
        try {
            objDb.beginTransaction();
            objDb.delete(tableName, "", new String[]{});
            objDb.setTransactionSuccessful();
            return true;
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
        } finally {
            objDb.endTransaction();
            objDb.close();
        }
        return false;
    }

    public boolean clean(String where) {
        SQLiteDatabase objDb = this.getWritableDatabase();
        try {
            objDb.beginTransaction();
            objDb.execSQL("delete from " + tableName + " where " + where);
            objDb.setTransactionSuccessful();
            return true;
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
        } finally {
            objDb.endTransaction();
            objDb.close();
        }
        return false;
    }

    private static boolean isIgnore(Field field) {
        return field.getAnnotation(Ignore.class) != null;
    }

    public boolean save(List<Entity> list, Action action) {
        for (Entity entity : list) {
            entity.setAction(action);
            if (!save(entity)) {
                return false;
            }
        }
        return true;
    }


    public boolean save(Entity entity) {
        if (entity.getAction().equals(Action.None)) {
            Log.e(Application.tag, "No se asigno una accion a la entidad");
            return false;
        }
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues values;
        long resultId = -1;
        try {
            db.beginTransaction();
            if (entity.getAction() == Action.Delete) {
                resultId = db.delete(tableName, "id=?", new String[]{Long.toString(entity.getId())});
            } else {
                values = new ContentValues();
                for (Field field : listFields) {
                    PropertyDescriptor prop;
                    try {
                        prop = new PropertyDescriptor(field.getName(), entity.getClass());
                    } catch (NullPointerException e) {
                        prop = new PropertyDescriptor(field.getName(), entity.getClass().getSuperclass());
                    }
                    Method method = prop.getReadMethod();
                    Object value = method.invoke(entity);
                    if (value != null) {
                        if (field.getType().equals(Date.class)) {
                            values.put(field.getName(), dateFormat.format(value));
                        } else {
                            values.put(field.getName(), value.toString());
                        }
                    }
                }
                if (entity.getAction().equals(Action.Insert)) {
                    resultId = db.insert(tableName, null, values);
                    entity.setId(resultId);

                } else if (entity.getAction().equals(Action.Update)) {
                    resultId = db.update(tableName, values, "id=?", new String[]{Long.toString(entity.getId())});
                }
            }
            if (resultId == -1) {
                return false;
            }
            db.setTransactionSuccessful();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            db.endTransaction();
            db.close();
        }
    }

    private boolean save(Entity entity, SQLiteDatabase db) {

        ContentValues values;
        long resultid = -1;
        try {
            if (entity.getAction() == Action.Delete) {
                resultid = db.delete(tableName, "id=?", new String[]{Long.toString(entity.getId())});
            } else {
                values = new ContentValues();
                for (Field field : listFields) {
                    PropertyDescriptor prop;
                    try {
                        prop = new PropertyDescriptor(field.getName(), entity.getClass());
                    } catch (NullPointerException e) {
                        prop = new PropertyDescriptor(field.getName(), entity.getClass().getSuperclass());
                    }
                    Method method = prop.getReadMethod();
                    Object value = method.invoke(entity);
                    if (value != null) {
                        values.put(field.getName(), value.toString());
                    }
                }
                if (entity.getAction().equals(Action.Insert)) {
                    resultid = db.insert(tableName, null, values);
                    entity.setId(resultid);

                } else if (entity.getAction().equals(Action.Update)) {

                    resultid = db.update(tableName, values, "id=?", new String[]{Long.toString(entity.getId())});
                }
            }
            if (resultid == -1) {
                return false;
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;

        }
    }


    public static <T extends Entity> String getCreate(Class<T> type) {
        String namePackage = type.getPackage().getName();
        String tableName = namePackage.substring(namePackage.lastIndexOf(".") + 1, namePackage.length()) + "_" + type.getSimpleName().toLowerCase();

        Field[] superFields = type.getSuperclass().getDeclaredFields();
        Field[] fields = type.getDeclaredFields();
        List<Field> listFields = new ArrayList<Field>();
        listFields.addAll(Arrays.asList(superFields));
        listFields.addAll(Arrays.asList(fields));

        List<Object> columns = new ArrayList<Object>();
        StringBuilder builder = new StringBuilder();
        builder.append("CREATE TABLE ");
        builder.append(tableName);
        String typeField = "";
        try {
            for (Field field : listFields) {
                if (!(field.getName().equals("action"))) {
                    if ((!isIgnore(field)) && (!field.isSynthetic())) {
                        if (field.getAnnotation(Key.class) != null) {
                            columns.add(field.getName() + " integer NOT NULL PRIMARY KEY AUTOINCREMENT");
                            continue;
                        }
                        if (field.getType().equals(Double.class)) {
                            typeField = "NUMERIC";
                        } else if (field.getType().equals(Float.class)) {
                            typeField = "FLOAT";
                        } else if (field.getType().equals(Integer.class)) {
                            typeField = "INTEGER";
                        } else if (field.getType().equals(Date.class)) {
                            typeField = "DATETIME";
                        } else {
                            typeField = "TEXT";
                        }
                        if (field.getAnnotation(Nullable.class) != null) {
                            columns.add(field.getName() + " " + typeField);
                            continue;
                        }
                        columns.add(field.getName() + " " + typeField + " NOT NULL");
                    }
                }

            }
            builder.append(concatKeys(columns));
            return builder.toString();
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
        }
        return "";
    }

    protected List<T> list(String query) {
        List<T> lstResult = new ArrayList<T>();
        SQLiteDatabase objDb = this.getReadableDatabase();
        Cursor cursor = null;
        try {
            cursor = objDb.rawQuery(query, new String[]{});
            if (cursor != null) {
                while (cursor.moveToNext()) {
                    lstResult.add((T) this.load(cursor));
                }
                cursor.close();
            }
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
        objDb.close();
        this.close();
        return lstResult;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    protected List<Map> genericList(String strQuery) {
        List<Map> lstResult = new ArrayList<Map>();
        Map obj;
        SQLiteDatabase objDb = this.getReadableDatabase();
        Cursor cursor = null;
        try {
            cursor = objDb.rawQuery(strQuery, new String[]{});
            if (cursor != null) {
                while (cursor.moveToNext()) {
                    obj = new HashMap();
                    for (int index = 0; index < cursor.getColumnCount(); index++) {
                        obj.put(cursor.getColumnName(index), cursor.getString(index));
                    }
                    lstResult.add(obj);
                }
                cursor.close();
            }
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
        } finally {
            if (cursor != null) {
                cursor.close();
            }

        }
        objDb.close();
        this.close();
        return lstResult;
    }

    public T load(Cursor cursor) {
        T obj = null;
        try {
            obj = (T) type.newInstance();

            for (Field field : listFields) {
                PropertyDescriptor prop;
                try {
                    prop = new PropertyDescriptor(field.getName(), obj.getClass());
                } catch (NullPointerException e) {
                    prop = new PropertyDescriptor(field.getName(), obj.getClass().getSuperclass());
                }
                Method method = prop.getWriteMethod();

                if (method != null) {
                    Type type = field.getGenericType();
                    if (type.toString().equals(String.class.toString())) {
                        String value = cursor.getString(cursor.getColumnIndex(field.getName()));
                        method.invoke(obj, new Object[]{value});
                    } else if (type.toString().equals(Long.class.toString())) {
                        Long value = null;
                        if (!cursor.isNull(cursor.getColumnIndex(field.getName()))) {
                            value = cursor.getLong(cursor.getColumnIndex(field.getName()));
                        }
                        method.invoke(obj, new Object[]{value});
                    } else if (type.toString().equals(Integer.class.toString())) {
                        Integer value = null;
                        if (!cursor.isNull(cursor.getColumnIndex(field.getName()))) {
                            value = cursor.getInt(cursor.getColumnIndex(field.getName()));
                        }
                        method.invoke(obj, new Object[]{value});
                    } else if (type.toString().equals(Double.class.toString())) {
                        Double value = null;
                        if (!cursor.isNull(cursor.getColumnIndex(field.getName()))) {
                            value = cursor.getDouble(cursor.getColumnIndex(field.getName()));
                        }
                        method.invoke(obj, new Object[]{value});
                    } else if (type.toString().equals(Boolean.class.toString())) {
                        Boolean value = false;
                        if (!cursor.isNull(cursor.getColumnIndex(field.getName()))) {
                            value = Boolean.parseBoolean(cursor.getString(cursor.getColumnIndex(field.getName())));
                        }
                        method.invoke(obj, new Object[]{value});
                    } else if (type.toString().equals(Date.class.toString())) {
                        String value = cursor.getString(cursor.getColumnIndex(field.getName()));
                        if (value != null) {
                            Date dateValue = dateFormat.parse(value);
                            method.invoke(obj, new Object[]{dateValue});
                        }

                    }
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
        return (T) obj;
    }

    protected static String concatKeys(List<Object> Llaves) {
        return ((Llaves.size() > 0) ? "(" + TextUtils.join(", ", Llaves) + ")" : "(o)");
    }

    public T get(String strQuery) {
        SQLiteDatabase objDb = this.getReadableDatabase();
        Cursor cursor = null;
        T entity = null;
        try {
            entity = type.newInstance();
            cursor = objDb.rawQuery(strQuery, new String[]{});
            if (cursor != null) {
                while (cursor.moveToNext()) {
                    entity = (T) this.load(cursor);
                }
                cursor.close();
            }
        } catch (Exception e) {
            Log.e(Application.tag, e.getMessage());
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
        objDb.close();
        this.close();
        return (T) entity;
    }

    public T get(long id) {
        return get("select * from " + tableName + " where id=" + id);
    }


    public SQLiteDatabase getConnection() {
        return connection;
    }

    public void setConnection(SQLiteDatabase connection) {
        this.connection = connection;
    }

    public void openTransaction() {
        connection = this.getWritableDatabase();
        connection.beginTransaction();
    }

    public void transactionSuccesfully() {
        connection.setTransactionSuccessful();
    }

    public void closeTransaction() {
        connection.endTransaction();
        connection.close();
    }

    public <T extends Entity> String extractFromString(List<T> list, String metodo) throws QueryException {
        List<Grouping<Object, T>> grouped = (List<Grouping<Object, T>>) CQ
                .<T, T>query(list).group().groupBy(metodo).list();
        String key = CQ
                .<Grouping<Object, T>, Object>query()
                .from(grouped)
                .transformDirect(
                        new ResultTransformer<Grouping<Object, T>, Object>() {
                            @Override
                            public Object transform(Grouping<Object, T> arg0) {
                                return arg0.getKey();
                            }
                        }).list().toString().replaceAll("\\[|\\]", "");
        return "('" + ((key.isEmpty()) ? "0" : key) + "')";

    }


}