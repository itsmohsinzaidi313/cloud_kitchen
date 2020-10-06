import 'package:food_app/database/sql_structure.dart';

class VatAmountTable{

  static const String localId = 'local_id';
  static const String serverId = 'id';
  static const String name = 'name';
  static const String percentage = 'percentage';
  static const String userId = 'company_id';
  static const String companyId = 'user_id';
  static const String delStatus = 'del_status';

  static const List<String> columnsName = [
    localId,
    serverId,
    name,
    percentage,
    userId,
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
    SqlStructure.text
  ];
}