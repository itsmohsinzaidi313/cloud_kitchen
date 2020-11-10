import 'package:food_app/database/table_object/register_table.dart';
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
  String isUpload;

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
      this.remoteId, this.isUpload});

  Register.fromJson(Map<String, dynamic> json)
      : this.id = json[RegisterTable.id],
        this.openingBalance = json[RegisterTable.openingBalance],
        this.closingBalance = json[RegisterTable.closingBalance],
        this.openingBalanceDateTime = json[RegisterTable.openingBalanceDateTime],
        this.closingBalanceDateTime = json[RegisterTable.closingBalanceDateTime],
        this.salePaidAmount = json[RegisterTable.salePaidAmount],
        this.customerDueReceive = json[RegisterTable.customerDueReceive],
        this.paymentMethodsSale = json[RegisterTable.paymentMethodsSale],
        this.registerStatus = json[RegisterTable.registerStatus],
        this.userId = json[RegisterTable.userId],
        this.outletId = json[RegisterTable.outletId],
        this.companyId = json[RegisterTable.companyId],
        this.registerNo = json[RegisterTable.registerNo],
        this.deviceKey = json[RegisterTable.deviceKey],
        this.remoteId = json[RegisterTable.remoteId], this.isUpload = json[RegisterTable.isUpload];

  List<String> getList() => [
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
        this.isUpload
      ];

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      if (!(ShiftTable.columnsName[i + 1] == ShiftTable.shift))
        map[ShiftTable.columnsName[i + 1]] = getList()[i];
      else
        map[ShiftTable.columnsName[i + 1]] = '';
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async {
    int id = await db.insert(ShiftTable.tableName, getValues());
    bool status = id < 0 ? true : false;
    return status;
  }
}
