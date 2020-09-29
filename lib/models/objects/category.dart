import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class Category {
  final String serverId;
  final String categoryName;
  final String description;
  final String userId;
  final String companyId;
  final String delStatus;

  Category(
      {this.serverId,
      this.categoryName,
      this.description,
      this.userId,
      this.companyId,
      this.delStatus});

  Category.fromJson(Map<String, dynamic> json)
      : serverId = json['id'],
        categoryName = json['category_name'],
        description = json['description'],
        userId = json['user_id'],
        companyId = json['company_id'],
        delStatus = json['del_status'];

  @override
  String toString() {
    return 'Categories{id: $serverId, categoryName: $categoryName, description: $description, userId: $userId, companyId: $companyId, delStatus: $delStatus}';
  }

  List<String> getList() {
    return [
      this.serverId,
      this.categoryName,
      this.description,
      this.userId,
      this.companyId,
      this.delStatus
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      map[Columns.categories[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, Tables.categories, getValues());
}
