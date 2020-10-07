import 'package:food_app/database/sql_structure.dart';

class DeviceTable{

  static const String tableName = 'devices'; //15

  static const String localId = 'local_id';
  static const String serverId = 'id';
  static const String outletId = 'outlet_id';
  static const String companyId = 'company_id';
  static const String deviceKey = 'device_key';
  static const String delStatus = 'del_status';
  static const String isInstalled = 'is_installed';
  static const String dateAdded = 'date_added';
  static const String dateModified = 'date_modified';

  static const List<String> columnsName = [
    localId,
    serverId,
    outletId,
    companyId,
    deviceKey,
    delStatus,
    isInstalled,
    dateAdded,
    dateModified
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