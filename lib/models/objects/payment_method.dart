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

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    this.serverId = json['id'];
    this.name = json['name'];
    this.description = json['description'];
    this.userId = json['user_id'];
    this.companyId = json['company_id'];
    this.delStatus = json['del_status'];
  }

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
    for (int i = 1; i < Columns.paymentMethods.length; i++) {
      map[Columns.paymentMethods[i]] = getList()[i - 1];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await db.insert(Tables.paymentMethods, getValues()) > 0 ? true : false;
}
