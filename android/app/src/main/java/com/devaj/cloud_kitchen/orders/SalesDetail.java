package com.devaj.cloud_kitchen;

class SalesDetail {
    private String id;
    private String foodMenuId;
    private String menuName;
    private String qty;
    private String menuPriceWithoutDiscount;
    private String menuPriceWithDiscount;
    private String menuUnitPrice;
    private String menuVatPercentage;
    private String menuTaxes;
    private String menuDiscountValue;
    private String discountType;
    private String menuNote;
    private String discountAmount;
    private String itemType;
    private String cookingStatus;
    private String cookingStartTime;
    private String cookingDoneTime;
    private String previousId;
    private String salesMasterId;
    private String orderStatus;
    private String userId;
    private String outletId;
    private String delStatus;

    public SalesDetail(String id, String foodMenuId, String menuName, String qty, String menuPriceWithoutDiscount, String menuPriceWithDiscount, String menuUnitPrice, String menuVatPercentage, String menuTaxes, String menuDiscountValue, String discountType, String menuNote, String discountAmount, String itemType, String cookingStatus, String cookingStartTime, String cookingDoneTime, String previousId, String salesMasterId, String orderStatus, String userId, String outletId, String delStatus) {
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
    }
}
