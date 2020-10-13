package com.devaj.cloud_kitchen;

import com.google.gson.annotations.SerializedName;

class RegisterOpen {
    @SerializedName("device_key")
    private String deviceKey;
    @SerializedName("remote_id")
    private String remoteId;
    @SerializedName("register_no")
    private String registerNo;
    @SerializedName("opening_balance")
    private String openingBalance;
    @SerializedName("opening_balance_date_time")
    private String openingDateTime;

    public RegisterOpen(String deviceKey, String remoteId, String registerNo, String openingBalance, String openingDateTime) {
        this.deviceKey = deviceKey;
        this.remoteId = remoteId;
        this.registerNo = registerNo;
        this.openingBalance = openingBalance;
        this.openingDateTime = openingDateTime;
    }
}
