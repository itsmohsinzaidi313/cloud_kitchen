import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';
import '../../database/columns.dart';
import '../../database/tables.dart';

class Company {
  final String serverId;
  final String currency;
  final String timezone;
  final String dateFormat;
  final String outletId;
  final String name;
  final String email;
  final String phone1;
  final String phone2;
  final String address;
  final String status;
  final String dateAdded;
  final String expiryDate;
  final String token;

  Company(
      {this.serverId,
      this.currency,
      this.timezone,
      this.dateFormat,
      this.outletId,
      this.name,
      this.email,
      this.phone1,
      this.phone2,
      this.address,
      this.status,
      this.dateAdded,
      this.expiryDate,
      this.token});

  Company.fromJson(Map<String, dynamic> json)
      : serverId = json['id'],
        currency = json['currency'],
        timezone = json['timezone'],
        dateFormat = json['date_format'],
        outletId = json['outlet_id'],
        name = json['name'],
        email = json['email'],
        phone1 = json['phone_1'],
        phone2 = json['phone_2'],
        address = json['address'],
        status = json['status'],
        dateAdded = json['date_added'],
        expiryDate = json['expiry_date'],
        token = json['token'];

  @override
  String toString() {
    return 'Company{id: $serverId, currency: $currency, timezone: $timezone, dateFormat: $dateFormat, outletId: $outletId, name: $name, email: $email, phone1: $phone1, phone2: $phone2, address: $address, status: $status, dateAdded: $dateAdded, expiryDate: $expiryDate, token: $token}';
  }

  List<String> getList() {
    return [
      this.serverId,
      this.currency,
      this.timezone,
      this.dateFormat,
      this.outletId,
      this.name,
      this.email,
      this.phone1,
      this.phone2,
      this.address,
      this.status,
      this.dateAdded,
      this.expiryDate,
      this.token
    ];
  }

  Map<String, dynamic> getValues() {
    try {
      Map<String, dynamic> map = new Map<String, dynamic>();
      for (int i = 0; i < getList().length; i++) {
        map[Columns.company[i + 1]] = getList()[i];
      }
      return map;
    } catch (e) {
      Config.log.e('ERROR ON getValues', [e]);
      return null;
    }
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, Tables.company, getValues());
}
