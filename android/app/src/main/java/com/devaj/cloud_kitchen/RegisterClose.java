package com.devaj.cloud_kitchen;

import com.google.gson.annotations.SerializedName;

class RegisterClose {
    @SerializedName("remote_id")
    private String remoteId;
    @SerializedName("device_key")
    private String deviceKey;
    @SerializedName("closing_balance")
    private String closingBalance;
    @SerializedName("closing_balance_date_time")
    private String closingDateTime;

    public RegisterClose(String remoteId, String deviceKey, String closingBalance, String closingDateTime) {
        this.remoteId = remoteId;
        this.deviceKey = deviceKey;
        this.closingBalance = closingBalance;
        this.closingDateTime = closingDateTime;
    }
}
