import 'package:food_app/database/columns.dart';
import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class Shift {
  String id;
  String shift;
  String openingBalance;
  String closingBalance;
  String openingBalanceDateTime;
  String closingBalanceDateTime;
  String salePaidAmount;
  String customerDueReceive;
  String paymentMethodsSale;
  String registerStatus;
  String userId;
  String outletId;
  String companyId;
  String registerNo;
  String deviceKey;
  String remoteId; //local id
  String isUpload;

  Shift(
      {this.id,
      this.shift,
      this.openingBalance,
      this.closingBalance,
      this.openingBalanceDateTime,
      this.closingBalanceDateTime,
      this.salePaidAmount,
      this.customerDueReceive,
      this.paymentMethodsSale,
      this.registerStatus,
      this.userId,
      this.outletId,
      this.companyId,
      this.registerNo,
      this.deviceKey,
      this.remoteId,
      this.isUpload
      });

  Shift.fromJson(Map<String, dynamic> map)
      : remoteId = map[ShiftTable.localId].toString(),
        shift = map[ShiftTable.shift],
        openingBalance = map[ShiftTable.openingBalance],
        closingBalance = map[ShiftTable.closingBalance],
        openingBalanceDateTime = map[ShiftTable.openingBalanceDateTime],
        closingBalanceDateTime = map[ShiftTable.closingBalanceDateTime],
        salePaidAmount = map[ShiftTable.salePaidAmount],
        customerDueReceive = map[ShiftTable.customerDueReceive],
        paymentMethodsSale = map[ShiftTable.paymentMethodsSale],
        registerStatus = map[ShiftTable.registerStatus],
        userId = map[ShiftTable.userId],
        outletId = map[ShiftTable.outletId],
        companyId = map[ShiftTable.companyId],
        registerNo = map[ShiftTable.registerNo],
        deviceKey = map[ShiftTable.deviceKey],
        id = map[ShiftTable.serverId],
        isUpload = map[ShiftTable.isUpload]
  ;

  Map<String, dynamic> toMap(Shift shift) {
    return {
      // ShiftTable.localId : shift.remoteId,
      ShiftTable.shift : shift.shift,
      ShiftTable.openingBalance : shift.openingBalance,
      ShiftTable.closingBalance : shift.closingBalance,
      ShiftTable.openingBalanceDateTime : shift.openingBalanceDateTime,
      ShiftTable.closingBalanceDateTime : shift.closingBalanceDateTime,
      ShiftTable.salePaidAmount : shift.salePaidAmount,
      ShiftTable.customerDueReceive : shift.customerDueReceive,
      ShiftTable.paymentMethodsSale : shift.paymentMethodsSale,
      ShiftTable.registerStatus : shift.registerStatus,
      ShiftTable.userId : shift.userId,
      ShiftTable.outletId : shift.outletId,
      ShiftTable.companyId : shift.companyId,
      ShiftTable.registerNo : shift.registerNo,
      ShiftTable.deviceKey : shift.deviceKey,
      ShiftTable.serverId : shift.id,
      ShiftTable.isUpload : shift.isUpload
    };
  }

  List<String> getList() {
    return [
      this.id,
      this.shift,
      this.openingBalance,
      this.closingBalance,
      this.openingBalanceDateTime,
      this.closingBalanceDateTime,
      this.salePaidAmount,
      this.customerDueReceive,
      this.paymentMethodsSale,
      this.registerStatus,
      this.userId,
      this.outletId,
      this.companyId,
      this.registerNo,
      this.deviceKey,
      this.remoteId,
      this.isUpload
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      map[ShiftTable.columnsName[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, ShiftTable.tableName, getValues());

  Future<int> getNextShiftRemoteId(Database db) async {
    try {
      List<Map<String, dynamic>> rows = await db.rawQuery(
          "select ifnull(max(local_id),0) as remote_id from ${ShiftTable.tableName}");
      int remoteId = rows[0]['remote_id'];
      return remoteId + 1;
    } catch (e) {
      return 0;
    }
  }

  Future<int> insertSpecificIntoDatabase(Database db, Shift shift) async {
    try {
      Map<String, dynamic> row = Shift().toMap(shift);
      int id = await db.insert(ShiftTable.tableName, row);
      return id;
    } catch (e) {
      Config.log.e('Error on Shift insertSpecificIntoDatabase: $e');
      return 0;
    }
  }
}
