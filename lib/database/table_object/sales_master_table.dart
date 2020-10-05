import 'package:food_app/database/sql_structure.dart';

class SalesMasterTable{

  static const String localId = 'local_id';
  static const String customerId = 'customer_id';
  static const String saleNo = 'sale_no';
  static const String totalItems = 'total_items';
  static const String subTotal = 'sub_total';
  static const String paidAmount = 'paid_amount';
  static const String dueAmount = 'due_amount';
  static const String disc = 'disc';
  static const String discActual = 'disc_actual';
  static const String vat = 'vat';
  static const String totalPayable = 'total_payable';
  static const String paymentMethodId = 'payment_method_id';
  static const String closeTime = 'close_time';
  static const String tableId = 'table_id';
  static const String totalItemDiscountAmount = 'total_item_discount_amount';
  static const String subTotalWithDiscount = 'sub_total_with_discount';
  static const String subTotalDiscountAmount = 'sub_total_discount_amount';
  static const String totalDiscountAmount = 'total_discount_amount';
  static const String deliveryCharge = 'delivery_charge';
  static const String subTotalDiscountValue = 'sub_total_discount_value';
  static const String subTotalDiscountType = 'sub_total_discount_type';
  static const String saleDate = 'sale_date';
  static const String dateTime = 'date_time';
  static const String orderTime = 'order_time';
  static const String cookingStartTime = 'cooking_start_time';
  static const String cookingDoneTime = 'cooking_done_time';
  static const String modified = 'modified';
  static const String userId = 'user_id';
  static const String waiterId = 'waiter_id';
  static const String outletId = 'outlet_id';
  static const String orderStatus = 'order_status';
  static const String orderType = 'order_type';
  static const String delStatus = 'del_status';
  static const String saleVatObjects = 'sale_vat_objects';
  static const String deviceKey = 'device_key';
  static const String serverId = 'id';
  static const String companyId = 'company_id';
  static const String isDelete = 'is_delete';
  static const String isUpload = 'is_upload';

  static const List<String> columnsName = [
    localId,
    customerId,
    saleNo,
    totalItems,
    subTotal,
    paidAmount,
    dueAmount,
    disc,
    discActual,
    vat,
    totalPayable,
    paymentMethodId,
    closeTime,
    tableId,
    totalItemDiscountAmount,
    subTotalWithDiscount,
    subTotalDiscountAmount,
    totalDiscountAmount,
    deliveryCharge,
    subTotalDiscountValue,
    subTotalDiscountType,
    saleDate,
    dateTime,
    orderTime,
    cookingStartTime,
    cookingDoneTime,
    modified,
    userId,
    waiterId,
    outletId,
    orderStatus,
    orderType,
    delStatus,
    saleVatObjects,
    deviceKey,
    serverId,
    companyId,
    isDelete,
    isUpload
  ];

    static const List<String> columnsType = [
      SqlStructure.integer + SqlStructure.primaryKey,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text,
      SqlStructure.text
    ];
}