import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/models/objects/shift.dart';
import 'package:food_app/services/common.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class ShiftService extends ServiceCommon {
  static final ShiftService shiftService =
      ShiftService._instance(Config.database);

  ShiftService._instance(this._db) {
    initiate();
  }

  static const platform =
      const MethodChannel('com.devaj.cloudKitchen/shiftService');
  Database _db;

  @override
  Future<bool> perform() async {
    try {

      log('Responding', name: 'Shift Service : ${Config.getCurrentTime()}');
      Response _response;
      List<Map<String, dynamic>> shiftRows = await _db.query(
          ShiftTable.tableName,
          where: '${ShiftTable.isUpload} = ?',
          whereArgs: ['0'],
          orderBy: '${ShiftTable.localId} desc');

      for (int i = 0; i < shiftRows.length; i++) {
        Shift shift = new Shift.fromJson(shiftRows[i]);
        if(shift.registerStatus == '1'){
          Map<String, dynamic> json = {
            'user_id': shift.userId,
            'json': jsonEncode({
              'device_key': shift.deviceKey,
              'remote_id': shift.remoteId,
              'register_no': Lib.codeGenerator('REG', int.parse(shift.remoteId)),
              'opening_balance': shift.openingBalance,
              'opening_balance_date_time': shift.openingBalanceDateTime
            })
          };
          _response = await post(Config.openRegisterApi, body: json)
              .timeout(Duration(seconds: 5),
              onTimeout: () => null);
          log(_response.body, name: 'Open Register Response');
          if(_response != null){
            Map<String, dynamic> decodedJson = jsonDecode(_response.body);
            bool status = decodedJson['status'];
            if(status){
              int rowsUpdated = await _db.update(
                  ShiftTable.tableName,
                  {
                    '${ShiftTable.serverId}': decodedJson['id'],
                    '${ShiftTable.registerStatus}' : '1',
                    '${ShiftTable.isUpload}': '1'
                  },
                  where: '${ShiftTable.localId} = ?',
                  whereArgs: [shift.remoteId]);
              if(rowsUpdated > 0){
                log('Open Shift Upload To Server', name: 'SUCCESSFULLY!');
              }
            } else{
              // log(decodedJson['status'], name: decodedJson['message']);
              String message = decodedJson['message'];
              if (message.contains('register is already open') || message.contains('A register was already opened')) {
                await _db.update(ShiftTable.tableName, {ShiftTable.registerStatus: '1', ShiftTable.isUpload: '1'},
                    where: '${ShiftTable.localId} = ?', whereArgs: [shift.remoteId]) > 0 ? print('Open Register Updated..') :
                print('Open Register Does not Updated..');
              }
            }
          }
        }
        else if(shift.registerStatus == '2'){
          Map<String, dynamic> json = {
            'user_id': shift.userId,
            'json': jsonEncode({
              'device_key': shift.deviceKey,
              'remote_id': shift.remoteId,
              'closing_balance': shift.closingBalance,
              'closing_balance_date_time': shift.closingBalanceDateTime
            })
          };
          _response = await post(Config.closeRegisterApi, body: json)
              .timeout(Duration(seconds: 5),
              onTimeout: () => null);
          log(_response.body, name: 'Close Register Response');
          if(_response != null){
            Map<String, dynamic> decodedJson = jsonDecode(_response.body);
            bool status = decodedJson['status'];
            if(status){
              int rowsUpdated = await _db.update(
                  ShiftTable.tableName,
                  {
                    '${ShiftTable.serverId}': decodedJson['id'],
                    '${ShiftTable.registerStatus}' : '2',
                    '${ShiftTable.isUpload}': '2'
                  },
                  where: '${ShiftTable.localId} = ?',
                  whereArgs: [shift.remoteId]);
              if(rowsUpdated > 0){
                log('Close Shift Upload To Server', name: 'SUCCESSFULLY!');
              }
            } else{
              // log(decodedJson['status'], name: decodedJson['message']);
              String message = decodedJson['message'];
              if (message.contains('Register Closed Successfully')) {
                await _db.update(ShiftTable.tableName, {ShiftTable.registerStatus: '2', ShiftTable.isUpload: '2'},
                    where: '${ShiftTable.localId} = ?', whereArgs: [shift.remoteId]) > 0 ? print('Close Register Updated..') :
                print('Close Register Does not Updated..');
              }
            }
          }
        }
      //   //OPENING SHIFT
      //   Response response = await post(Config.openRegisterApi, body: json)
      //       .timeout(Duration(seconds: 5),
      //           onTimeout: () => null); // SEND TO SERVER
      //   log(response.body, name: 'Open Register Response');
      //   if (response != null) {
      //     Map<String, dynamic> decodedJson = jsonDecode(response.body);
      //     bool status = decodedJson['status'];
      //     if (status) {
      //       //UPDATING ID AND IS_UPLOAD
      //       int rowsUpdated = await _db.update(
      //           ShiftTable.tableName,
      //           {
      //             '${ShiftTable.serverId}': decodedJson['id'],
      //             // '${ShiftTable.registerStatus}' : '1',
      //             '${ShiftTable.isUpload}': '1'
      //           },
      //           where: '${ShiftTable.localId} = ?',
      //           whereArgs: [shift.remoteId]);
      //
      //       if (rowsUpdated > 0) {
      //         if (shift.closingBalance != null &&
      //             double.parse(shift.closingBalance) > 0) {
      //           // IF CLOSING AMOUNT IS ABOVE ZERO
      //           //SHIFT CLOSING
      //           Response response2 =
      //               await post(Config.closeRegisterApi, body: json).timeout(
      //                   Duration(seconds: 5),
      //                   onTimeout: () => null); // SEND TO SERVER
      //           log(response2.body, name: 'Close Register Response');
      //           if (response2 != null) {
      //             Map<String, dynamic> decodedJson2 =
      //                 jsonDecode(response2.body);
      //             bool status2 = decodedJson2['status'];
      //             if (status2) {
      //               await _db.update(
      //                   ShiftTable.tableName, {/*ShiftTable.registerStatus: '2',*/ShiftTable.isUpload: '2'},
      //                   where: '${ShiftTable.localId} = ?',
      //                   whereArgs: [shift.remoteId]);
      //             }
      //           }
      //         }
      //       }
      //     } else {
      //       String message = decodedJson['message'];
      //       if (message.contains('register is already open')) {
      //         _db.update(ShiftTable.tableName, {ShiftTable.registerStatus: '1', ShiftTable.isUpload: '1'});
      //       }
      //     }
      //   }
      }
      return true;
    } catch (e) {
      log('Error occurred on Shift Service',
          name: 'Shift Service', time: DateTime.now(), error: e);
      return true;
    }
  }

  void printy() async {
    try {
      String value = await platform.invokeMethod('Printy');
      log(value, name: 'Printy');
    } catch (e) {
      log(e, name: 'Printy Error');
    }
  }
}
