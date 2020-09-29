class Columns {
  
  static const List<List<String>> listofAllColumns = [
    users, //0
    shiftData, //1
    categories, //2
    item, //3
    salesMaster, //4
    salesDetails, //5
    company, //6
    customers, //7
    expenseCategories, //8
    itemModifier, //9
    modifier, //10
    outlet, //11
    paymentMethods, //12
    vatAmount, //13
    tables //14
  ];

  ///USER TABLE COLUMNS
  static const List<String> users = [
    'local_id',
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
    'local_id',
    'id',
    'category_name',
    'description',
    'user_id',
    'company_id',
    'del_status'
  ];

  ///ITEM TABLE COLUMNS
  static const List<String> item = [
    'local_id',
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
    'company_id',
    'is_delete'
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
    'sales_master_id',
    'order_status',
    'user_id',
    'outlet_id',
    'del_status'
  ];

  ///COMPANY TABLE COLUMNS
  static const List<String> company = [
    'local_id',
    'id',
    'currency',
    'timezone',
    'date_format',
    'outlet_id',
    'name',
    'email',
    'phone_1',
    'phone_2',
    'address',
    'status',
    'date_added',
    'expiry_date',
    'token'
  ];

  ///CUSTOMERS TABLE COLUMNS
  static const List<String> customers = [
    'local_id',
    'id',
    'name',
    'phone',
    'email',
    'address',
    'gst_number',
    'area_id',
    'user_id',
    'company_id',
    'del_status',
    'date_of_birth',
    'date_of_anniversary'
  ];

  ///EXPENSE_CATEGORIES TABLE COLUMNS
  static const List<String> expenseCategories = [
    'local_id',
    'id',
    'name',
    'description',
    'user_id',
    'company_id',
    'del_status'
  ];

  ///ITEM_MODIFIERS TABLE COLUMNS
  static const List<String> itemModifier = [
    'local_id',
    'id',
    'modifier_id',
    'food_menu_id',
    'user_id',
    'outlet_id',
    'company_id',
    'name',
    'price',
    'del_status'
  ];

  ///MODIFIERS TABLE COLUMNS
  static const List<String> modifier = [
    'local_id',
    'id',
    'name',
    'price',
    'description',
    'user_id',
    'company_id',
    'del_status'
  ];

  ///OUTLET TABLE COLUMNS
  static const List<String> outlet = [
    'local_id',
    'id',
    'outlet_name',
    'outlet_code',
    'address',
    'phone',
    'invoice_print',
    'starting_date',
    'invoice_footer',
    'collect_tax',
    'pre_or_post_payment',
    'user_id',
    'company_id',
    'del_status'
  ];

  ///PAYMENT_METHODS TABLE COLUMNS
  static const List<String> paymentMethods = [
    'local_id',
    'id',
    'name',
    'description',
    'user_id',
    'company_id',
    'del_status'
  ];

  ///TABLES TABLE COLUMNS
  static const List<String> tables = [
    'local_id',
    'id',
    'name',
    'sit_capacity',
    'position',
    'description',
    'user_id',
    'outlet_id',
    'company_id',
    'del_status'
  ];

  ///VAT_AMOUNT TABLE COLUMNS
  static const List<String> vatAmount = [
    'local_id',
    'id',
    'name',
    'percentage',
    'user_id',
    'company_id',
    'del_status'
  ];
}
