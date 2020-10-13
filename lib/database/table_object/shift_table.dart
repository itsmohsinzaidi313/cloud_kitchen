import 'package:food_app/database/sql_structure.dart';

class ShiftTable {
    static const String tableName = 'shift_data';

    static const String localId = 'local_id';
    static const String shift = 'shift';
    static const String openingBalance = 'opening_balance';
    static const String closingBalance = 'closing_balance';
    static const String openingBalanceDateTime = 'opening_balance_date_time';
    static const String closingBalanceDateTime = 'closing_balance_date_time';
    static const String salePaidAmount = 'sale_paid_amount';
    static const String customerDueReceive = 'customer_due_receive';
    static const String paymentMethodsSale = 'payment_methods_sale';
    static const String registerStatus = 'register_status';
    static const String userId = 'user_id';
    static const String outletId = 'outlet_id';
    static const String companyId = 'company_id';
    static const String registerNo = 'register_no';
    static const String deviceKey = 'device_key';
    static const String serverId = 'id';
    static const String isUpload = 'is_upload';

  static const List<String> columnsName = [
    localId,
    shift,
    openingBalance,
    closingBalance,
    openingBalanceDateTime,
    closingBalanceDateTime,
    salePaidAmount,
    customerDueReceive,
    paymentMethodsSale,
    registerStatus,
    userId,
    outletId,
    companyId,
    registerNo,
    deviceKey,
    serverId,
    isUpload
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
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text
  ];
}
