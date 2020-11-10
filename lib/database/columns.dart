import 'package:food_app/database/table_object/category_table.dart';
import 'package:food_app/database/table_object/company_table.dart';
import 'package:food_app/database/table_object/customer_table.dart';
import 'package:food_app/database/table_object/device_table.dart';
import 'package:food_app/database/table_object/error_detail.dart';
import 'package:food_app/database/table_object/error_master.dart';
import 'package:food_app/database/table_object/expense_categories_table.dart';
import 'package:food_app/database/table_object/item_modifier_table.dart';
import 'package:food_app/database/table_object/item_table.dart';
import 'package:food_app/database/table_object/modifier_table.dart';
import 'package:food_app/database/table_object/orders_table.dart';
import 'package:food_app/database/table_object/outlet_table.dart';
import 'package:food_app/database/table_object/payment_method_table.dart';
import 'package:food_app/database/table_object/sales_detail_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/database/table_object/setting_detail.dart';
import 'package:food_app/database/table_object/setting_master.dart';
import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/database/table_object/tables_table.dart';
import 'package:food_app/database/table_object/user_table.dart';
import 'package:food_app/database/table_object/vat_amount_table.dart';

class Columns {
  static const List<List<String>> listOfAllColumns = [
    UserTable.columnsName, //0
    DeviceTable.columnsName, //15
    ShiftTable.columnsName, //1
    CategoryTable.columnsName, //2
    ItemTable.columnsName, //3
    SalesMasterTable.columnsName, //4
    SalesDetailTable.columnsName, //5
    CompanyTable.columnsName, //6
    CustomerTable.columnsName, //7
    ExpenseCategoryTable.columnsName, //8
    ItemModifierTable.columnsName, //9
    ModifierTable.columnsName, //10
    OutletTable.columnsName, //11
    PaymentMethodTable.columnsName, //12
    VatAmountTable.columnsName, //13
    TablesTable.columnsName, //14
    OrdersTable.columnsName, //16
    SettingMasterTable.columnsName, //17
    SettingDetailTable.columnsName, //18
    ErrorMasterTable.columnsName, //19
    ErrorDetailTable.columnsName //20
  ];

  ///USER TABLE COLUMNS
  // static const List<String> users = [
  //   'local_id',
  //   'id',
  //   'full_name',
  //   'phone',
  //   'email_address',
  //   'password',
  //   'designation',
  //   'will_login',
  //   'role',
  //   'outlet_id',
  //   'company_id',
  //   'account_creation_date',
  //   'language',
  //   'last_login',
  //   'active_status',
  //   'del_status'
  // ];

  ///SHIFT_DATA TABLE COLUMNS
  // static const List<String> shiftData = [
  //   'local_id', //0
  //   'shift', //1
  //   'opening_balance', //2
  //   'closing_balance', //3
  //   'opening_balance_date_time', //4
  //   'closing_balance_date_time', //5
  //   'sale_paid_amount', //6
  //   'customer_due_receive', //7
  //   'payment_methods_sale', //8
  //   'register_status', //9
  //   'user_id', //10
  //   'outlet_id', //11
  //   'company_id', //12
  //   'register_no', //13
  //   'device_key', //14
  //   'id' //15
  // ];

