import 'package:food_app/database/sql_structure.dart';

class SettingMasterTable{

  static const String tableName = 'setting_master';

  static const String id = 'id';
  static const String title = 'title';
  static const String userId = 'user_id';

  static const List<String> columnsName = [
    id,
    title,
    userId
  ];

  static const List<String> columnsType = [
    SqlStructure.integer + SqlStructure.primaryKey,
    SqlStructure.text,
    SqlStructure.integer
  ];
}