package com.devaj.cloud_kitchen.orders;

import com.google.gson.annotations.SerializedName;

import java.util.List;

class SalesMaster {
    @SerializedName("customer_id")
    private String customerId;
    @SerializedName("sale_no")
    private String saleNo;
    @SerializedName("total_items")
    private String totalItems;
    @SerializedName("sub_total")
    private String subTotal;
    @SerializedName("paid_amount")
    private String paidAmount;
    @SerializedName("due_amount")
    private String dueAmount;
    @SerializedName("disc")
    private String disc;
    @SerializedName("disc_actual")
    private String discActual;
    @SerializedName("vat")
    private String vat;
    @SerializedName("total_payable")
    private String totalPayable;
    @SerializedName("payment_method_id")
    private String paymentMethodId;
    @SerializedName("close_time")
    private String closeTime;
    @SerializedName("table_id")
    private String tableId;
    @SerializedName("total_item_discount_amount")
    private String totalItemDiscountAmount;
    @SerializedName("sub_total_with_discount")
    private String subTotalWithDiscount;
    @SerializedName("sub_total_discount_amount")
    private String subTotalDiscountAmount;
    @SerializedName("total_discount_amount")
    private String totalDiscountAmount;
    @SerializedName("delivery_charge")
    private String deliveryCharge;
    @SerializedName("sub_total_discount_value")
    private String subTotalDiscountValue;
    @SerializedName("sub_total_discount_type")
    private String subTotalDiscountType;
    @SerializedName("sale_date")
    private String saleDate;
    @SerializedName("date_time")
    private String dateTime;
    @SerializedName("order_time")
    private String orderTime;
    @SerializedName("cooking_start_time")
    private String cookingStartTime;
    @SerializedName("cooking_done_time")
    private String cookingDoneTime;
    @SerializedName("modified")
    private String modified;
    @SerializedName("user_id")
    private String userId;
    @SerializedName("waiter_id")
    private String waiterId;
    @SerializedName("outlet_id")
    private String outletId;
    @SerializedName("order_status")
    private String orderStatus;
    @SerializedName("order_type")
    private String orderType;
    @SerializedName("del_status")
    private String delStatus;
    @SerializedName("sale_vat_objects")
    private String saleVatObjects;
    @SerializedName("device_key")
    private String deviceKey;
    @SerializedName("remote_id")
    private String remoteId;
    @SerializedName("company_id")
    private String companyId;
    @SerializedName("sale_details")
    private List<SalesDetail> salesDetail;

    public SalesMaster(String customerId, String saleNo, String totalItems, String subTotal, String paidAmount, String dueAmount, String disc, String discActual, String vat, String totalPayable, String paymentMethodId, String closeTime, String tableId, String totalItemDiscountAmount, String subTotalWithDiscount, String subTotalDiscountAmount, String totalDiscountAmount, String deliveryCharge, String subTotalDiscountValue, String subTotalDiscountType, String saleDate, String dateTime, String orderTime, String cookingStartTime, String cookingDoneTime, String modified, String userId, String waiterId, String outletId, String orderStatus, String orderType, String delStatus, String saleVatObjects, String deviceKey, String remoteId, String companyId, List<SalesDetail> salesDetail) {
        this.customerId = customerId;
        this.saleNo = saleNo;
        this.totalItems = totalItems;
        this.subTotal = subTotal;
        this.paidAmount = paidAmount;
        this.dueAmount = dueAmount;
        this.disc = disc;
        this.discActual = discActual;
        this.vat = vat;
        this.totalPayable = totalPayable;
        this.paymentMethodId = paymentMethodId;
        this.closeTime = closeTime;
        this.tableId = tableId;
        this.totalItemDiscountAmount = totalItemDiscountAmount;
        this.subTotalWithDiscount = subTotalWithDiscount;
        this.subTotalDiscountAmount = subTotalDiscountAmount;
        this.totalDiscountAmount = totalDiscountAmount;
        this.deliveryCharge = deliveryCharge;
        this.subTotalDiscountValue = subTotalDiscountValue;
        this.subTotalDiscountType = subTotalDiscountType;
        this.saleDate = saleDate;
        this.dateTime = dateTime;
        this.orderTime = orderTime;
        this.cookingStartTime = cookingStartTime;
        this.cookingDoneTime = cookingDoneTime;
        this.modified = modified;
        this.userId = userId;
        this.waiterId = waiterId;
        this.outletId = outletId;
        this.orderStatus = orderStatus;
        this.orderType = orderType;
        this.delStatus = delStatus;
        this.saleVatObjects = saleVatObjects;
        this.deviceKey = deviceKey;
        this.remoteId = remoteId;
        this.companyId = companyId;
        this.salesDetail = salesDetail;
    }
}