  ///CATEGORIES TABLE COLUMNS
  // static const List<String> categories = [
  //   'local_id',
  //   'id',
  //   'category_name',
  //   'description',
  //   'user_id',
  //   'company_id',
  //   'del_status'
  // ];
  //
  // ///ITEM TABLE COLUMNS
  // static const List<String> item = [
  //   'local_id',
  //   'id',
  //   'code',
  //   'name',
  //   'sale_price',
  //   'photo',
  //   'category_name',
  //   'percentage',
  //   'quantity'
  // ];
  //
  // ///SALES_MASTER TABLE COLUMNS
  // static const List<String> salesMaster = [
  //   'local_id', //0
  //   'customer_id', //1
  //   'sale_no', //2
  //   'total_items', //3
  //   'sub_total', //4
  //   'paid_amount', //5
  //   'due_amount', //6
  //   'disc', //7
  //   'disc_actual', //8
  //   'vat', //9
  //   'total_payable', //10
  //   'payment_method_id', //11
  //   'close_time', //12
  //   'table_id', //13
  //   'total_item_discount_amount', //14
  //   'sub_total_with_discount', //15
  //   'sub_total_discount_amount', //16
  //   'total_discount_amount', //17
  //   'delivery_charge', //18
  //   'sub_total_discount_value', //19
  //   'sub_total_discount_type', //20
  //   'sale_date', //21
  //   'date_time', //22
  //   'order_time', //23
  //   'cooking_start_time', //24
  //   'cooking_done_time', //25
  //   'modified', //26
  //   'user_id', //27
  //   'waiter_id', //28
  //   'outlet_id', //29
  //   'order_status', //30
  //   'order_type', //31
  //   'del_status', //32
  //   'sale_vat_objects', //33
  //   'device_key', //34
  //   'id', //35
  //   'company_id', //36
  //   'is_delete' //37
  // ];
  //
  // ///SALES_DETAILS TABLE COLUMNS
  // static const List<String> salesDetails = [
  //   'id', //0
  //   'food_menu_id', //1
  //   'menu_name', //2
  //   'qty', //3
  //   'menu_price_without_discount', //4
  //   'menu_price_with_discount', //5
  //   'menu_unit_price', //6
  //   'menu_vat_percentage', //7
  //   'menu_taxes', //8
  //   'menu_discount_value', //9
  //   'discount_type', //10
  //   'menu_note', //11
  //   'discount_amount', //12
  //   'item_type', //13
  //   'cooking_status', //14
  //   'cooking_start_time', //15
  //   'cooking_done_time', //16
  //   'previous_id', //17
  //   'sales_id', //18
  //   'order_status', //19
  //   'user_id', //20
  //   'outlet_id', //21
  //   'del_status', //22
  // ];
  //
  // ///COMPANY TABLE COLUMNS
  // static const List<String> company = [
  //   'local_id',
  //   'id',
  //   'currency',
  //   'timezone',
  //   'date_format',
  //   'outlet_id',
  //   'name',
  //   'email',
  //   'phone_1',
  //   'phone_2',
  //   'address',
  //   'status',
  //   'date_added',
  //   'expiry_date',
  //   'token'
  // ];
  //
  // ///CUSTOMERS TABLE COLUMNS
  // static const List<String> customers = [
  //   'local_id', //0
  //   'id', //1
  //   'name', //2
  //   'phone', //3
  //   'email', //4
  //   'address', //5
  //   'gst_number', //6
  //   'area_id', //7
  //   'user_id', //8
  //   'company_id', //9
  //   'del_status', //10
  //   'date_of_birth', //11
  //   'date_of_anniversary' //12
  // ];
  //
  // ///EXPENSE_CATEGORIES TABLE COLUMNS
  // static const List<String> expenseCategories = [
  //   'local_id',
  //   'id',
  //   'name',
  //   'description',
  //   'user_id',
  //   'company_id',
  //   'del_status'
  // ];
  //
  // ///ITEM_MODIFIERS TABLE COLUMNS
  // static const List<String> itemModifier = [
  //   'local_id',
  //   'id',
  //   'modifier_id',
  //   'food_menu_id',
  //   'user_id',
  //   'outlet_id',
  //   'company_id',
  //   'name',
  //   'price',
  //   'del_status'
  // ];
  //
  // ///MODIFIERS TABLE COLUMNS
  // static const List<String> modifier = [
  //   'local_id',
  //   'id',
  //   'name',
  //   'price',
  //   'description',
  //   'user_id',
  //   'company_id',
  //   'del_status'
  // ];
  //
  // ///OUTLET TABLE COLUMNS
  // static const List<String> outlet = [
  //   'local_id',
  //   'id',
  //   'outlet_name',
  //   'outlet_code',
  //   'address',
  //   'phone',
  //   'invoice_print',
  //   'starting_date',
  //   'invoice_footer',
  //   'collect_tax',
  //   'pre_or_post_payment',
  //   'user_id',
  //   'company_id',
  //   'del_status'
  // ];
  //
  // ///PAYMENT_METHODS TABLE COLUMNS
  // static const List<String> paymentMethods = [
  //   'local_id',
  //   'id',
  //   'name',
  //   'description',
  //   'user_id',
  //   'company_id',
  //   'del_status'
  // ];
  //
  // ///TABLES TABLE COLUMNS
  // static const List<String> tables = [
  //   'local_id',
  //   'id',
  //   'name',
  //   'sit_capacity',
  //   'position',
  //   'description',
  //   'user_id',
  //   'outlet_id',
  //   'company_id',
  //   'del_status'
  // ];
  //
  // ///VAT_AMOUNT TABLE COLUMNS
  // static const List<String> vatAmount = [
  //   'local_id',
  //   'id',
  //   'name',
  //   'percentage',
  //   'user_id',
  //   'company_id',
  //   'del_status'
  // ];
  //
  // static const List<String> devices = [
  //   'local_id',
  //   'id',
  //   'outlet_id',
  //   'company_id',
  //   'device_key',
  //   'del_status',
  //   'is_installed',
  //   'date_added',
  //   'date_modified'
  // ];
  //
  // static const List<String> ordersTables = [
  //   'local_id', //0
  //   'persons', //1
  //   'booking_time', //2
  //   'sale_id', //3
  //   'sale_no', //4
  //   'outlet_id', //5
  //   'table_id', //6
  //   'del_status' //7
  // ];
}
