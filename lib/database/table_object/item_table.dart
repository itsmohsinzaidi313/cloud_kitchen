import 'package:food_app/database/sql_structure.dart';

class ItemTable{

  static const String localId = 'local_id';
  static const String serverId = 'id';
  static const String code = 'code';
  static const String name = 'name';
  static const String salePrice = 'sale_price';
  static const String photo = 'photo';
  static const String categoryName = 'category_name';
  static const String percentage = 'percentage';
  static const String quantity = 'quantity';

  static const List<String> columnsName = [
    localId,
    serverId,
    code,
    name,
    salePrice,
    photo,
    categoryName,
    percentage,
    quantity
  ];

  static const List<String> columnsType = [
    SqlStructure.integer + SqlStructure.primaryKey,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text
  ];
}