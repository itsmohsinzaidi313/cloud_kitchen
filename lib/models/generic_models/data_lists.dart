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
  static List<Company> listCompany;
  static List<Outlet> listOutlet;
  static List<User> listUsers;
  static List<VatAmount> listVatAmount;
  static List<Table> listTables;
  static List<Category> listCategories;
  static List<Modifier> listModifiers;
  static List<Item> listItem;
  static List<ItemModifier> listItemModifiers;
  static List<Customer> listCustomers;
  static List<PaymentMethod> listPaymentMethods;
  static List<ExpenseCategory> listExpenseCategories;
  static List<dynamic> listSales; // NOT FUNCTIONAL
  static List<dynamic> listExpenses; // NOT FUNCTIONAL
}
