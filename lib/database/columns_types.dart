class Types {
  ///LIST OF [COLUMN_TYPES] LIST
  static const List<List<String>> listofAllColumnTypes = [
    users, //1
    shiftData, //2
    categories, //3
    item, //4
    salesMaster, //5
    salesDetails, //6
    company, //7
    customers, //8
    expenseCategories, //9
    itemModifier, //10
    modifier, //11
    outlet, //12
    paymentMethods, //13
    vatAmount, //13
    tables, //13
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
}
