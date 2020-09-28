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
  static final DataLists onlineInstance = new DataLists();
  static final DataLists offlineInstance = new DataLists();
  static final Logger _log = Config.log;

  static void importToDatabase(Database db) async {
    try {
      await db.delete(Tables.users).whenComplete(() => onlineInstance.listUsers
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listUsers', [e]);
    }
    try {
      await db.delete(Tables.item).whenComplete(() => onlineInstance.listItem
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listItem', [e]);
    }
    try {
      db.delete(Tables.categories).whenComplete(() => onlineInstance
          .listCategories
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listCategories', [e]);
    }
    try {
      db.delete(Tables.company).whenComplete(() => onlineInstance.listCompany
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listCompany', [e]);
    }
    try {
      db.delete(Tables.outlet).whenComplete(() => onlineInstance.listOutlet
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listOutlet', [e]);
    }
    try {
      db.delete(Tables.customers).whenComplete(() => onlineInstance
          .listCustomers
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listCustomers', [e]);
    }
    try {
      db.delete(Tables.tables).whenComplete(() => onlineInstance.listTables
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listTables', [e]);
    }
    try {
      db.delete(Tables.itemModifiers).whenComplete(() => onlineInstance
          .listItemModifiers
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listItemModifiers', [e]);
    }
    try {
      db.delete(Tables.modifiers).whenComplete(() => onlineInstance
          .listModifiers
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listModifiers', [e]);
    }
    try {
      db.delete(Tables.expenseCategories).whenComplete(() => onlineInstance
          .listExpenseCategories
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listExpenseCategories', [e]);
    }
    try {
      db.delete(Tables.paymentMethods).whenComplete(() => onlineInstance
          .listPaymentMethods
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listPaymentMethods', [e]);
    }
    try {
      db.delete(Tables.vatAmount).whenComplete(() => onlineInstance
          .listVatAmount
          .forEach((element) => element.insertIntoDatabase(db)));
    } catch (e) {
      _log.e('Error On ImportToDatabase listVatAmount', [e]);
    }
  }
}
