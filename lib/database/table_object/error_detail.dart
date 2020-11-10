import 'package:food_app/database/sql_structure.dart';

class ErrorDetailTable{

  static const String tableName = 'error_detail';

  static const String id = 'id';
  static const String errorMasterId = 'error_master_id';
  static const String error = 'error';

  static const List<String> columnsName = [
    id,
    errorMasterId,
    error
  ];

  static const List<String> columnsType = [
    SqlStructure.integer + SqlStructure.primaryKey,
    SqlStructure.integer,
    SqlStructure.text
  ];
}