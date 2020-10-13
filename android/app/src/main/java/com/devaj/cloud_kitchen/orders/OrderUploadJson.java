package com.devaj.cloud_kitchen.orders;

class OrderUploadJson {
    private SalesMaster salesMaster;
    private SalesDetail salesDetail;

    public OrderUploadJson(SalesMaster salesMaster, SalesDetail salesDetail) {
        this.salesMaster = salesMaster;
        this.salesDetail = salesDetail;
    }

}
