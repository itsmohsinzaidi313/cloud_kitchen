import 'package:food_app/database/project_database.dart';
import 'package:food_app/models/generic_models/data_lists.dart';
import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';

class ImportData {
  Logger _log = Config.log;
  ImportData() {
    ProjectDatabase().database.then((db) {
      int count = 0;
      DataLists.listCompany.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('$count');
            count = 0;
          }));

      DataLists.listOutlet.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.listUsers.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.listVatAmount.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.listTables.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.listCategories.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.listModifiers.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.listItem.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.listItemModifiers.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.listCustomers.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.listPaymentMethods.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));

      DataLists.listExpenseCategories.forEach((element) => element
              .insertIntoDatabase(db)
              .then((value) => value ? count++ : 0)
              .whenComplete(() {
            _log.v('Rows Inserted: $count');
            count = 0;
          }));
    });
  }
}
