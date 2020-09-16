class Types{

  ///LIST OF [COLUMN_TYPES] LIST
  static const List<List<String>> LIST_OF_ALL_TYPES = [
    users, //1
    shiftData, //2
    categories, //3
    itemMenus, //4
    salesMaster, //5
    salesDetails, //6
  ];

  ///USER TABLE TYPES
  static const List<String> users = [
    'INTEGER',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'INTEGER',
    'INTEGER',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT'
  ];

  ///SHIFT_DATA TABLE TYPES
  static const List<String> shiftData = [
    'INTEGER',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'INTEGER',
    'INTEGER',
    'INTEGER',
    'TEXT',
    'TEXT',
    'INTEGER'
  ];

  ///CATEGORIES TABLE TYPES
  static const List<String> categories = [
    'INTEGER',
    'TEXT',
    'TEXT',
    'INTEGER',
    'INTEGER',
    'TEXT'
  ];

  ///ITEM_MENUS TABLE TYPES
  static const List<String> itemMenus = [
    'INTEGER',
    'TEXT',
    'TEXT',
    'TEXT',
    'INTEGER',
    'INTEGER',
    'TEXT',
    'INTEGER'
  ];

  ///SALES_MASTER TABLE TYPES
  static const List<String> salesMaster = [
    'INTEGER',
    'INTEGER',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'INTEGER',
    'TEXT',
    'INTEGER',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'INTEGER',
    'INTEGER',
    'INTEGER',
    'INTEGER',
    'INTEGER',
    'TEXT',
    'TEXT',
    'TEXT',
    'INTEGER',
    'INTEGER'
  ];

  ///SALES_DETAILS TABLE TYPES
  static const List<String> salesDetails = [
    'INTEGER',
    'INTEGER',
    'TEXT',
    'INTEGER',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'INTEGER',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'TEXT',
    'INTEGER',
    'INTEGER',
    'INTEGER',
    'INTEGER',
    'INTEGER',
    'TEXT'
  ];
}