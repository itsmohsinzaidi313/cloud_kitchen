import 'package:sqflite/sqflite.dart';

import '../../database/columns.dart';
import '../../database/tables.dart';

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
    for (int i = 0; i < Columns.expenseCategories.length; i++) {
      map[Columns.expenseCategories[i]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await db.insert(Tables.expenseCategories, getValues()) > 0 ? true : false;
}
