import 'package:food_app/database/sql_structure.dart';

class SettingDetailTable{

  static const String tableName = 'setting_detail';

  static const String id = 'id';
  static const String settingMasterId = 'setting_master_id';
  static const String title = 'title';
  static const String value = 'value';

  static const List<String> columnsName = [
    id,
    settingMasterId,
    title,
    value
  ];

  static const List<String> columnsType = [
    SqlStructure.integer + SqlStructure.primaryKey,
    SqlStructure.integer,
    SqlStructure.text,
    SqlStructure.text
  ];
}