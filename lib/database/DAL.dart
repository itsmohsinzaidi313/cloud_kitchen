import 'package:food_app/database/project_database.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/models/objects/category.dart';
import 'package:food_app/models/objects/company.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/expense_category.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/item_modifier.dart';
import 'package:food_app/models/objects/modifier.dart';
import 'package:food_app/models/objects/outlet.dart';
import 'package:food_app/models/objects/payment_method.dart';
import 'package:food_app/models/objects/table.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/objects/vatamount.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DAL {
  static final DAL dal = new DAL._internal();

  DAL._internal();
  bool _isInitialized = false;
  bool get iniTialized => _isInitialized;
  Logger _log = Config.log;
  void importFromDatabase(Future<Database> future) {
    future
        .then((db) {
          ProjectDatabase.getTables(db).then((listTables) {
            listTables.forEach((table) {
              table.getDataFromDatabase().then((listMap) {
                listMap.forEach((map) {
                  if (table.tableName == Tables.listofAllTables[0])
                    DataLists.instance.listUsers
                        .add(new User.fromJson(map));
                  else if (table.tableName == Tables.listofAllTables[2])
                    DataLists.instance.listCategories
                        .add(new Category.fromJson(map));
                  else if (table.tableName == Tables.listofAllTables[3])
                    DataLists.instance.listItem
                        .add(new Item.fromJson(map));
                  else if (table.tableName == Tables.listofAllTables[7])
                    DataLists.instance.listCompany
                        .add(new Company.fromJson(map));
                  else if (table.tableName == Tables.listofAllTables[8])
                    DataLists.instance.listCustomers
                        .add(new Customer.fromJson(map));
                  else if (table.tableName == Tables.listofAllTables[9])
                    DataLists.instance.listExpenseCategories
                        .add(new ExpenseCategory.fromJson(map));
                  else if (table.tableName == Tables.listofAllTables[10])
                    DataLists.instance.listItemModifiers
                        .add(new ItemModifier.fromJson(map));
                  else if (table.tableName == Tables.listofAllTables[11])
                    DataLists.instance.listModifiers
                        .add(new Modifier.fromJson(map));
                  else if (table.tableName == Tables.listofAllTables[12])
                    DataLists.instance.listOutlet
                        .add(new Outlet.fromJson(map));
                  else if (table.tableName == Tables.listofAllTables[13])
                    DataLists.instance.listPaymentMethods
                        .add(new PaymentMethod.fromJson(map));
                  else if (table.tableName == Tables.listofAllTables[14])
                    DataLists.instance.listTables
                        .add(new Table.fromJson(map));
                  else if (table.tableName == Tables.listofAllTables[15])
                    DataLists.instance.listVatAmount
                        .add(new VatAmount.fromJson(map));
                });
              });
            });
          });
        })
        .whenComplete(() => _isInitialized = true)
        .catchError((onError) => _log.e('Error on DAL import', [onError]));
    for (int i = 0; i < DataLists.instance.getInList().length; i++) {
      _log.i(DataLists.instance.getInList()[i].length);
    }
  }
}
