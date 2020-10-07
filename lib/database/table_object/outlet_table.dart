import 'package:food_app/database/sql_structure.dart';

class OutletTable{

  static const String tableName = 'outlet'; //11

  static const String localId = 'local_id';
  static const String serverId = 'id';
  static const String outletName = 'outlet_name';
  static const String outletCode = 'outlet_code';
  static const String address = 'address';
  static const String phone = 'phone';
  static const String invoicePrint = 'invoice_print';
  static const String startingDate = 'starting_date';
  static const String invoiceFooter = 'invoice_footer';
  static const String collectTax = 'collect_tax';
  static const String preOrPostOrder = 'pre_or_post_payment';
  static const String userId = 'user_id';
  static const String companyId = 'company_id';
  static const String delStatus = 'del_status';

  static const List<String> columnsName = [
    localId,
    serverId,
    outletName,
    outletCode,
    address,
    phone,
    invoicePrint,
    startingDate,
    invoiceFooter,
    collectTax,
    preOrPostOrder,
    userId,
    companyId,
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
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text
  ];
}