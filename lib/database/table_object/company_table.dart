import 'package:food_app/database/sql_structure.dart';

class CompanyTable{

  static const String localId = 'local_id';
  static const String serverId = 'id';
  static const String currency = 'currency';
  static const String timezone = 'timezone';
  static const String dateFormat = 'date_format';
  static const String outletId = 'outlet_id';
  static const String name = 'name';
  static const String email = 'email';
  static const String phone1 = 'phone_1';
  static const String phone2 = 'phone_2';
  static const String address = 'address';
  static const String status = 'status';
  static const String dateAdded = 'date_added';
  static const String expiryDate = 'expiry_date';
  static const String token = 'token';

  static const List<String> columnsName = [
    localId,
    serverId,
    currency,
    timezone,
    dateFormat,
    outletId,
    name,
    email,
    phone1,
    phone2,
    address,
    status,
    dateAdded,
    expiryDate,
    token
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
    SqlStructure.text
  ];
}