import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:sqflite/sqflite.dart';

class PaymentMethod {
  String serverId;
  String name;
  String description;
  String userId;
  String companyId;
  String delStatus;

  PaymentMethod(
      {this.serverId,
      this.name,
      this.description,
      this.userId,
      this.companyId,
      this.delStatus});

  List<String> getList() {
    return [
      this.serverId,
      this.name,
      this.description,
      this.userId,
      this.companyId,
      this.delStatus
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < Columns.paymentMethods.length; i++) {
      map[Columns.paymentMethods[i]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await db.insert(Tables.paymentMethods, getValues()) > 0 ? true : false;
}
