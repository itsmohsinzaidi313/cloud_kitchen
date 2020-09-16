import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';

class Table{

  //LOGGER
  static Logger _log = Config.log;

  //VARIABLES
  final String tableName;
  final List<String> listOfTablesColumns;
  final List<String> listOfColumnsTypes;

  Table({ this.tableName, this.listOfTablesColumns, this.listOfColumnsTypes});
}