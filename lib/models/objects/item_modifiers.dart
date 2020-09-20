import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:sqflite/sqflite.dart';

class ItemModifiers {
  final String serverId;
  final String modifierId;
  final String foodMenuId;
  final String userId;
  final String outletId;
  final String companyId;
  final String delStatus;
  final String name;
  final String price;

  ItemModifiers(
      {this.serverId,
      this.modifierId,
      this.foodMenuId,
      this.userId,
      this.outletId,
      this.companyId,
      this.delStatus,
      this.name,
      this.price});

  ItemModifiers.fromJson(Map<String, dynamic> json)
      : serverId = json['id'],
        modifierId = json['modifier_id'],
        foodMenuId = json['food_menu_id'],
        userId = json['user_id'],
        outletId = json['outlet_id'],
        companyId = json['company_id'],
        name = json['name'],
        price = json['price'],
        delStatus = json['del_status'];

  @override
  String toString() {
    return 'ItemModifiers{id: $serverId, modifierId: $modifierId, foodMenuId: $foodMenuId, userId: $userId, outletId: $outletId, companyId: $companyId, delStatus: $delStatus, name: $name, price: $price}';
  }

  List<String> getList() {
    return [
      this.serverId,
      this.modifierId,
      this.foodMenuId,
      this.userId,
      this.outletId,
      this.companyId,
      this.delStatus,
      this.name,
      this.price
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < Columns.itemModifiers.length; i++) {
      map[Columns.itemModifiers[i]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await db.insert(Tables.itemModifiers, getValues()) > 0 ? true : false;
}
