package com.devaj.cloud_kitchen.orders;

import com.google.gson.annotations.SerializedName;

import java.util.List;

class SalesDetail {
    @SerializedName("id")
    private String id;
    @SerializedName("food_menu_id")
    private String foodMenuId;
    @SerializedName("menu_name")
    private String menuName;
    @SerializedName("qty")
    private String qty;
    @SerializedName("menu_price_without_discount")
    private String menuPriceWithoutDiscount;
    @SerializedName("menu_price_with_discount")
    private String menuPriceWithDiscount;
    @SerializedName("menu_unit_price")
    private String menuUnitPrice;
    @SerializedName("menu_vat_percentage")
    private String menuVatPercentage;
    @SerializedName("menu_taxes")
    private String menuTaxes;
    @SerializedName("menu_discount_value")
    private String menuDiscountValue;
    @SerializedName("discount_type")
    private String discountType;
    @SerializedName("menu_note")
    private String menuNote;
    @SerializedName("discount_amount")
    private String discountAmount;
    @SerializedName("item_type")
    private String itemType;
    @SerializedName("cooking_status")
    private String cookingStatus;
    @SerializedName("cooking_start_time")
    private String cookingStartTime;
    @SerializedName("cooking_done_time")
    private String cookingDoneTime;
    @SerializedName("previous_id")
    private String previousId;
    @SerializedName("sales_id")
    private String salesMasterId;
    @SerializedName("order_status")
    private String orderStatus;
    @SerializedName("user_id")
    private String userId;
    @SerializedName("outlet_id")
    private String outletId;
    @SerializedName("del_status")
    private String delStatus;
    @SerializedName("sale_detail_modifiers")
    private List<SaleDetailModifiers> saleDetailModifiers;

    public SalesDetail(String id, String foodMenuId, String menuName, String qty, String menuPriceWithoutDiscount, String menuPriceWithDiscount, String menuUnitPrice, String menuVatPercentage, String menuTaxes, String menuDiscountValue, String discountType, String menuNote, String discountAmount, String itemType, String cookingStatus, String cookingStartTime, String cookingDoneTime, String previousId, String salesMasterId, String orderStatus, String userId, String outletId, String delStatus, List<SaleDetailModifiers> saleDetailModifiers) {
        this.id = id;
        this.foodMenuId = foodMenuId;
        this.menuName = menuName;
        this.qty = qty;
        this.menuPriceWithoutDiscount = menuPriceWithoutDiscount;
        this.menuPriceWithDiscount = menuPriceWithDiscount;
        this.menuUnitPrice = menuUnitPrice;
        this.menuVatPercentage = menuVatPercentage;
        this.menuTaxes = menuTaxes;
        this.menuDiscountValue = menuDiscountValue;
        this.discountType = discountType;
        this.menuNote = menuNote;
        this.discountAmount = discountAmount;
        this.itemType = itemType;
        this.cookingStatus = cookingStatus;
        this.cookingStartTime = cookingStartTime;
        this.cookingDoneTime = cookingDoneTime;
        this.previousId = previousId;
        this.salesMasterId = salesMasterId;
        this.orderStatus = orderStatus;
        this.userId = userId;
        this.outletId = outletId;
        this.delStatus = delStatus;
        this.saleDetailModifiers = saleDetailModifiers;
    }
}
