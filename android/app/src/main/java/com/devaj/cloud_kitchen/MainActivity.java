package com.devaj.cloud_kitchen;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String ORDER_UPLOAD_CHANNEL = "com.devaj.cloudKitchen/orderService";
    private static final String SHIFT_CHANNEL = "com.devaj.cloudKitchen/registerService";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel("orders", "OrderService", NotificationManager.IMPORTANCE_DEFAULT);
            NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
            manager.createNotificationChannel(channel);
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel("register", "RegisterService", NotificationManager.IMPORTANCE_DEFAULT);
            NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
            manager.createNotificationChannel(channel);
        }
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), ORDER_UPLOAD_CHANNEL).setMethodCallHandler((call, result) -> {
            if (call.method.equals("start")) {

                SQLiteDatabase db = SQLiteDatabase.openOrCreateDatabase(getDatabasePath("CloudKitchen.db"), null);
                Cursor cursor = db.rawQuery("select * from users", null);
                cursor.moveToFirst();
                while (cursor.moveToNext()) {
                    Log.d("Database", "FullName: " + cursor.getString(cursor.getColumnIndex("full_name")) + "\n");
                }
//                Retrofit retrofit = new Retrofit.Builder().baseUrl("https://jsonplaceholder.typicode.com/").addConverterFactory(GsonConverterFactory.create()).build();
//                JsonPlaceholder jsonPlaceholder = retrofit.create(JsonPlaceholder.class);
//                Call<List<Post>> getCall = jsonPlaceholder.getPosts();
//                getCall.enqueue(new Callback<List<Post>>() {
//                    @Override
//                    public void onResponse(Call<List<Post>> call, Response<List<Post>> response) {
//                        if(!response.isSuccessful()) {
//                            Log.d("Retrofit", "Code: " + response.code());
//                            return;
//                        }
//                        List<Post> posts = response.body();
//                        for(Post post : posts) {
//                            String content =  "";
//                            content += "ID: " + post.getId() + "\n";
//                            content += "User ID: " + post.getUserId() + "\n";
//                            content += "Title: " + post.getTitle() + "\n";
//                            content += "Text: " + post.getText() + "\n";
//                            Log.d("Retrofit", content);
//                        }
//                    }
//
//                    @Override
//                    public void onFailure(Call<List<Post>> call, Throwable t) {
//                        Log.e("Retrofit", t.getMessage());
//                        result.error("1", t.getMessage(),null);
//                    }
//                });
                result.success("started");

            } else if (call.method.equals("stop")) {

            } else {

            }
        });

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), SHIFT_CHANNEL).setMethodCallHandler((call, result) -> {
            if (call.method.equals("start")) {

            } else if (call.method.equals("stop")) {

            } else {

            }
        });
    }
}
