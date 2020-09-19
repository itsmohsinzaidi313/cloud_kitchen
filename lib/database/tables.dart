import 'package:food_app/database/columns.dart';
import 'package:food_app/database/columns_types.dart';
import 'package:food_app/database/table.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class Tables{

  ///[TABLES'S] NAME VARIABLES
  static const String users = 'users'; //1
  static const String shiftData = 'shift_data'; //2
  static const String categories = 'categories'; //3
  static const String item = 'item_menus'; //4
  static const String salesMaster = 'sales_master'; //5
  static const String salesDetails = 'sales_details'; //6
  static const String company = 'company'; //7
  static const String customers = 'customers'; //8
  static const String expenseCategories = 'expense_categories'; //9

  //LIST OF TABLES MAME
  static const List<String> LIST_OF_TABLES = [
    users, //1
    shiftData, //2
    categories, //3
    item, //4
    salesMaster, //5
    salesDetails, //6
    company, //7
    customers, //8
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