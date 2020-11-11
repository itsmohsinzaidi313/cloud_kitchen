import 'package:food_app/database/table_object/category_table.dart';
import 'package:food_app/database/table_object/company_table.dart';
import 'package:food_app/database/table_object/customer_table.dart';
import 'package:food_app/database/table_object/device_table.dart';
import 'package:food_app/database/table_object/error_detail_table.dart';
import 'package:food_app/database/table_object/error_master_table.dart';
import 'package:food_app/database/table_object/expense_categories_table.dart';
import 'package:food_app/database/table_object/item_modifier_table.dart';
import 'package:food_app/database/table_object/item_table.dart';
import 'package:food_app/database/table_object/modifier_table.dart';
import 'package:food_app/database/table_object/orders_table.dart';
import 'package:food_app/database/table_object/outlet_table.dart';
import 'package:food_app/database/table_object/payment_method_table.dart';
import 'package:food_app/database/table_object/sales_detail_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/database/table_object/setting_detail_table.dart';
import 'package:food_app/database/table_object/setting_master_table.dart';
import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/database/table_object/tables_table.dart';
import 'package:food_app/database/table_object/user_table.dart';
import 'package:food_app/database/table_object/vat_amount_table.dart';

class Tables {
  //LIST OF TABLES MAME
  static const List<String> listOfAllTables = [
    UserTable.tableName, //0
    DeviceTable.tableName, //15
    ShiftTable.tableName, //1
    CategoryTable.tableName, //2
    ItemTable.tableName, //3
    SalesMasterTable.tableName, //4
    SalesDetailTable.tableName, //5
    CompanyTable.tableName, //6
    CustomerTable.tableName, //7
    ExpenseCategoryTable.tableName, //8
    ItemModifierTable.tableName, //9
    ModifierTable.tableName, //10
    OutletTable.tableName, //11
    PaymentMethodTable.tableName, //12
    VatAmountTable.tableName, //13
    TablesTable.tableName, //14
    OrdersTable.tableName, //16
    SettingMasterTable.tableName, //17
    SettingDetailTable.tableName, //18
    ErrorMasterTable.tableName, //19
    ErrorDetailTable.tableName //20
  ];

  // static const String users = 'users'; //0
  // static const String shiftData = 'shift_data'; //1
  // static const String categories = 'categories'; //2
  // static const String item = 'item_menus'; //3
  // static const String salesMaster = 'sales_master'; //4
  // static const String salesDetails = 'sales_details'; //5
  // static const String company = 'company'; //6
  // static const String customers = 'customers'; //7
  // static const String expenseCategories = 'expense_categories'; //8
  // static const String itemModifiers = 'item_modifiers'; //9
  // static const String modifiers = 'modifiers'; //10
  // static const String outlet = 'outlet'; //11
  // static const String paymentMethods = 'payment_methods'; //12
  // static const String tables = 'tables'; //13
  // static const String vatAmount = 'vat_amount'; //14
  // static const String devices = 'devices'; //15
  // static const String orderTable = 'orders_table'; //16
}
