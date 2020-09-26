import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:sqflite/sqflite.dart';

class SalesDetails {
  String id;
  String foodMenuId;
  String menuName;
  String qty;
  String menuPriceWithoutDiscount;
  String menuPriceWithDiscount;
  String menuUnitPrice;
  String menuVatPercentage;
  String menuTaxes;
  String menuDiscountValue;
  String discountType;
  String menuNote;
  String discountAmount;
  String itemType;
  String cookingStatus;
  String cookingStartTime;
  String cookingDoneTime;
  String previousId;
  String salesMasterId;
  String orderStatus;
  String userId;
  String outletId;
  String delStatus;

  SalesDetails(
      {this.id,
      this.foodMenuId,
      this.menuName,
      this.qty,
      this.menuPriceWithoutDiscount,
      this.menuPriceWithDiscount,
      this.menuUnitPrice,
      this.menuVatPercentage,
      this.menuTaxes,
      this.menuDiscountValue,
      this.discountType,
      this.menuNote,
      this.discountAmount,
      this.itemType,
      this.cookingStatus,
      this.cookingStartTime,
      this.cookingDoneTime,
      this.previousId,
      this.salesMasterId,
      this.orderStatus,
      this.userId,
      this.outletId,
      this.delStatus});

  SalesDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        foodMenuId = json['food_menu_id'],
        menuName = json['menu_name'],
        qty = json['qty'],
        menuPriceWithoutDiscount = json['menu_price_without_discount'],
        menuPriceWithDiscount = json['menu_price_with_discount'],
        menuUnitPrice = json['menu_unit_price'],
        menuVatPercentage = json['menu_vat_percentage'],
        menuTaxes = json['menu_taxes'],
        menuDiscountValue = json['menu_discount_value'],
        discountType = json['discount_type'],
        menuNote = json['menu_note'],
        discountAmount = json['discount_amount'],
        itemType = json['item_type'],
        cookingStatus = json['cooking_status'],
        cookingStartTime = json['cooking_start_time'],
        cookingDoneTime = json['cooking_done_time'],
        previousId = json['previous_id'],
        salesMasterId = json['sales_id'],
        orderStatus = json['order_status'],
        userId = json['user_id'],
        outletId = json['outlet_id'],
        delStatus = json['del_status'];

  @override
  String toString() {
    return 'SalesDetails{id: $id, foodMenuId: $foodMenuId, menuName: $menuName, qty: $qty, menuPriceWithoutDiscount: $menuPriceWithoutDiscount, menuPriceWithDiscount: $menuPriceWithDiscount, menuUnitPrice: $menuUnitPrice, menuVatPercentage: $menuVatPercentage, menuTaxes: $menuTaxes, menuDiscountValue: $menuDiscountValue, discountType: $discountType, menuNote: $menuNote, discountAmount: $discountAmount, itemType: $itemType, cookingStatus: $cookingStatus, cookingStartTime: $cookingStartTime, cookingDoneTime: $cookingDoneTime, previousId: $previousId, salesMasterId: $salesMasterId, orderStatus: $orderStatus, userId: $userId, outletId: $outletId, delStatus: $delStatus}';
  }

  List<String> getList() {
    return [
      this.id,
      this.foodMenuId,
      this.menuName,
      this.qty,
      this.menuPriceWithoutDiscount,
      this.menuPriceWithDiscount,
      this.menuUnitPrice,
      this.menuVatPercentage,
      this.menuTaxes,
      this.menuDiscountValue,
      this.discountType,
      this.menuNote,
      this.discountAmount,
      this.itemType,
      this.cookingStatus,
      this.cookingStartTime,
      this.cookingDoneTime,
      this.previousId,
      this.salesMasterId,
      this.orderStatus,
      this.userId,
      this.outletId,
      this.delStatus
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 1; i < Columns.salesDetails.length; i++) {
      map[Columns.salesDetails[i]] = getList()[i - 1];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await db.insert(Tables.salesDetails, getValues()) > 0 ? true : false;

  Future<int> insertSpecificIntoDb(Database db, Map<String, dynamic> map) async {
    int id = await db.insert(Tables.salesDetails, map);
    return id;
  }

  Future<List<Map<String, dynamic>>> queryAllRows(Database db) async {
    var res = await db.query(Tables.salesDetails);
    return res;
  }

}
