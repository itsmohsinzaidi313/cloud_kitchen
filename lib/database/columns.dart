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
    tables, //14
    devices, //15
    ordersTables, //16
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
    'shift',
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
    'id', //0
    'customer_id', //1
    'sale_no', //2
    'total_items', //3
    'sub_total', //4
    'paid_amount', //5
    'due_amount', //6
    'disc', //7
    'disc_actual', //8
    'vat', //9
    'total_payable', //10
    'payment_method_id', //11
    'close_time', //12
    'table_id', //13
    'total_item_discount_amount', //14
    'sub_total_with_discount', //15
    'sub_total_discount_amount', //16
    'total_discount_amount', //17
    'delivery_charge', //18
    'sub_total_discount_value', //19
    'sub_total_discount_type', //20
    'sale_date', //21
    'date_time', //22
    'order_time', //23
    'cooking_start_time', //24
    'cooking_done_time', //25
    'modified', //26
    'user_id', //27
    'waiter_id', //28
    'outlet_id', //29
    'order_status', //30
    'order_type', //31
    'del_status', //32
    'sale_vat_objects', //33
    'device_key', //34
    'remote_id', //35
    'company_id', //36
    'is_delete' //37
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
    'sales_id', //18
    'order_status',
    'user_id',
    'outlet_id',
    'del_status',
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
    'local_id', //0
    'id', //1
    'name', //2
    'phone', //3
    'email', //4
    'address', //5
    'gst_number', //6
    'area_id', //7
    'user_id', //8
    'company_id', //9
    'del_status', //10
    'date_of_birth', //11
    'date_of_anniversary' //12
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

  static const List<String> devices = [
    'local_id',
    'id',
    'outled_id',
    'company_id',
    'device_key',
    'del_status',
    'is_installed',
    'date_added',
    'date_modified'
  ];

  static const List<String> ordersTables = [
    'local_id',
    'persons',
    'booking_time',
    'sale_id',
    'sale_no',
    'outlet_id',
    'table_id',
    'del_status'
  ];
}
