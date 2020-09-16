class Columns{

  ///LIST OF [COLUMNS_NAME] LIST
  static const List<List<String>> LIST_OF_ALL_COLUMNS = [
    users, //1
    shiftData, //2
    categories, //3
    itemMenus, //4
    salesMaster, //5
    salesDetails, //6
  ];

  ///USER TABLE COLUMNS
  static const List<String> users = [
  'id',
  'full_name',
  'phone',
  'email_address',
  'password',
  'designation',
  'will_login',
  'role',
  'outlet_id',
  'company_id',
  'account_creation_date',
  'language',
  'last_login',
  'active_status',
  'del_status'
  ];

  ///SHIFT_DATA TABLE COLUMNS
  static const List<String> shiftData = [
  'id',
  'opening_balance',
  'closing_balance',
  'opening_balance_date_time',
  'closing_balance_date_time',
  'sale_paid_amount',
  'customer_due_receive',
  'payment_methods_sale',
  'register_status',
  'user_id',
  'outlet_id',
  'company_id',
  'register_no',
  'device_key',
  'remote_id'
  ];

  ///CATEGORIES TABLE COLUMNS
  static const List<String> categories = [
  'id',
  'category_name',
  'description',
  'user_id',
  'company_id',
  'del_status'
  ];

  ///ITEM_MENUS TABLE COLUMNS
  static const List<String> itemMenus = [
  'id',
  'code',
  'name',
  'sale_price',
  'photo',
  'category_name',
  'percentage',
  'quantity'
  ];  
  
  ///SALES_MASTER TABLE COLUMNS
  static const List<String> salesMaster = [
  'id',
  'customer_id',
  'sale_no',
  'total_items',
  'sub_total',
  'paid_amount',
  'due_amount',
  'disc',
  'disc_actual',
  'vat',
  'total_payable',
  'payment_method_id',
  'close_time',
  'table_id',
  'total_item_discount_amount',
  'sub_total_with_discount',
  'sub_total_discount_amount',
  'total_discount_amount',
  'delivery_charge',
  'sub_total_discount_value',
  'sub_total_discount_type',
  'sale_date',
  'date_time',
  'order_time',
  'cooking_start_time',
  'cooking_done_time',
  'modified',
  'user_id',
  'waiter_id',
  'outlet_id',
  'order_status',
  'order_type',
  'del_status',
  'sale_vat_objects',
  'device_key',
  'remote_id',
  'company_id'
  ];

  ///SALES_DETAILS TABLE COLUMNS
  static const List<String> salesDetails = [
  'id',
  'food_menu_id',
  'menu_name',
  'qty',
  'menu_price_without_discount',
  'menu_price_with_discount',
  'menu_unit_price',
  'menu_vat_percentage',
  'menu_taxes',
  'menu_discount_value',
  'discount_type',
  'menu_note',
  'discount_amount',
  'item_type',
  'cooking_status',
  'cooking_start_time',
  'cooking_done_time',
  'previous_id',
  'sales_id',
  'order_status',
  'user_id',
  'outlet_id',
  'del_status'
  ];
}