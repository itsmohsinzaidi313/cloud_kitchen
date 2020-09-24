import 'package:food_app/database/project_database.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';

class ImportData {
  Logger _log = Config.log;
  ImportData() {
    ProjectDatabase().database.then((db) {
      int count = 0;
      DataLists.onlineInstance.listCompany.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('$count');
            count = 0;
          }));

      DataLists.onlineInstance.listOutlet.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.onlineInstance.listUsers.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.onlineInstance.listVatAmount.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.onlineInstance.listTables.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.onlineInstance.listCategories.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.onlineInstance.listModifiers.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.onlineInstance.listItem.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.onlineInstance.listItemModifiers.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.onlineInstance.listCustomers.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.onlineInstance.listPaymentMethods.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.onlineInstance.listExpenseCategories.forEach((element) =>
          element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));
    });
  }
}
