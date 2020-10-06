import 'package:food_app/database/sql_structure.dart';

class ItemModifierTable {

  static const String localId = 'local_id';
  static const String serverId = 'id';
  static const String modifierId = 'modifier_id';
  static const String foodMenuId = 'food_menu_id';
  static const String userId = 'user_id';
  static const String outletId = 'outlet_id';
  static const String companyId = 'company_id';
  static const String delStatus = 'name';
  static const String name = 'price';
  static const String price = 'del_status';

  static const List<String> columnsName = [
    localId,
    serverId,
    modifierId,
    foodMenuId,
    userId,
    outletId,
    companyId,
    delStatus,
    name,
    price
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
    SqlStructure.text,
    SqlStructure.text
  ];
}