import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/table_object/customer_table.dart';
import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/models/generic_models/install_api.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/device.dart';
import 'package:food_app/models/objects/shift.dart';
import 'package:food_app/shared/config.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Lib {
  static Logger _log = Config.log;

  static timerWithNavigation(
          BuildContext context, int seconds, Widget widget) =>
      Timer(
          Duration(seconds: seconds),
          () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => widget)));

  static Future<Map<String, dynamic>> fetchData() async {
    try {
      String url = Config.installApi;
      Response response =
          await get(url).timeout(Duration(seconds: 15), onTimeout: () => null);
      _log.v('ENTRY fetchData');
      Map<String, dynamic> data;
      if (response != null) {
        _log.v('SERVER RESPONSE: ${response.statusCode}');
        if (response.statusCode == 200) {
          data = jsonDecode(response.body);
        } else {
          _log.w('SERVER RESPONSE: ${response.body}');  
        }
      }
      return data;
    } catch (e) {
      _log.e('ERROR ON FetchData', [e]);
      return null;
    }
  }

  static Future<bool> install() async {
    ApiInstall apiInstall = new ApiInstall(data: await fetchData());
    bool value = await apiInstall.init();
    return value;
  }

  static Future<bool> insertIntoDatabase(
      Database db, String table, Map<String, dynamic> values) async {
    try {
      bool value = await db.insert(table, values) > 0 ? true : false;
      return value;
    } catch (e) {
      Config.log.e('Error on Lib insertIntoDatabase', [e]);
      return false;
    }
  }

  static Future<bool> uploadCustomer(Customer customer) async {
    Map<String, dynamic> data = new Map<String, dynamic>();
    List<Map<String, dynamic>> map = [];

    map.add({
      'remote_id': customer.remoteId,
      'name': customer.name,
      'phone': customer.phone,
      'address': customer.address,
      'device_key': Config.currentDevice.deviceKey,
      'user_id': customer.userId,
      'company_id': Config.currentDevice.companyId,
      'outlet_id': Config.currentDevice.outletId
    });

    data['user_id'] = Config.currentUser.serverId;
    data['json'] = jsonEncode(map);
    print(data);
    print(Config.customerUploadApi);
    Response response = await post(Config.customerUploadApi, body: data)
        .timeout(Duration(seconds: 5), onTimeout: () => null);
    if (response != null) {
      Config.log.i(response.body);
      Map<String, dynamic> result = jsonDecode(response.body);
      List<dynamic> x = result['customers_synced'];
      print('ID: ${x[0]['id']}\n SERVER ID: ${x[0]['remote_id']}');
      String id = x[0]['id'];
      String remoteId = x[0]['remote_id'];
      int y = await Config.database.update(CustomerTable.tableName, {'${CustomerTable.serverId}': id, '${CustomerTable.isUpload}': '1'},
          where: '${CustomerTable.localId} = ?', whereArgs: [remoteId]);
      print('Customer server id update value : $y');
      return true;
    } else
      return false;
  }

  static Future<bool> openRegister(Shift shift) async {
    try {
      Map<String, dynamic> json = {
        'user_id': shift.userId,
        'json': jsonEncode({
          'device_key': shift.deviceKey,
          'remote_id': shift.remoteId,
          'register_no': shift.registerNo,
          'opening_balance': shift.openingBalance,
          'opening_balance_date_time': shift.openingBalanceDateTime
        })
      };
      Response response =
          await post(Config.openRegisterApi, body: json).timeout(
        Duration(seconds: 10),
        onTimeout: () => null,
      );
      log('Status Code: ${response.statusCode}\n${response.body}',
          name: 'Open Register Response');
      if (response != null) {
        Map<String, dynamic> result = jsonDecode(response.body);
        bool status = result['status'];
        if (status) {
          Config.currentShift.registerNo =
              codeGenerator('REG', int.parse(shift.remoteId));
          Config.currentShift.id = result['id'];
          int id =
              await Shift().insertSpecificIntoDatabase(Config.database, shift);
          //
          if (id > 0)
            return true;
          else
            return false;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> closeRegister(Shift shift) async {
    try {
      Map<String, dynamic> json = {
        'user_id': shift.userId,
        'json': jsonEncode({
          'device_key': shift.deviceKey,
          'remote_id': shift.remoteId,
          'closing_balance': shift.closingBalance,
          'closing_balance_date_time': shift.closingBalanceDateTime
        })
      };
      Response response =
          await post(Config.closeRegisterApi, body: json).timeout(
        Duration(seconds: 5),
        onTimeout: () => null,
      );
      log(response.body, name: 'Close Register Response');
      if (response != null) {
        Map<String, dynamic> result = jsonDecode(response.body);
        bool status = result['status'];
        if (status) {
          int rowsUpdated = await Config.database.update(
              ShiftTable.tableName,
              {
                ShiftTable.closingBalance: shift.closingBalance,
                ShiftTable.openingBalanceDateTime: shift.closingBalanceDateTime,
                ShiftTable.registerStatus: '2'
              },
              where: '${ShiftTable.localId} = ?',
              whereArgs: [shift.id]);
          if (rowsUpdated > 0)
            return true;
          else
            return false;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static String codeGenerator(String prefix, int id) {
    String code = '$prefix/';
    // String deviceId = Config().currentShift.deviceKey;
    String deviceId = '1';
    if (int.parse(deviceId) < 10) {
      deviceId = '0$deviceId/';
    }
    String digits = '';
    if (id < 10)
      digits = '000$id';
    else if (id < 100)
      digits = '00$id';
    else if (id < 1000)
      digits = '0$id';
    else
      digits = '$id';
    return code + deviceId + digits;
  }

  void shiftMech(Database db) async {}
}
