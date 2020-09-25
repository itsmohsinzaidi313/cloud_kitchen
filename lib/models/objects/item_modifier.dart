import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/shared/config.dart';
import 'package:sqflite/sqflite.dart';

class ItemModifier {
  String id;
  final String serverId;
  final String modifierId;
  final String foodMenuId;
  final String userId;
  final String outletId;
  final String companyId;
  final String delStatus;
  final String name;
  final String price;

  ItemModifier(
      {this.serverId,
      this.modifierId,
      this.foodMenuId,
      this.userId,
      this.outletId,
      this.companyId,
      this.delStatus,
      this.name,
      this.price});

  ItemModifier.fromJson(Map<String, dynamic> json)
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
      this.name,
      this.price,
      this.delStatus,
    ];
  }

  Map<String, dynamic> getValues() {
    try {
      Map<String, dynamic> map = new Map<String, dynamic>();
      print(Columns.itemModifier.length);
      for (int i = 1; i < Columns.itemModifier.length; i++) {
        print('---');
        print(i);
        print(Columns.itemModifier[i]);
        print(getList()[i]);
        map[Columns.itemModifier[i]] = getList()[i - 1];
      }
      return map;
    } catch (e) {
      Config.log.e('Error on getValues', [e]);
      return null;
    }
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await db.insert(Tables.itemModifiers, getValues()) > 0 ? true : false;
}
