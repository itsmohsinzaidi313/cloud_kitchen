package com.devaj.cloud_kitchen;

import android.app.Service;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

import java.util.TimerTask;

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
    TimerTask timerTask = new TimerTask() {
        @Override
        public void run() {
            
        }
    };

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {

        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
