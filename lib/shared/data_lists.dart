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

  static final DataLists onlineInstance = new DataLists();
  static final DataLists offlineInstance = new DataLists();
}
