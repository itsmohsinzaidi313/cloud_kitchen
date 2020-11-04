import 'package:food_app/database/table_object/vat_amount_table.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class VatAmount {
  String serverID;
  String name;
  String percentage;
  String userId;
  String companyId;
  String delStatus;

  VatAmount(
      {this.serverID,
      this.name,
      this.percentage,
      this.userId,
      this.companyId,
      this.delStatus});

  VatAmount.fromJson(Map<String, dynamic> json) {
    serverID = json['id'];
    name = json['name'];
    percentage = json['percentage'];
    companyId = json['company_id'];
    userId = json['user_id'];
    delStatus = json['del_status'];
  }

  List<String> getList() {
    return [
      this.serverID,
      this.name,
      this.percentage,
      this.userId,
      this.companyId,
      this.delStatus
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      map[VatAmountTable.columnsName[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, VatAmountTable.tableName, getValues());

  static Future<VatAmount> getVatAmount(int id) async {
    List<VatAmount> vatList = [];
    List<Map<String, dynamic>> vatAmount = await Config.database.query(VatAmountTable.tableName, where: '${VatAmountTable.companyId} = ?', whereArgs: [id], limit: 1);
    vatAmount.forEach((element) {
      vatList.add(VatAmount.fromJson(element));
    });
    return vatList[0];
  }
}
