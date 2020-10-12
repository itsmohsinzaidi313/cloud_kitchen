package com.devaj.cloud_kitchen;

import android.app.Service;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

import androidx.core.app.NotificationCompat;

public class OrdersService extends Service {
    public OrdersService() {
    }

    @Override
    public void onCreate() {
        super.onCreate();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationCompat.Builder builder = new NotificationCompat.Builder(OrdersService.this, "orders")
                    .setContentText("Orders service is running background")
                    .setContentTitle("Cloud Kitchen");
            try {
                startForeground(1, builder.build());
            } catch (Exception e) {
                Log.e("Order Service", e.getMessage());
            }
        }
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
