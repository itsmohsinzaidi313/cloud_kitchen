import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
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
    for (int i = 0; i < Columns.vatAmount.length; i++) {
      map[Columns.vatAmount[i]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await db.insert(Tables.vatAmount, getValues()) > 0 ? true : false;
}
