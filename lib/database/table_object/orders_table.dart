import 'package:food_app/database/sql_structure.dart';

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

  static const List<String> columnsName = [
    localId,
    persons,
    bookingTime,
    saleId,
    saleNo,
    outletId,
    tableId,
    delStatus
  ];

  static const List<String> columnsType = [
    SqlStructure.integer + SqlStructure.primaryKey,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text
  ];
}
