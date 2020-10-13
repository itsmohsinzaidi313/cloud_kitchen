package com.devaj.cloud_kitchen;

import android.util.Log;

public class Config {
    private static String orderUploadApi = "";
    private static String openRegisterApi = "";
    private static String closeRegisterApi = "";

    public static String getOrderUploadApi() {
        return orderUploadApi;
    }

    public static void setOrderUploadApi(String orderUploadApi) {
        Log.i("Android Config", "OrderUploadApi Updated " + orderUploadApi);
        Config.orderUploadApi = orderUploadApi;
    }

    public static String getOpenRegisterApi() {
        return openRegisterApi;
    }

    public static void setOpenRegisterApi(String openRegisterApi) {
        Log.i("Android Config", "openRegisterApi Updated " + openRegisterApi);
        Config.openRegisterApi = openRegisterApi;
    }

    public static String getCloseRegisterApi() {
        return closeRegisterApi;
    }

    public static void setCloseRegisterApi(String closeRegisterApi) {
        Log.i("Android Config", "closeRegisterApi Updated " + closeRegisterApi);
        Config.closeRegisterApi = closeRegisterApi;
    }
}
