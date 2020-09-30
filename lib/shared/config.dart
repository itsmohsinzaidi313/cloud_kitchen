import 'package:flutter/material.dart';
import 'package:food_app/models/objects/shift.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class Config {
  static const String appTitle = 'Cloud Kitchen';
  static const DATABASE databaseVersion = DATABASE.STABLE;
  static const String databaseName = 'CloudKitchen.db';

  static const String serverIP = '72.52.142.19';
  static const String authToken = '1626065997';
  static const String installApi =
      'http://$serverIP/cloud-kitchen/api/install?auth=$authToken&sale_limit=20&expense_limit=20';
  static const String addUpdateOrderApi =
      'http://$serverIP/cloud-kitchen/api/order?auth=$authToken';

  static const int screenStartTime = 3;

  static User _currentUser;
  set currentUser(user) => _currentUser = user;
  User get currentUser => _currentUser;

  static Shift _currentShift;
  set currentShift(shift) => _currentShift = shift;
  Shift get currentShift => _currentShift;

  static double getDeviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getDeviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static final Logger log = new Logger(
    printer: PrettyPrinter(
        colors: true,
        errorMethodCount: 1,
        printEmojis: true,
        printTime: false,
        lineLength: 80,
        methodCount: 0),
  );

  static Database _database;
  static set database(Database database) => _database = database;
  static Database get database => _database;

  static String getCurrentDateTime() {
    DateTime dateTime = DateTime.now();
    DateFormat formatDateTime = DateFormat.yMd().add_jm();
    String currentDateTime = formatDateTime.format(dateTime);
    return currentDateTime;
  }
}

enum DATABASE { STABLE, CREATE, UPGRADE, DOWNGRADE }
