import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:sqflite/sqflite.dart';

class Shift{

  String id;
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
  String remoteId;

  Shift({
      this.id,
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
    this.remoteId
  });

  List<String> getList() {
    return [
      this.id,
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
      this.remoteId
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < Columns.shiftData .length; i++) {
      map[Columns.shiftData [i]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await db.insert(Tables.shiftData, getValues()) > 0 ? true : false;
}