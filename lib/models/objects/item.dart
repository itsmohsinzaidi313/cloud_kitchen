import 'package:food_app/database/table_object/item_table.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';

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

  Item.fromItem(Item item) {
    this.serverId = item.serverId;
    this.code = item.code;
    this.name = item.name;
    this.salePrice = item.salePrice;
    this.photo = item.photo;
    this.categoryName = item.categoryName;
    this.percentage = item.percentage;
    this.quantity = item.quantity;
  }

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
    for (int i = 0; i < getList().length; i++) {
      map[ItemTable.columnsName[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, ItemTable.tableName, getValues());

  // less() {
  //   int qty = int.parse(this.quantity);
  //   int difference = qty - 1;
  //   if (difference >= 0) {
  //     qty--;
  //     this.quantity = qty.toString();
  //   }
  // }
}
