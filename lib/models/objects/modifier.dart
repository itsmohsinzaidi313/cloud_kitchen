import 'package:food_app/database/table_object/modifier_table.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class Modifier {
  final String serverId;
  final String name;
  final String price;
  final String description;
  final String userId;
  final String companyId;
  final String delStatus;

  Modifier(
      {this.serverId,
      this.name,
      this.price,
      this.description,
      this.userId,
      this.companyId,
      this.delStatus});

  Modifier.fromJson(Map<String, dynamic> json)
      : serverId = json['id'],
        name = json['name'],
        price = json['price'],
        description = json['description'],
        userId = json['user_id'],
        companyId = json['company_id'],
        delStatus = json['del_status'];

  @override
  String toString() {
    return 'Modifiers{id: $serverId, name: $name, price: $price, description: $description, userId: $userId, companyId: $companyId, delStatus: $delStatus}';
  }

  List<String> getList() {
    return [
      this.serverId,
      this.name,
      this.price,
      this.description,
      this.userId,
      this.companyId,
      this.delStatus
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      map[ModifierTable.columnsName[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, ModifierTable.tableName, getValues());
}
