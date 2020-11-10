import '../sql_structure.dart';

class ErrorMasterTable{

  static const String tableName = 'error_master';

  static const String id = 'id';
  static const String className = 'class_name';
  static const String dateTime = 'date_time';
  static const String title = 'title';

  static const List<String> columnsName = [
    id,
    className,
    dateTime,
    title
  ];

  static const List<String> columnsType = [
    SqlStructure.integer + SqlStructure.primaryKey,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text
  ];
}