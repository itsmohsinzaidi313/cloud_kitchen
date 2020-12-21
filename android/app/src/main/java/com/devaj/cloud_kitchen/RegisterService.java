package com.devaj.cloud_kitchen;

import android.app.Service;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Handler;
import android.os.IBinder;
import android.util.Log;

import androidx.core.app.NotificationCompat;

public class RegisterService extends Service {
    public RegisterService() {
    }

    @Override
    public void onCreate() {
        super.onCreate();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationCompat.Builder builder = new NotificationCompat.Builder(RegisterService.this, "register")
                    .setContentText("RegisterOpen service is running background")
                    .setContentTitle("Cloud Kitchen");
            try {
                startForeground(1, builder.build());
            } catch (Exception e) {
                Log.e("Order Service", e.getMessage());
            }
        }
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {

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
//                    public void onResponse(Call<List<Post>> call, ServerResponse<List<Post>> response) {
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
        return super.onStartCommand(intent, flags, startId);
    }

    private static class BackTask extends AsyncTask {
        @Override
        protected Object doInBackground(Object[] objects) {

            return null;
        }
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
