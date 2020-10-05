import 'package:food_app/database/table_object/category_table.dart';
import 'package:food_app/database/table_object/company_table.dart';
import 'package:food_app/database/table_object/item_table.dart';
import 'package:food_app/database/table_object/sales_detail_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/database/table_object/user_table.dart';

class Types {
  ///LIST OF [COLUMN_TYPES] LIST
  static const List<List<String>> listOfAllColumnTypes = [
    UserTable.columnsType, //0
    ShiftTable.columnsType, //1
    CategoryTable.columnsType, //2
    ItemTable.columnsType, //3
    SalesMasterTable.columnsType, //4
    SalesDetailTable.columnsType, //5
    CompanyTable.columnsType, //6
    customers, //7
    expenseCategories, //8
    itemModifier, //9
    modifier, //10
    outlet, //11
    paymentMethods, //12
    vatAmount, //13
    tables, //14
    devices, //15
    ordersTable //16
  ];

  static const String TEXT = 'TEXT';
  static const String INTEGER = 'INTEGER';
  static const String BLOB = 'BLOB';
  static const String REAL = 'REAL';
  static const String NUMERIC = 'NUMERIC';
  static const String PRIMARY_KEY = ' PRIMARY KEY';

  ///USER TABLE TYPES
  static const List<String> users = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///SHIFT_DATA TABLE TYPES
  static const List<String> shiftData = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///CATEGORIES TABLE TYPES
  static const List<String> categories = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///ITEM_MENUS TABLE TYPES
  static const List<String> item = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///SALES_MASTER TABLE TYPES
  static const List<String> salesMaster = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///SALES_DETAILS TABLE TYPES
  static const List<String> salesDetails = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///COMPANY TABLE TYPES
  static const List<String> company = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///CUSTOMERS TABLE TYPES
  static const List<String> customers = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///EXPENSE_CATEGORIES TABLE TYPES
  static const List<String> expenseCategories = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///ITEM_MODIFIERS TABLE TYPES
  static const List<String> itemModifier = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///MODIFIERS TABLE TYPES
  static const List<String> modifier = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///OUTLET TABLE TYPES
  static const List<String> outlet = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///PAYMENT_METHODS TABLE TYPES
  static const List<String> paymentMethods = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///TABLES TABLE TYPES
  static const List<String> tables = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  ///VAT_AMOUNT TABLE TYPES
  static const List<String> vatAmount = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  //DEVICES COLUMN TYPES
  static const List<String> devices = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  static const List<String> ordersTable = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];
}
