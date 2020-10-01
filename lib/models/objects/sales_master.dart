import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class SalesMaster {
  String id;
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
  String remoteId;
  String companyId;
  String isDelete;

  SalesMaster(
      {this.id,
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
      this.remoteId,
      this.companyId,
      this.isDelete});

  SalesMaster.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        customerId = json['customer_id'],
        saleNo = json['sale_no'],
        totalItems = json['total_items'],
        subTotal = json['sub_total'],
        paidAmount = json['paid_amount'],
        dueAmount = json['due_amount'],
        disc = json['disc'],
        discActual = json['disc_actual'],
        vat = json['vat'],
        totalPayable = json['total_payable'],
        paymentMethodId = json['payment_method_id'],
        closeTime = json['close_time'],
        tableId = json['table_id'],
        totalItemDiscountAmount = json['total_item_discount_amount'],
        subTotalWithDiscount = json['sub_total_with_discount'],
        subTotalDiscountAmount = json['sub_total_discount_amount'],
        totalDiscountAmount = json['total_discount_amount'],
        deliveryCharge = json['delivery_charge'],
        subTotalDiscountValue = json['sub_total_discount_value'],
        subTotalDiscountType = json['sub_total_discount_type'],
        saleDate = json['sale_date'],
        dateTime = json['date_time'],
        orderTime = json['order_time'],
        cookingStartTime = json['cooking_start_time'],
        cookingDoneTime = json['cooking_done_time'],
        modified = json['modified'],
        userId = json['user_id'],
        waiterId = json['waiter_id'],
        outletId = json['outlet_id'],
        orderStatus = json['order_status'],
        orderType = json['order_type'],
        delStatus = json['del_status'],
        saleVatObjects = json['sale_vat_objects'],
        deviceKey = json['device_key'],
        remoteId = json['remote_id'],
        companyId = json['company_id'],
        isDelete = json['is_delete'];

  @override
  String toString() {
    return 'SalesMaster{id: $id, customerId: $customerId, saleNo: $saleNo, totalItems: $totalItems, subTotal: $subTotal, paidAmount: $paidAmount, dueAmount: $dueAmount, disc: $disc, discActual: $discActual, vat: $vat, totalPayable: $totalPayable, paymentMethodId: $paymentMethodId, closeTime: $closeTime, tableId: $tableId, totalItemDiscountAmount: $totalItemDiscountAmount, subTotalWithDiscount: $subTotalWithDiscount, subTotalDiscountAmount: $subTotalDiscountAmount, totalDiscountAmount: $totalDiscountAmount, deliveryCharge: $deliveryCharge, subTotalDiscountValue: $subTotalDiscountValue, subTotalDiscountType: $subTotalDiscountType, saleDate: $saleDate, dateTime: $dateTime, orderTime: $orderTime, cookingStartTime: $cookingStartTime, cookingDoneTime: $cookingDoneTime, modified: $modified, userId: $userId, waiterId: $waiterId, outletId: $outletId, orderStatus: $orderStatus, orderType: $orderType, delStatus: $delStatus, saleVatObjects: $saleVatObjects, deviceKey: $deviceKey, remoteId: $remoteId, companyId: $companyId}';
  }

  List<String> getList() {
    return [
      this.id,
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
      this.remoteId,
      this.companyId,
      this.isDelete
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      map[Columns.salesMaster[i + 1]] = getList()[i];
    }
    return map;
  }

  Map<String, dynamic> getValuesForUpload() {
    Map<String, dynamic> map = new Map();
    for (int i = 1; i < Columns.salesMaster.length - 1; i++) {
      map[Columns.salesMaster[i]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, Tables.salesMaster, getValues());

  Future<int> insertSpecificIntoDb(
      Database db, Map<String, dynamic> map) async {
    int id = await db.insert(Tables.salesMaster, map);
    return id;
  }

  Future<int> updateSpecificIntoDb(Database db, Map<String, dynamic> map,
      String columnName, dynamic columnValue) async {
    int updateCount = await db.update(Tables.salesMaster, map,
        where: '$columnName = ?', whereArgs: [columnValue]);

    return updateCount;
  }

  Future<List<SalesMaster>> queryAllRows(Database db) async {
    List<Map<String, dynamic>> res = await db.query(Tables.salesMaster,
        where:
            "${Columns.salesMaster[5]} == '0.0' AND ${Columns.salesMaster[37]} == '0'");
    List<SalesMaster> _orders = [];
    res.forEach((row) {
      if (row['${Columns.salesMaster[37]}'] == 0.toString()) {
        _orders.add(SalesMaster.fromJson(row));
      }
    });
    return _orders;
  }

  Future<List<SalesMaster>> getDineInList(Database db) async {
    List<Map<String, dynamic>> res = await db.query(Tables.salesMaster,
        where:
        "${Columns.salesMaster[5]} == '0.0' AND ${Columns.salesMaster[37]} == '0' AND ${Columns.salesMaster[31]} == '1");
    List<SalesMaster> dineInList = [];
    res.forEach((row) {
      dineInList.add(SalesMaster.fromJson(row));
    });
    return dineInList;
  }

  Future<List<SalesMaster>> getTakeawayList(Database db) async {
    List<Map<String, dynamic>> res = await db.query(Tables.salesMaster,
        where:
        "${Columns.salesMaster[5]} == '0.0' AND ${Columns.salesMaster[37]} == '0' AND ${Columns.salesMaster[31]} == '2");
    List<SalesMaster> takeawayList = [];
    res.forEach((row) {
      takeawayList.add(SalesMaster.fromJson(row));
    });
    return takeawayList;
  }

  Future<List<SalesMaster>> getDeliveryList(Database db) async {
    List<Map<String, dynamic>> res = await db.query(Tables.salesMaster,
        where:
        "${Columns.salesMaster[5]} == '0.0' AND ${Columns.salesMaster[37]} == '0' AND ${Columns.salesMaster[31]} == '3");
    List<SalesMaster> deliveryList = [];
    res.forEach((row) {
      deliveryList.add(SalesMaster.fromJson(row));
    });
    return deliveryList;
  }
}
