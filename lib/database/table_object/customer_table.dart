import 'package:food_app/database/sql_structure.dart';

class CustomerTable{

  static const String localId = 'local_id';
  static const String serverId = 'id';
  static const String name = 'name';
  static const String phone = 'phone';
  static const String email = 'email';
  static const String address = 'address';
  static const String gstNumber = 'gst_number';
  static const String areaId = 'area_id';
  static const String userId = 'user_id';
  static const String companyId = 'company_id';
  static const String delStatus = 'del_status';
  static const String dateOfBirth = 'date_of_birth';
  static const String dateOfAnniversary = 'date_of_anniversary';

  static const List<String> columnsName = [
    localId,
    serverId,
    name,
    phone,
    email,
    address,
    gstNumber,
    areaId,
    userId,
    companyId,
    delStatus,
    dateOfBirth,
    dateOfAnniversary
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
    SqlStructure.text
  ];
}