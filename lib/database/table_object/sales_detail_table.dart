import 'package:food_app/database/sql_structure.dart';

class SalesDetailTable{

  static const String id = 'id';
  static const String foodMenuId = 'food_menu_id';
  static const String menuName = 'menu_name';
  static const String qty = 'qty';
  static const String menuPriceWithoutDiscount = 'menu_price_without_discount';
  static const String menuPriceWithDiscount = 'menu_price_with_discount';
  static const String menuUnitPrice = 'menu_unit_price';
  static const String menuVatPercentage = 'menu_vat_percentage';
  static const String menuTaxes = 'menu_taxes';
  static const String menuDiscountValue = 'menu_discount_value';
  static const String discountType = 'discount_type';
  static const String menuNote = 'menu_note';
  static const String discountAmount = 'discount_amount';
  static const String itemType = 'item_type';
  static const String cookingStatus = 'cooking_status';
  static const String cookingStartTime = 'cooking_start_time';
  static const String cookingDoneTime = 'cooking_done_time';
  static const String previousId = 'previous_id';
  static const String salesMasterId = 'sales_id';
  static const String orderStatus = 'order_status';
  static const String userId = 'user_id';
  static const String outletId = 'outlet_id';
  static const String delStatus = 'del_status';
  static const String isUpload = 'is_upload';

  static const List<String> columnsName = [
    id,
    foodMenuId,
    menuName,
    qty,
    menuPriceWithoutDiscount,
    menuPriceWithDiscount,
    menuUnitPrice,
    menuVatPercentage,
    menuTaxes,
    menuDiscountValue,
    discountType,
    menuNote,
    discountAmount,
    itemType,
    cookingStatus,
    cookingStartTime,
    cookingDoneTime,
    previousId,
    salesMasterId,
    orderStatus,
    userId,
    outletId,
    delStatus,
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
    SqlStructure.text
  ];
}