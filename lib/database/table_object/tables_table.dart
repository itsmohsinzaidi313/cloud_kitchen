import 'package:food_app/database/sql_structure.dart';

class TablesTable{

  static const String localId = 'local_id';
  static const String serverId = 'id';
  static const String name = 'name';
  static const String sitCapacity = 'sit_capacity';
  static const String position = 'position';
  static const String description = 'description';
  static const String userId = 'user_id';
  static const String outletId = 'outlet_id';
  static const String companyId = 'company_id';
  static const String delStatus = 'del_status';

  static const List<String> columnsName = [
    localId,
    serverId,
    name,
    sitCapacity,
    position,
    description,
    userId,
    outletId,
    companyId,
    delStatus
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