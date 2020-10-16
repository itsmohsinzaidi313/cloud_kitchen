package com.devaj.cloud_kitchen;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import java.util.List;
import java.util.Map;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String ORDER_UPLOAD_CHANNEL = "com.devaj.cloudKitchen/orderService";
    private static final String SHIFT_CHANNEL = "com.devaj.cloudKitchen/registerService";
    private static final String CONFIG_CHANNEL = "com.devaj.cloudKitchen/config";

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

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CONFIG_CHANNEL).setMethodCallHandler((call, result) -> {
            try {
                if (call.method.equals("init")) {
                    List<Map<String, String>> map = call.arguments();
                    if (map.size() > 0) {
                        Config.setOrderUploadApi(map.get(0).get("addUpdateOrderApi"));
                        Config.setOpenRegisterApi(map.get(0).get("openRegisterApi"));
                        Config.setCloseRegisterApi(map.get(0).get("closeRegisterApi"));
                        Log.i("Config", "Api(s) Configured");
                    } else {
                        Log.w("Config", "Api(s) were not configured");
                    }
                } else {

                }
            } catch (Exception e) {
                Log.e("Config", e.getMessage());
            }
        });
    }
}
