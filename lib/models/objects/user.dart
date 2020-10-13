import 'package:food_app/database/columns.dart';
import 'package:food_app/database/table_object/user_table.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class User {
  final String serverId;
  final String fullName;
  final String phone;
  final String emailAddress;
  final String password;
  final String designation;
  final String willLogin;
  final String role;
  final String outletId;
  final String companyId;
  final String accountCreationDate;
  final String language;
  final String lastLogin;
  final String activeStatus;
  final String delStatus;

  User(
      {this.serverId,
      this.fullName,
      this.phone,
      this.emailAddress,
      this.password,
      this.designation,
      this.willLogin,
      this.role,
      this.outletId,
      this.companyId,
      this.accountCreationDate,
      this.language,
      this.lastLogin,
      this.activeStatus,
      this.delStatus});

  User.fromJson(Map<String, dynamic> json)
      : serverId = json['id'],
        fullName = json['full_name'],
        phone = json['phone'],
        emailAddress = json['email_address'],
        password = json['password'],
        designation = json['designation'],
        willLogin = json['will_login'],
        role = json['role'],
        outletId = json['outlet_id'],
        companyId = json['company_id'],
        accountCreationDate = json['account_creation_date'],
        language = json['language'],
        lastLogin = json['last_login'],
        activeStatus = json['active_status'],
        delStatus = json['del_status'];

  @override
  String toString() {
    return 'Users{id: $serverId, fullName: $fullName, phone: $phone, emailAddress: $emailAddress, password: $password, designation: $designation, willLogin: $willLogin, role: $role, outletId: $outletId, companyId: $companyId, accountCreationDate: $accountCreationDate, language: $language, lastLogin: $lastLogin, activeStatus: $activeStatus, delStatus: $delStatus}';
  }

  List<String> getList() {
    return [
      this.serverId,
      this.fullName,
      this.phone,
      this.emailAddress,
      this.password,
      this.designation,
      this.willLogin,
      this.role,
      this.outletId,
      this.companyId,
      this.accountCreationDate,
      this.language,
      this.lastLogin,
      this.activeStatus,
      this.delStatus
    ];
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      map[UserTable.columnsName[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, UserTable.tableName, getValues());
}
