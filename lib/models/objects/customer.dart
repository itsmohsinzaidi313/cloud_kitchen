import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';

class Customer {
  final String serverId;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String gstNumber;
  final String areaId;
  final String userId;
  final String companyId;
  final String delStatus;
  final String dateOfBirth;
  final String dateOfAnniversary;

  Customer.fromJson(Map<String, dynamic> json)
      : serverId = json['id'],
        name = json['name'],
        phone = json['phone'],
        email = json['email'],
        address = json['address'],
        gstNumber = json['gst_number'],
        areaId = json['area_id'],
        userId = json['user_id'],
        companyId = json['company_id'],
        delStatus = json['del_status'],
        dateOfBirth = json['date_of_birth'],
        dateOfAnniversary = json['date_of_anniversary'];

  Customer(
      {this.serverId,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.gstNumber,
      this.areaId,
      this.userId,
      this.companyId,
      this.delStatus,
      this.dateOfBirth,
      this.dateOfAnniversary});

  @override
  String toString() {
    return 'Customers{id: $serverId, name: $name, phone: $phone, email: $email, address: $address, gstNumber: $gstNumber, areaId: $areaId, userId: $userId, companyId: $companyId, delStatus: $delStatus, dateOfBirth: $dateOfBirth, dateOfAnniversary: $dateOfAnniversary}';
  }

  List<String> getList() {
    return [
      this.serverId,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.gstNumber,
      this.areaId,
      this.userId,
      this.companyId,
      this.delStatus,
      this.dateOfBirth,
      this.dateOfAnniversary
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getValues().length; i++) {
      map[Columns.customers[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, Tables.customers, getValues());
}
