import 'package:food_app/database/db_table.dart';
import 'package:food_app/database/project_database.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class ImportOnlineData {
  Logger _log = Config.log;
  ImportOnlineData(Database database) {
    _init(database);
  }
  Future<void> _init(Database db) async {
    String errorMsg = 'Error on import data';

    int count = 0;
    try {
      ProjectDatabase().database.then((db) async {
        List<Table> tables = await ProjectDatabase.getTables(db);
        // DataLists.onlineInstance.listUsers
        //     .forEach((element) => element.insertIntoDatabase(db));
        // _log.v('Rows Inserted: $count');
        // count = 0;
        // DataLists.onlineInstance.listCategories
        //     .forEach((element) => element.insertIntoDatabase(db));
        // _log.v('Rows Inserted: $count');
        // count = 0;
        // DataLists.onlineInstance.listItem
        //     .forEach((element) => element.insertIntoDatabase(db));
        // _log.v('Rows Inserted: $count');
        // count = 0;
        DataLists.onlineInstance.listCompany.forEach(
            (element) => tables[6].insertIntoDatabase(element.getList()));
        _log.v('Rows Inserted: $count');
        count = 0;
        // DataLists.onlineInstance.listOutlet
        //     .forEach((element) => element.insertIntoDatabase(db));
        // _log.v('Rows Inserted: $count');
        // count = 0;
        // DataLists.onlineInstance.listVatAmount
        //     .forEach((element) => element.insertIntoDatabase(db));
        // _log.v('Rows Inserted: $count');
        // count = 0;
        // DataLists.onlineInstance.listTables
        //     .forEach((element) => element.insertIntoDatabase(db));
        // _log.v('Rows Inserted: $count');
        // count = 0;
        // DataLists.onlineInstance.listModifiers
        //     .forEach((element) => element.insertIntoDatabase(db));
        // _log.v('Rows Inserted: $count');
        // count = 0;
        DataLists.onlineInstance.listItemModifiers.forEach(
            (element) => tables[10].insertIntoDatabase(element.getList()));
        _log.v('Rows Inserted: $count');
        count = 0;

        // DataLists.onlineInstance.listCustomers
        //     .forEach((element) => element.insertIntoDatabase(db));
        // _log.v('Rows Inserted: $count');
        // count = 0;

        // DataLists.onlineInstance.listPaymentMethods
        //     .forEach((element) => element.insertIntoDatabase(db));
        // _log.v('Rows Inserted: $count');
        // count = 0;

        // DataLists.onlineInstance.listExpenseCategories
        //     .forEach((element) => element.insertIntoDatabase(db));
        // _log.v('Rows Inserted: $count');
        // count = 0;
      });
    } catch (e) {
      _log.e('Error on Import', [e]);
    }
  }
}
