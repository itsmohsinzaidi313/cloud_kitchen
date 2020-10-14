import 'dart:developer';

import 'package:food_app/database/table_object/sales_detail_table.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/shared/lib.dart';
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
      : id = json[SalesDetailTable.id].toString(),
        foodMenuId = json[SalesDetailTable.foodMenuId],
        menuName = json[SalesDetailTable.menuName],
        qty = json[SalesDetailTable.qty].toString(),
        menuPriceWithoutDiscount = json[SalesDetailTable.menuPriceWithoutDiscount],
        menuPriceWithDiscount = json[SalesDetailTable.menuPriceWithDiscount],
        menuUnitPrice = json[SalesDetailTable.menuUnitPrice],
        menuVatPercentage = json[SalesDetailTable.menuVatPercentage],
        menuTaxes = json[SalesDetailTable.menuTaxes],
        menuDiscountValue = json[SalesDetailTable.menuDiscountValue],
        discountType = json[SalesDetailTable.discountType],
        menuNote = json[SalesDetailTable.menuNote],
        discountAmount = json[SalesDetailTable.discountAmount],
        itemType = json[SalesDetailTable.itemType],
        cookingStatus = json[SalesDetailTable.cookingStatus],
        cookingStartTime = json[SalesDetailTable.cookingStartTime],
        cookingDoneTime = json[SalesDetailTable.cookingDoneTime],
        previousId = json[SalesDetailTable.previousId],
        salesMasterId = json[SalesDetailTable.salesMasterId].toString(),
        orderStatus = json[SalesDetailTable.orderStatus],
        userId = json[SalesDetailTable.userId],
        outletId = json[SalesDetailTable.outletId],
        delStatus = json[SalesDetailTable.delStatus];

  // @override
  // String toString() {
  //   return 'SalesDetails{id: $id, foodMenuId: $foodMenuId, menuName: $menuName, qty: $qty, menuPriceWithoutDiscount: $menuPriceWithoutDiscount, menuPriceWithDiscount: $menuPriceWithDiscount, menuUnitPrice: $menuUnitPrice, menuVatPercentage: $menuVatPercentage, menuTaxes: $menuTaxes, menuDiscountValue: $menuDiscountValue, discountType: $discountType, menuNote: $menuNote, discountAmount: $discountAmount, itemType: $itemType, cookingStatus: $cookingStatus, cookingStartTime: $cookingStartTime, cookingDoneTime: $cookingDoneTime, previousId: $previousId, salesMasterId: $salesMasterId, orderStatus: $orderStatus, userId: $userId, outletId: $outletId, delStatus: $delStatus}';
  // }

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
    for (int i = 0; i < getList().length; i++) {
      map[SalesDetailTable.columnsName[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, SalesDetailTable.tableName, getValues());

  Future<int> insertSpecificIntoDb(
      Database db, Map<String, dynamic> map) async {
    int id = await db.insert(SalesDetailTable.tableName, map);
    return id;
  }

  Future<List<Item>> getOrderWhereMasterId(
      Database db, SalesMaster salesMaster) async {
    List<Map<String, dynamic>> res = await db.query(SalesDetailTable.tableName,
        where: '${SalesDetailTable.salesMasterId} = ${salesMaster.serverId}');

    List<Item> listItem = DataLists.instance.listItem;
    List<Item> updateList = [];

    for (int i = 0; i < listItem.length; i++) {
      for (int j = 0; j < res.length; j++) {
        if (listItem[i].code == res[j][SalesDetailTable.foodMenuId]) {
          log('${listItem[i].code}\n');
          Item item = Item.fromItem(listItem[i]);
          item.quantity = res[j][SalesDetailTable.qty];
          updateList.add(item);
          break;
        }
      }
    }

    return updateList;
  }

  Future<List<Map<String, dynamic>>> queryAllRows(Database db) async {
    var res = await db.query(SalesDetailTable.tableName);
    return res;
  }
}
