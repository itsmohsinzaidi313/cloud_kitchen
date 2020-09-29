import 'package:food_app/database/tables.dart';
import 'package:food_app/models/objects/category.dart';
import 'package:food_app/models/objects/company.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/device.dart';
import 'package:food_app/models/objects/expense_category.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/item_modifier.dart';
import 'package:food_app/models/objects/modifier.dart';
import 'package:food_app/models/objects/outlet.dart';
import 'package:food_app/models/objects/payment_method.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/objects/vatamount.dart';
import 'package:food_app/models/objects/table.dart';
import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DataLists {
  final List<Company> listCompany = [];
  final List<Outlet> listOutlet = [];
  final List<User> listUsers = [];
  final List<VatAmount> listVatAmount = [];
  final List<Table> listTables = [];
  final List<Category> listCategories = [];
  final List<Modifier> listModifiers = [];
  final List<Item> listItem = [];
  final List<ItemModifier> listItemModifiers = [];
  final List<Customer> listCustomers = [];
  final List<PaymentMethod> listPaymentMethods = [];
  final List<ExpenseCategory> listExpenseCategories = [];
  final List<Device> listDevices = [];
  final List<dynamic> listSales = []; // NOT FUNCTIONAL
  final List<dynamic> listExpenses = []; // NOT FUNCTIONAL
  final int listsCount = 12;
  static final DataLists instance = new DataLists();
  static final Logger _log = Config.log;
  List<List> getInList() => [
        listCompany,
        listOutlet,
        listUsers,
        listVatAmount,
        listTables,
        listCategories,
        listModifiers,
        listItem,
        listItemModifiers,
        listCustomers,
        listPaymentMethods,
        listExpenseCategories,
        listDevices
      ];

  static Future<bool> importToDatabase(Database db) async {
    try {
      int x = await db.delete(Tables.users);
      instance.listUsers
          .forEach((element) async => await element.insertIntoDatabase(db));
    } catch (e) {
      _log.e('Error On ImportToDatabase listUsers', [e]);
      return false;
    }
    try {
      int x = await db.delete(Tables.item);
      instance.listItem
          .forEach((element) async => await element.insertIntoDatabase(db));
    } catch (e) {
      _log.e('Error On ImportToDatabase listItem', [e]);
      return false;
    }
    try {
      int x = await db.delete(Tables.categories);
      instance.listCategories
          .forEach((element) async => await element.insertIntoDatabase(db));
    } catch (e) {
      _log.e('Error On ImportToDatabase listCategories', [e]);
      return false;
    }
    try {
      int x = await db.delete(Tables.company);
      instance.listCompany
          .forEach((element) async => await element.insertIntoDatabase(db));
    } catch (e) {
      _log.e('Error On ImportToDatabase listCompany', [e]);
      return false;
    }
    try {
      db.delete(Tables.outlet).then((value) => instance.listOutlet
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listOutlet', [e]);
      return false;
    }
    try {
      db.delete(Tables.customers).then((value) => instance.listCustomers
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listCustomers', [e]);
      return false;
    }
    try {
      db.delete(Tables.tables).then((value) => instance.listTables
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listTables', [e]);
      return false;
    }
    try {
      db.delete(Tables.itemModifiers).then((value) => instance.listItemModifiers
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listItemModifiers', [e]);
      return false;
    }
    try {
      db.delete(Tables.modifiers).then((value) => instance.listModifiers
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listModifiers', [e]);
      return false;
    }
    try {
      db.delete(Tables.expenseCategories).then((value) => instance
          .listExpenseCategories
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listExpenseCategories', [e]);
      return false;
    }
    try {
      db.delete(Tables.paymentMethods).then((value) => instance
          .listPaymentMethods
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listPaymentMethods', [e]);
      return false;
    }
    try {
      db.delete(Tables.vatAmount).then((value) => instance.listVatAmount
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listVatAmount', [e]);
      return false;
    }
    try {
      db.delete(Tables.devices).then((value) => instance.listDevices
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listDevices', [e]);
      return false;
    }
    showDataCount();
    return true;
  }

  static Future<bool> importToMemory(Database db) async {
    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.users);
      listMap.forEach((element) {
        DataLists.instance.listUsers.add(new User.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listUsers', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.categories);
      listMap.forEach((element) {
        DataLists.instance.listCategories.add(new Category.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listCategories', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.item);
      listMap.forEach((element) {
        DataLists.instance.listItem.add(new Item.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listItem', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.company);
      listMap.forEach((element) {
        DataLists.instance.listCompany.add(new Company.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listCompany', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.customers);
      listMap.forEach((element) {
        DataLists.instance.listCustomers.add(new Customer.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listCustomers', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.tables);
      listMap.forEach((element) {
        DataLists.instance.listTables.add(new Table.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listTables', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.vatAmount);
      listMap.forEach((element) {
        DataLists.instance.listVatAmount.add(new VatAmount.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listVatAmount', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.outlet);
      listMap.forEach((element) {
        DataLists.instance.listOutlet.add(new Outlet.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listOutlet', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.modifiers);
      listMap.forEach((element) {
        DataLists.instance.listModifiers.add(new Modifier.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listModifiers', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.itemModifiers);
      listMap.forEach((element) {
        DataLists.instance.listItemModifiers
            .add(new ItemModifier.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listItemModifiers', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap =
          await db.query(Tables.paymentMethods);
      listMap.forEach((element) {
        DataLists.instance.listPaymentMethods
            .add(new PaymentMethod.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listPaymentMethods', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap =
          await db.query(Tables.expenseCategories);
      listMap.forEach((element) {
        DataLists.instance.listExpenseCategories
            .add(new ExpenseCategory.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listExpenseCategories', [e]);
      return false;
    }

    try {
      List<Map<String, dynamic>> listMap =
          await db.query(Tables.devices);
      listMap.forEach((element) {
        DataLists.instance.listDevices
            .add(new Device.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listDevices', [e]);
      return false;
    }
    showDataCount();
    return true;
  }

  static void showDataCount() {
    _log.v('Users: ${DataLists.instance.listUsers.length.toString()}');
    _log.v('Devics: ${DataLists.instance.listDevices.length.toString()}');
    _log.v('Categories: ${DataLists.instance.listCategories.length.toString()}');
    _log.v('Item: ${DataLists.instance.listItem.length.toString()}');
    _log.v('Modifiers: ${DataLists.instance.listModifiers.length.toString()}');
    _log.v('Item Modifiers: ${DataLists.instance.listItemModifiers.length.toString()}');
    _log.v('Tables: ${DataLists.instance.listTables.length.toString()}');
    _log.v('Payment Methods: ${DataLists.instance.listPaymentMethods.length.toString()}');
    _log.v('Expense Categories: ${DataLists.instance.listExpenseCategories.length.toString()}');
    _log.v('Outlet: ${DataLists.instance.listOutlet.length.toString()}');
    _log.v('VatAmount: ${DataLists.instance.listVatAmount.length.toString()}');
    _log.v('Customers: ${DataLists.instance.listCustomers.length.toString()}');
  }
}
