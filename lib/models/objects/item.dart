import 'package:sqflite/sqflite.dart';

import '../../database/columns.dart';
import '../../database/tables.dart';

class Item {
  String serverId;
  String code;
  String name;
  String salePrice;
  String photo;
  String categoryName;
  String percentage;
  String quantity;

  Item(
      {this.serverId,
      this.code,
      this.name,
      this.salePrice,
      this.photo,
      this.categoryName,
      this.percentage,
      this.quantity});

  Item.fromJson(Map<String, dynamic> json)
      : serverId = json['id'],
        code = json['code'],
        name = json['name'],
        salePrice = json['sale_price'],
        photo = json['photo'],
        categoryName = json['category_name'],
        quantity = 1.toString(),
        percentage = json['percentage'];

  @override
  String toString() {
    return 'ItemMenus{id: $serverId, code: $code, name: $name, salePrice: $salePrice, photo: $photo, categoryName: $categoryName, percentage: $percentage}';
  }

  List<String> getList() {
    return [
      this.serverId,
      this.code,
      this.name,
      this.salePrice,
      this.photo,
      this.categoryName,
      this.percentage,
      this.quantity
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < Columns.item.length; i++) {
      map[Columns.item[i]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await db.insert(Tables.item, getValues()) > 0 ? true : false;
}
