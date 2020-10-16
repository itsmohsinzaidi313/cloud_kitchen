import 'package:food_app/database/columns.dart';
import 'package:food_app/database/table_object/tables_table.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class Table {
  String serverId;
  String name;
  String sitCapacity;
  String position;
  String description;
  String userId;
  String outletId;
  String companyId;
  String delStatus;

  Table(
      {this.serverId,
      this.name,
      this.sitCapacity,
      this.position,
      this.description,
      this.userId,
      this.outletId,
      this.companyId,
      this.delStatus});

  Table.fromJson(Map<String, dynamic> json)
      : serverId = json['id'],
        name = json['name'],
        sitCapacity = json['sit_capacity'],
        position = json['position'],
        description = json['description'],
        userId = json['user_id'],
        outletId = json['outlet_id'],
        companyId = json['company_id'],
        delStatus = json['del_status'];

  @override
  String toString() {
    return 'Tables{id: $serverId, name: $name, sitCapacity: $sitCapacity, position: $position, description: $description, userId: $userId, outletId: $outletId, companyId: $companyId, delStatus: $delStatus}';
  }

  List<String> getList() {
    return [
      this.serverId,
      this.name,
      this.sitCapacity,
      this.position,
      this.description,
      this.userId,
      this.outletId,
      this.companyId,
      this.delStatus
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
        map[TablesTable.columnsName[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, TablesTable.tableName, getValues());
}
