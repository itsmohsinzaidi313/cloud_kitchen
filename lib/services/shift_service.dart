import 'dart:convert';
import 'dart:developer';
import 'package:food_app/database/tables.dart';
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

  Database _db;
  @override
  Future<bool> perform() async {
    List<Map<String, dynamic>> shiftRows = await _db.query(Tables.shiftData,
        where: 'id = null', orderBy: 'local_id asc');
    for (int i = 0; i < shiftRows.length; i++) {
      Shift shift = new Shift.fromJson(shiftRows[i]);
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
      //OPENING SHIFT
      Response response =
          await post(Config.openRegisterApi, body: json).timeout(
        Duration(seconds: 5),
        onTimeout: () => null,
      );
      log(response.body, name: 'Close Register Response');
      if (response != null) {
        Map<String, dynamic> decodedJson = jsonDecode(response.body);
        bool status = decodedJson['status'];
        if (status) {
          //UPDATE ID COLUMN
          int rowsUpdated =
              await _db.update(Tables.shiftData, {'id': decodedJson['id']});
          if (rowsUpdated > 0) {
            Response response2 = await post(Config.closeRegisterApi, body: json)
                .timeout(Duration(seconds: 5), onTimeout: () => null);
            if (response2 != null) {
              Map<String, dynamic> decodedJson2 = jsonDecode(response2.body);
              bool status2 = decodedJson2['status'];
              if (status2) {
                _db.update(Tables.shiftData, {'is_upload': 1});
              }
            }
          }
        }
      }
    }
    return true;
  }
}
