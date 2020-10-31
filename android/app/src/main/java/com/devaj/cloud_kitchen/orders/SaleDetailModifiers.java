package com.devaj.cloud_kitchen.orders;

import com.google.gson.annotations.SerializedName;

public class SaleDetailModifiers {
    @SerializedName("id")
    private String id;
    @SerializedName("modifier_id")
    private String modifiedId;
    @SerializedName("modifier_price")
    private String modifiedPrice;
    @SerializedName("food_menu_id")
    private String foodMenuId;
    @SerializedName("sales_id")
    private String salesId;
    @SerializedName("order_status")
    private String orderStatus;
    @SerializedName("sales_details_id")
    private String salesDetailId;
    @SerializedName("user_id")
    private String userId;
    @SerializedName("outlet_id")
    private String outletId;
    @SerializedName("customer_id")
    private String customerId;

    public SaleDetailModifiers(String id, String modifiedId, String modifiedPrice, String foodMenuId, String salesId, String orderStatus, String salesDetailId, String userId, String outletId, String customerId) {
        this.id = id;
        this.modifiedId = modifiedId;
        this.modifiedPrice = modifiedPrice;
        this.foodMenuId = foodMenuId;
        this.salesId = salesId;
        this.orderStatus = orderStatus;
        this.salesDetailId = salesDetailId;
        this.userId = userId;
        this.outletId = outletId;
        this.customerId = customerId;
    }
}
