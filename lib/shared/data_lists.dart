import 'dart:convert';

import 'package:food_app/bloc/dialog_message_bloc.dart';
import 'package:food_app/database/table_object/category_table.dart';
import 'package:food_app/database/table_object/company_table.dart';
import 'package:food_app/database/table_object/customer_table.dart';
import 'package:food_app/database/table_object/device_table.dart';
import 'package:food_app/database/table_object/expense_categories_table.dart';
import 'package:food_app/database/table_object/item_modifier_table.dart';
import 'package:food_app/database/table_object/item_table.dart';
import 'package:food_app/database/table_object/modifier_table.dart';
import 'package:food_app/database/table_object/outlet_table.dart';
import 'package:food_app/database/table_object/payment_method_table.dart';
import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/database/table_object/tables_table.dart';
import 'package:food_app/database/table_object/user_table.dart';
import 'package:food_app/database/table_object/vat_amount_table.dart';
import 'package:food_app/models/objects/category.dart';
import 'package:food_app/models/objects/company.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/device.dart';
import 'package:food_app/models/objects/expense_category.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/item_modifier.dart';
import 'package:food_app/models/objects/modifier.dart';
import 'package:food_app/models/objects/my_object.dart';
import 'package:food_app/models/objects/outlet.dart';
import 'package:food_app/models/objects/payment_method.dart';
import 'package:food_app/models/objects/register.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/objects/vat_amount.dart';
import 'package:food_app/models/objects/table.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DataLists {
  static String dialogUpdatedMessage = 'Started';

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
  final List<Register> listRegisters = [];
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

  // INSERT DATA INTO DATABASE FROM ONLINE SOURCE
  static Future<bool> importToDatabase(
      Database db, DialogMessageBloc bloc) async {
    try {
      await importListToDatabase(
              tableName: UserTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listUsers,
              objectNameOfList: 'User')
          ? _log.v('Users inserted')
          : _log.v('Users not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listUsers', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: ItemTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listItem,
              objectNameOfList: 'Item')
          ? _log.v('Items inserted')
          : _log.v('Items not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listItem', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: CategoryTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listCategories,
              objectNameOfList: 'Category')
          ? _log.v('Categories inserted')
          : _log.v('Categories not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listCategories', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: CompanyTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listCompany,
              objectNameOfList: 'Company')
          ? _log.v('Company inserted')
          : _log.v('Company not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listCompany', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: OutletTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listOutlet,
              objectNameOfList: 'Outlet')
          ? _log.v('Outlet inserted')
          : _log.v('Outlet not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listOutlet', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: CustomerTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listCustomers,
              objectNameOfList: 'Customer')
          ? _log.v('Customer inserted')
          : _log.v('Customer not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listCustomers', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: TablesTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listTables,
              objectNameOfList: 'Table')
          ? _log.v('Tables inserted')
          : _log.v('Tables not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listTables', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: ItemModifierTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listItemModifiers,
              objectNameOfList: 'ItemModifier')
          ? _log.v('ItemModifier inserted')
          : _log.v('ItemModifier not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listItemModifiers', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: ModifierTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listModifiers,
              objectNameOfList: 'Modifier')
          ? _log.v('Modifier inserted')
          : _log.v('Modifier not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listModifiers', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: ExpenseCategoryTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listExpenseCategories,
              objectNameOfList: 'ExpenseCategory')
          ? _log.v('ExpenseCategory inserted')
          : _log.v('ExpenseCategory not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listExpenseCategories', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: PaymentMethodTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listPaymentMethods,
              objectNameOfList: 'PaymentMethod')
          ? _log.v('PaymentMethod inserted')
          : _log.v('PaymentMethod not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listPaymentMethods', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: VatAmountTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listVatAmount,
              objectNameOfList: 'VatAmount')
          ? _log.v('VatAmount inserted')
          : _log.v('VatAmount inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listVatAmount', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: DeviceTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listDevices,
              objectNameOfList: 'Device')
          ? _log.v('Device inserted')
          : _log.v('Device inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listDevices', [e]);
      return false;
    }
    try {
      await importListToDatabase(
              tableName: ShiftTable.tableName,
              bloc: bloc,
              anyList: DataLists.instance.listRegisters,
              objectNameOfList: 'Register')
          ? _log.v('Shift inserted')
          : _log.v('Shift not inserted');
    } catch (e) {
      _log.e('Error On ImportToDatabase listRegisters', [e]);
      return false;
    }
    showDataCount();
    return true;
  }

  //LOAD DATA TO MEMORY FROM DATABASE
  static Future<bool> importToMemory(
      Database db, DialogMessageBloc bloc) async {
    try {
      int count = 1;
      List<Map<String, dynamic>> listMap = await db.query(UserTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listUsers.add(new User.fromJson(element));
        dialogUpdatedMessage =
            'Loading Users ... $count/${listMap.length} ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listUsers', [e]);
      return false;
    }

    try {
      int count = 1;
      List<Map<String, dynamic>> listMap =
          await db.query(CategoryTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listCategories.add(new Category.fromJson(element));
        dialogUpdatedMessage =
            'Loading Categories ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listCategories', [e]);
      return false;
    }

    try {
      int count = 1;
      List<Map<String, dynamic>> listMap = await db.query(ItemTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listItem.add(new Item.fromJson(element));
        dialogUpdatedMessage =
        'Loading Items ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listItem', [e]);
      return false;
    }

    try {
      int count = 1;
      List<Map<String, dynamic>> listMap =
          await db.query(CompanyTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listCompany.add(new Company.fromJson(element));
        dialogUpdatedMessage =
        'Loading Companies ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listCompany', [e]);
      return false;
    }

    try {
      int count = 1;

      List<Map<String, dynamic>> listMap =
          await db.query(CustomerTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listCustomers.add(new Customer.fromJson(element));
        dialogUpdatedMessage =
        'Loading Customers ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listCustomers', [e]);
      return false;
    }

    try {
      int count = 1;

      List<Map<String, dynamic>> listMap =
          await db.query(TablesTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listTables.add(new Table.fromJson(element));
        dialogUpdatedMessage =
        'Loading Tables ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listTables', [e]);
      return false;
    }

    try {
      int count = 1;

      List<Map<String, dynamic>> listMap =
          await db.query(VatAmountTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listVatAmount.add(new VatAmount.fromJson(element));
        dialogUpdatedMessage =
        'Loading Vat Amounts ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listVatAmount', [e]);
      return false;
    }

    try {
      int count = 1;

      List<Map<String, dynamic>> listMap =
          await db.query(OutletTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listOutlet.add(new Outlet.fromJson(element));
        dialogUpdatedMessage =
        'Loading Outlets ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listOutlet', [e]);
      return false;
    }

    try {
      int count = 1;

      List<Map<String, dynamic>> listMap =
          await db.query(ModifierTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listModifiers.add(new Modifier.fromJson(element));
        dialogUpdatedMessage =
        'Loading Modifiers ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listModifiers', [e]);
      return false;
    }

    try {
      int count = 1;

      List<Map<String, dynamic>> listMap =
          await db.query(ItemModifierTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listItemModifiers
            .add(new ItemModifier.fromJson(element));
        dialogUpdatedMessage =
        'Loading Item Modifiers ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listItemModifiers', [e]);
      return false;
    }

    try {
      int count = 1;

      List<Map<String, dynamic>> listMap =
          await db.query(PaymentMethodTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listPaymentMethods
            .add(new PaymentMethod.fromJson(element));
        dialogUpdatedMessage =
        'Loading Payment Methods ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listPaymentMethods', [e]);
      return false;
    }

    try {
      int count = 1;

      List<Map<String, dynamic>> listMap =
          await db.query(ExpenseCategoryTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listExpenseCategories
            .add(new ExpenseCategory.fromJson(element));
        dialogUpdatedMessage =
        'Loading Expense Categories ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listExpenseCategories', [e]);
      return false;
    }

    try {
      int count = 1;

      List<Map<String, dynamic>> listMap =
          await db.query(DeviceTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listDevices.add(new Device.fromJson(element));
        dialogUpdatedMessage =
        'Loading Devices ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listDevices', [e]);
      return false;
    }

    try {
      int count = 1;

      List<Map<String, dynamic>> listMap = await db.query(ShiftTable.tableName);
      listMap.forEach((element) {
        DataLists.instance.listRegisters.add(new Register.fromJson(element));
        dialogUpdatedMessage =
        'Loading Registers ... $count/${listMap.length } ';
        Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
        count++;
      });
    } catch (e) {
      _log.e('ERROR ON importToMemory listRegisters', [e]);
      return false;
    }
    showDataCount();
    if (DataLists.instance.listUsers.isNotEmpty)
      return true;
    else
      return false;
  }

  static void showDataCount() {
    _log.v('Users: ${DataLists.instance.listUsers.length.toString()}');
    _log.v('Devics: ${DataLists.instance.listDevices.length.toString()}');
    _log.v(
        'Categories: ${DataLists.instance.listCategories.length.toString()}');
    _log.v('Item: ${DataLists.instance.listItem.length.toString()}');
    _log.v('Modifiers: ${DataLists.instance.listModifiers.length.toString()}');
    _log.v(
        'Item Modifiers: ${DataLists.instance.listItemModifiers.length.toString()}');
    _log.v('Tables: ${DataLists.instance.listTables.length.toString()}');
    _log.v(
        'Payment Methods: ${DataLists.instance.listPaymentMethods.length.toString()}');
    _log.v(
        'Expense Categories: ${DataLists.instance.listExpenseCategories.length.toString()}');
    _log.v('Outlet: ${DataLists.instance.listOutlet.length.toString()}');
    _log.v('VatAmount: ${DataLists.instance.listVatAmount.length.toString()}');
    _log.v('Customers: ${DataLists.instance.listCustomers.length.toString()}');
    _log.v('Registers: ${DataLists.instance.listRegisters.length.toString()}');
  }

  static Future<bool> importListToDatabase(
      {String tableName,
      String objectNameOfList,
      List anyList,
      DialogMessageBloc bloc}) async {
    Database db = Config.database;
    int count = 1;
    await db.delete(tableName);
    anyList.forEach((element) async {
      await element.insertIntoDatabase(db);
      String newMessage =
          'Inserting $objectNameOfList ... $count/${anyList.length} ';
      Lib.dialogMessageUpdate(newMessage: newMessage, bloc: bloc);
      count++;
    });
    return true;
  }

  // static String getDataTypeOfListElement(int count){
  //   var varType = DataLists.instance.getInList()[count].runtimeType.toString();
  //   String startVar = 'List<';
  //   String endVar = '>';
  //   int startIndex = varType.indexOf(startVar);
  //   int endIndex = varType.indexOf(endVar);
  //   String _type = varType.substring(startIndex + startVar.length, endIndex );
  //   return _type;
  // }
  //
  // static MyObject getAnyObject(String type, Map<String, dynamic> map){
  //   MyObject myObject;
  //   if(type == 'Item') {
  //     myObject = Item.fromJson(map);
  //   }
  //   return myObject;
  // }


  // static Future<bool> importListToMemory(
  //     {String tableName,
  //     String objectNameOfList,
  //     List anyList,
  //     DialogMessageBloc bloc,
  //     Function func(Map<String, dynamic> map)}) async {
  //   Database db = Config.database;
  //   int count = 1;
  //   List<Map<String, dynamic>> listMap = await db.query(UserTable.tableName);
  //   listMap.forEach((element) {
  //     anyList.add(func(element));
  //     dialogUpdatedMessage =
  //         'Loading Register ... $count/${instance.listUsers.length } ';
  //     Lib.dialogMessageUpdate(newMessage: dialogUpdatedMessage, bloc: bloc);
  //     count++;
  //   });
  // }
}
