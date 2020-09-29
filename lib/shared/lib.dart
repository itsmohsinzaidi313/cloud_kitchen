import 'dart:async';
import 'dart:convert';
import 'package:food_app/database/tables.dart';
import 'package:food_app/models/generic_models/install_api.dart';
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
      Response response = await get(url);
      _log.v('ENTRY fetchData');
      _log.v('SERVER RESPONSE: ${response.statusCode}');
      Map<String, dynamic> data;
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
      }
      return data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<bool> install() async {
    ApiInstall apiInstall = new ApiInstall(data: await fetchData());
    return apiInstall.init();
  }

  static Future<bool> insertIntoDatabase(
      Database db, String table, Map<String, dynamic> values) async {
    try {
      bool value = await db.transaction((txn) => txn.insert(table, values)) > 0
          ? true
          : false;
      return value;
    } catch (e) {
      Config.log.e('Error on Lib insertIntoDatabase', [e]);
      return false;
    }
  }
}
