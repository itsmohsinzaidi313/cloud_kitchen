import 'dart:developer';
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
  final List<dynamic> listSales = []; // NOT FUNCTIONAL
  final List<dynamic> listExpenses = []; // NOT FUNCTIONAL
  final int listsCount = 12;
  static final DataLists onlineInstance = new DataLists();
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
        listExpenseCategories
      ];

  static Future<bool> importToDatabase(Database db) async {
    try {
      int x = await db.delete(Tables.users);
      onlineInstance.listUsers
          .forEach((element) async => await element.insertIntoDatabase(db));
    } catch (e) {
      _log.e('Error On ImportToDatabase listUsers', [e]);
      return false;
    }
    try {
      int x = await db.delete(Tables.item);
      onlineInstance.listItem
          .forEach((element) async => await element.insertIntoDatabase(db));
    } catch (e) {
      _log.e('Error On ImportToDatabase listItem', [e]);
      return false;
    }
    try {
      int x = await db.delete(Tables.categories);
      onlineInstance.listCategories
          .forEach((element) async => await element.insertIntoDatabase(db));
    } catch (e) {
      _log.e('Error On ImportToDatabase listCategories', [e]);
      return false;
    }
    try {
      int x = await db.delete(Tables.company);
      onlineInstance.listCompany
          .forEach((element) async => await element.insertIntoDatabase(db));
    } catch (e) {
      _log.e('Error On ImportToDatabase listCompany', [e]);
      return false;
    }
    try {
      db.delete(Tables.outlet).then((value) => onlineInstance.listOutlet
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listOutlet', [e]);
      return false;
    }
    try {
      db.delete(Tables.customers).then((value) => onlineInstance.listCustomers
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listCustomers', [e]);
      return false;
    }
    try {
      db.delete(Tables.tables).then((value) => onlineInstance.listTables
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listTables', [e]);
      return false;
    }
    try {
      db.delete(Tables.itemModifiers).then((value) => onlineInstance
          .listItemModifiers
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listItemModifiers', [e]);
      return false;
    }
    try {
      db.delete(Tables.modifiers).then((value) => onlineInstance.listModifiers
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listModifiers', [e]);
      return false;
    }
    try {
      db.delete(Tables.expenseCategories).then((value) => onlineInstance
          .listExpenseCategories
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listExpenseCategories', [e]);
      return false;
    }
    try {
      db.delete(Tables.paymentMethods).then((value) => onlineInstance
          .listPaymentMethods
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listPaymentMethods', [e]);
      return false;
    }
    try {
      db.delete(Tables.vatAmount).then((value) => onlineInstance.listVatAmount
          .forEach((element) async => await element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listVatAmount', [e]);
      return false;
    }
    return true;
  }

  static Future<bool> importToMemory(Database db) async {
    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.categories);
      listMap.forEach((element) {
        DataLists.onlineInstance.listCategories
            .add(new Category.fromJson(element));
      });
      DataLists.onlineInstance.listCategories
          .forEach((element) => log('${element.categoryName}'));
    } catch (e) {
      _log.e('ERROR ON importToMemory listCategories', [e]);
      return false;
    }
    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.users);
      listMap.forEach((element) {
        DataLists.onlineInstance.listUsers.add(new User.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listUsers', [e]);
      return false;
    }
    try {
      List<Map<String, dynamic>> listMap = await db.query(Tables.categories);
      listMap.forEach((element) {
        DataLists.onlineInstance.listUsers.add(new User.fromJson(element));
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listUsers', [e]);
      return false;
    }
    return true;
  }
}
