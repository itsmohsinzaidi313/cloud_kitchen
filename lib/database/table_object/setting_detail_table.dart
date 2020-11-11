import 'package:food_app/database/sql_structure.dart';

class SettingDetailTable{

  static const String tableName = 'setting_detail';

  // static const String settingMasterId = 'setting_master_id';
  static const String id = 'id';
  static const String userId = 'user_id';
  static const String shiftId = 'shift_id';
  static const String connectionStatus = 'connection_status';
  static const String loginStatus = 'login_status';
  static const String registerStatus = 'register_status';

  static const List<String> columnsName = [
    // settingMasterId,
    id,
    userId,
    shiftId,
    connectionStatus,
    loginStatus,
    registerStatus
  ];

  static const List<String> columnsType = [
    SqlStructure.integer + SqlStructure.primaryKey,
    SqlStructure.integer,
    SqlStructure.numeric,
    SqlStructure.numeric,
    SqlStructure.integer,
    SqlStructure.integer
  ];
}