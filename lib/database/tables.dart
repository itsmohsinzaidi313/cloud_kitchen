import 'package:food_app/database/columns.dart';
import 'package:food_app/database/columns_types.dart';
import 'package:food_app/database/table.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class Tables{

  ///[TABLES'S] NAME VARIABLES
  static const String _users = 'users'; //1
  static const String _shiftData = 'shift_data'; //2
  static const String _categories = 'categories'; //3
  static const String _itemMenus = 'item_menus'; //4
  static const String _salesMaster = 'sales_master'; //5
  static const String _salesDetails = 'sales_details'; //6

  //LIST OF TABLES MAME
  static const List<String> LIST_OF_TABLES = [
    _users, //1
    _shiftData, //2
    _categories, //3
    _itemMenus, //4
    _salesMaster, //5
    _salesDetails //6
  ];

  //TODO
  static Future<List<Table>> getTables() async {
    List<Table> tables = [];
    Database db = await Lib().getDatabase();
    for (int i = 0; i < tables.length; i++) {
      tables.add(new Table(database: db,
        tableName: LIST_OF_TABLES[i],
        listOfColumnsName: Columns.LIST_OF_ALL_COLUMNS[i],
        listOfColumnsTypes: Types.LIST_OF_ALL_TYPES[i]
      ));
    }
    return tables;
  }
}