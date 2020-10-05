import 'package:food_app/database/sql_structure.dart';

class UserTable{

  static const String localId = 'local_id';
  static const String serverId = 'id';
  static const String fullName = 'full_name';
  static const String phone = 'phone';
  static const String emailAddress = 'email_address';
  static const String password = 'password';
  static const String designation = 'designation';
  static const String willLogin = 'will_login';
  static const String role = 'role';
  static const String outletId = 'outlet_id';
  static const String companyId = 'company_id';
  static const String accountCreationDate = 'account_creation_date';
  static const String language = 'language';
  static const String lastLogin = 'last_login';
  static const String activeStatus = 'active_status';
  static const String delStatus = 'del_status';

  static const List<String> columnsName = [
    localId,
    serverId,
    fullName,
    phone,
    emailAddress,
    password,
    designation,
    willLogin,
    role,
    outletId,
    companyId,
    accountCreationDate,
    language,
    lastLogin,
    activeStatus,
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
    SqlStructure.text,
    SqlStructure.text,
    SqlStructure.text
  ];
}