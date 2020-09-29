import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
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
  String remoteId;

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
      this.remoteId});

  Shift.fromJson(Map<String, dynamic> map)
    : id = map['id'],
    shift = map['shift'],
    openingBalance = map['opening_balance'],
    closingBalance = map['closing_balance'],
    openingBalanceDateTime = map['opening_balance_date_time'],
    closingBalanceDateTime = map['closing_balance_date_time'],
    salePaidAmount = map['sale_paid_amount'],
    customerDueReceive = map['customer_due_receive'],
    paymentMethodsSale = map['payment_methods_sale'],
    registerStatus = map['register_status'],
    userId = map['user_id'],
    outletId = map['outlet_id'],
    companyId = map['company_id'],
    registerNo = map['register_no'],
    deviceKey = map['device_key'],
    remoteId = map['remote_id'];

  Map<String, dynamic> toMap(Shift shift){
    return {
      'id' : shift.id,
      'shift' : shift.shift,
      'opening_balance' : shift.openingBalance,
      'closing_balance' : shift.closingBalance,
      'opening_balance_date_time' : shift.openingBalanceDateTime,
      'closing_balance_date_time' : shift.closingBalanceDateTime,
      'sale_paid_amount' : shift.salePaidAmount,
      'customer_due_receive' : shift.customerDueReceive,
      'payment_methods_sale' : shift.paymentMethodsSale,
      'register_status' : shift.registerStatus,
      'user_id' : shift.userId,
      'outlet_id' : shift.outletId,
      'company_id' : shift.companyId,
      'register_no' : shift.registerNo,
      'device_key' : shift.deviceKey,
      'remote_id' : shift.remoteId,
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
      this.remoteId
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      map[Columns.shiftData[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, Tables.shiftData, getValues());

  Future<int> insertSpecificIntoDatabase(Database db, Shift shift) async {
    Map<String, dynamic> row = Shift().toMap(shift);
    int id = await db.insert(Tables.shiftData, row);
    return id;
  }
}
