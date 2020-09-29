import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';

class ExpenseCategory {
  String serverId;
  String name;
  String description;
  String userId;
  String companyId;
  String delStatus;

  ExpenseCategory(
      {this.serverId,
      this.name,
      this.description,
      this.userId,
      this.companyId,
      this.delStatus});

  ExpenseCategory.fromJson(Map<String, dynamic> map) {
    this.serverId = map['id'];
    this.name = map['name'];
    this.description = map['description'];
    this.userId = map['user_id'];
    this.companyId = map['company_id'];
    this.delStatus = map['del_status'];
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
    for (int i = 0; i < getList().length; i++) {
      map[Columns.expenseCategories[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, Tables.expenseCategories, getValues());
}
