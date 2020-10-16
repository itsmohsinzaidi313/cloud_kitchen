import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class SalesMaster {
  String serverId;
  String customerId;
  String saleNo;
  String totalItems;
  String subTotal;
  String paidAmount;
  String dueAmount;
  String disc;
  String discActual;
  String vat;
  String totalPayable;
  String paymentMethodId;
  String closeTime;
  String tableId;
  String totalItemDiscountAmount;
  String subTotalWithDiscount;
  String subTotalDiscountAmount;
  String totalDiscountAmount;
  String deliveryCharge;
  String subTotalDiscountValue;
  String subTotalDiscountType;
  String saleDate;
  String dateTime;
  String orderTime;
  String cookingStartTime;
  String cookingDoneTime;
  String modified;
  String userId;
  String waiterId;
  String outletId;
  String orderStatus;
  String orderType;
  String delStatus;
  String saleVatObjects;
  String deviceKey;
  String localId;
  String companyId;
  String isDelete;
  String isUpdate;

  SalesMaster(
      {this.serverId,
      this.customerId,
      this.saleNo,
      this.totalItems,
      this.subTotal,
      this.paidAmount,
      this.dueAmount,
      this.disc,
      this.discActual,
      this.vat,
      this.totalPayable,
      this.paymentMethodId,
      this.closeTime,
      this.tableId,
      this.totalItemDiscountAmount,
      this.subTotalWithDiscount,
      this.subTotalDiscountAmount,
      this.totalDiscountAmount,
      this.deliveryCharge,
      this.subTotalDiscountValue,
      this.subTotalDiscountType,
      this.saleDate,
      this.dateTime,
      this.orderTime,
      this.cookingStartTime,
      this.cookingDoneTime,
      this.modified,
      this.userId,
      this.waiterId,
      this.outletId,
      this.orderStatus,
      this.orderType,
      this.delStatus,
      this.saleVatObjects,
      this.deviceKey,
      this.localId,
      this.companyId,
      this.isDelete,
        this.isUpdate
      });

  SalesMaster.fromJson(Map<String, dynamic> json)
      : localId = json[SalesMasterTable.localId].toString(),
        customerId = json[SalesMasterTable.customerId],
        saleNo = json[SalesMasterTable.saleNo],
        totalItems = json[SalesMasterTable.totalItems],
        subTotal = json[SalesMasterTable.subTotal],
        paidAmount = json[SalesMasterTable.paidAmount],
        dueAmount = json[SalesMasterTable.dueAmount],
        disc = json[SalesMasterTable.disc],
        discActual = json[SalesMasterTable.discActual],
        vat = json[SalesMasterTable.vat],
        totalPayable = json[SalesMasterTable.totalPayable],
        paymentMethodId = json[SalesMasterTable.paymentMethodId],
        closeTime = json[SalesMasterTable.closeTime],
        tableId = json[SalesMasterTable.tableId],
        totalItemDiscountAmount = json[SalesMasterTable.totalItemDiscountAmount],
        subTotalWithDiscount = json[SalesMasterTable.subTotalWithDiscount],
        subTotalDiscountAmount = json[SalesMasterTable.subTotalDiscountAmount],
        totalDiscountAmount = json[SalesMasterTable.totalDiscountAmount],
        deliveryCharge = json[SalesMasterTable.deliveryCharge],
        subTotalDiscountValue = json[SalesMasterTable.subTotalDiscountValue],
        subTotalDiscountType = json[SalesMasterTable.subTotalDiscountType],
        saleDate = json[SalesMasterTable.saleDate],
        dateTime = json[SalesMasterTable.dateTime],
        orderTime = json[SalesMasterTable.orderTime],
        cookingStartTime = json[SalesMasterTable.cookingStartTime],
        cookingDoneTime = json[SalesMasterTable.cookingDoneTime],
        modified = json[SalesMasterTable.modified],
        userId = json[SalesMasterTable.userId],
        waiterId = json[SalesMasterTable.waiterId],
        outletId = json[SalesMasterTable.outletId],
        orderStatus = json[SalesMasterTable.orderStatus],
        orderType = json[SalesMasterTable.orderType],
        delStatus = json[SalesMasterTable.delStatus],
        saleVatObjects = json[SalesMasterTable.saleVatObjects],
        deviceKey = json[SalesMasterTable.deviceKey],
        serverId = json[SalesMasterTable.serverId],
        companyId = json[SalesMasterTable.companyId],
        isDelete = json[SalesMasterTable.isDelete],
        isUpdate = json[SalesMasterTable.isUpload];

  List<String> getList() {
    return [
      this.serverId,
      this.customerId,
      this.saleNo,
      this.totalItems,
      this.subTotal,
      this.paidAmount,
      this.dueAmount,
      this.disc,
      this.discActual,
      this.vat,
      this.totalPayable,
      this.paymentMethodId,
      this.closeTime,
      this.tableId,
      this.totalItemDiscountAmount,
      this.subTotalWithDiscount,
      this.subTotalDiscountAmount,
      this.totalDiscountAmount,
      this.deliveryCharge,
      this.subTotalDiscountValue,
      this.subTotalDiscountType,
      this.saleDate,
      this.dateTime,
      this.orderTime,
      this.cookingStartTime,
      this.cookingDoneTime,
      this.modified,
      this.userId,
      this.waiterId,
      this.outletId,
      this.orderStatus,
      this.orderType,
      this.delStatus,
      this.saleVatObjects,
      this.deviceKey,
      this.localId,
      this.companyId,
      this.isDelete,
      this.isUpdate
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      map[SalesMasterTable.columnsName[i + 1]] = getList()[i];
    }
    return map;
  }

  Map<String, dynamic> getValuesForUpload() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < SalesMasterTable.columnsName.length; i++) {
      if (i == 0) {
        map['remote_id'] = getList()[i] == null ? '' : getList()[i];
      } else if(i == 35){

      }
      else {
        map[SalesMasterTable.columnsName[i]] = getList()[i] == null ? '' : getList()[i];
      }
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, SalesMasterTable.tableName, getValues());

  Future<int> insertSpecificIntoDb(
      Database db, Map<String, dynamic> map) async {
    int id = await db.insert(SalesMasterTable.tableName, map);
    return id;
  }

  Future<int> updateSpecificIntoDb(Database db, Map<String, dynamic> map,
      String columnName, dynamic columnValue) async {
    int updateCount = await db.update(SalesMasterTable.tableName, map,
        where: '$columnName = ?', whereArgs: [columnValue]);

    return updateCount;
  }

  Future<List<SalesMaster>> queryAllRows(Database db) async {
    List<Map<String, dynamic>> res = await db.query(SalesMasterTable.tableName,
        where:
            "${SalesMasterTable.paidAmount} == '0.0' AND ${SalesMasterTable.isDelete} == '0'");
    List<SalesMaster> _orders = [];
    res.forEach((row) {
      if (row['${SalesMasterTable.isDelete}'] == 0.toString()) {
        _orders.add(SalesMaster.fromJson(row));
      }
    });
    return _orders;
  }

  Future<List<SalesMaster>> getDineInList(Database db) async {
    List<Map<String, dynamic>> res = await db.query(SalesMasterTable.tableName,
        columns: [
          SalesMasterTable.saleNo,
          SalesMasterTable.tableId,
          SalesMasterTable.waiterId,
          SalesMasterTable.dueAmount
        ],
        where:
            "${SalesMasterTable.paidAmount} == '0.0' AND ${SalesMasterTable.isDelete} == '0' AND ${SalesMasterTable.orderType} == '1'");
    List<SalesMaster> dineInList = [];
    res.forEach((row) {
      dineInList.add(SalesMaster.fromJson(row));
    });
    return dineInList;
  }

  Future<List<SalesMaster>> getTakeawayList(Database db) async {
    List<Map<String, dynamic>> res = await db.query(SalesMasterTable.tableName,
        where:
            "${SalesMasterTable.paidAmount} == '0.0' AND ${SalesMasterTable.isDelete} == '0' AND ${SalesMasterTable.orderType} == '2'");
    List<SalesMaster> takeawayList = [];
    res.forEach((row) {
      takeawayList.add(SalesMaster.fromJson(row));
    });
    return takeawayList;
  }

  Future<List<SalesMaster>> getDeliveryList(Database db) async {
    List<Map<String, dynamic>> res = await db.query(SalesMasterTable.tableName,
        where:
            "${SalesMasterTable.paidAmount} == '0.0' AND ${SalesMasterTable.isDelete} == '0' AND ${SalesMasterTable.orderType} == '3'");
    List<SalesMaster> deliveryList = [];
    res.forEach((row) {
      deliveryList.add(SalesMaster.fromJson(row));
    });
    return deliveryList;
  }

  Future<String> getTableName(Database db, String orderTableId) async {
    db.rawQuery("select () from ");
    return '';
  }
}
