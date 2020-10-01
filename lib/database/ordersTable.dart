class OrdersTable {
  static const String tableName = 'orders_table';
  static const String localId = 'local_id';
  static const String persons = 'persons';
  static const String bookingTime = 'booking_time';
  static const String saleId = 'sale_id';
  static const String saleNo = 'sale_no';
  static const String outletId = 'outlet_id';
  static const String tableId = 'table_id';
  static const String delStatus = 'del_status';
  
  static const List<String> ordersTables = [
    localId,
    persons,
    bookingTime,
    saleId,
    saleNo,
    outletId,
    tableId,
    delStatus
  ];

  static const List<String> ordersTable = [
    INTEGER + PRIMARY_KEY,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT,
    TEXT
  ];

  static const String TEXT = 'TEXT';
  static const String INTEGER = 'INTEGER';
  static const String BLOB = 'BLOB';
  static const String REAL = 'REAL';
  static const String NUMERIC = 'NUMERIC';
  static const String PRIMARY_KEY = ' PRIMARY KEY';
}
