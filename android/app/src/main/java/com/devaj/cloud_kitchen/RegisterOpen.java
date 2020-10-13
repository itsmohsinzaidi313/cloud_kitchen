package com.devaj.cloud_kitchen;

import com.google.gson.annotations.SerializedName;

class Register {
    @SerializedName("remote_id")
    String localId;

    String shift;
    String openingBalance;
    String closingBalance;
    String openingBalanceDateTime;
    String closingBalanceDateTime;
    String salePaidAmount;
    String customerDueReceive;
    String paymentMethodsSale;
    String registerStatus;
    String userId;
    String outletId;
    String companyId;
    String registerNo;
    String deviceKey;
    String serverId;
    String isUpload;


}
