import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqlite_api.dart';

class Register {
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

  Register(
      {this.id,
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

  Register.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.openingBalance = json['opening_balance'],
        this.closingBalance = json['closing_balance'],
        this.openingBalanceDateTime = json['opening_balance_date_time'],
        this.closingBalanceDateTime = json['closing_balance_date_time'],
        this.salePaidAmount = json['sale_paid_amount'],
        this.customerDueReceive = json['customer_due_receive'],
        this.paymentMethodsSale = json['payment_methods_sale'],
        this.registerStatus = json['register_status'],
        this.userId = json['user_id'],
        this.outletId = json['outlet_id'],
        this.companyId = json['company_id'],
        this.registerNo = json['register_no'],
        this.deviceKey = json['device_key'],
        this.remoteId = json['remote_id'];

  List<String> getList() => [
        this.remoteId,
        Lib.codeGenerator('REG', int.parse(this.remoteId)),
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
        this.id,
        this.registerStatus
      ];

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      if (!(ShiftTable.columnsName[i] == ShiftTable.shift))
        map[ShiftTable.columnsName[i]] = getList()[i];
      else
        map[ShiftTable.columnsName[i]] = '';
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async {
    int id = await db.insert(ShiftTable.tableName, getValues());
    bool status = id < 0 ? true : false;
    return status;
  }
}
