import 'package:flutter/material.dart';
import 'package:food_app/models/objects/device.dart';
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
  static final String authToken = '1626065997';
  static final String installApi =
      'http://$serverIP/cloud-kitchen/api/install?auth=$authToken&sale_limit=20&expense_limit=20';
  static final String addUpdateOrderApi =
      'http://$serverIP/cloud-kitchen/api/order?auth=$authToken';
  static final customerUploadApi =
      'http://$serverIP/cloud-kitchen/api/customer?auth=$authToken';
  static final String openRegisterApi =
      'http://$serverIP/cloud-kitchen/api/openRegister?auth=$authToken';
  static final String closeRegisterApi =
      'http://$serverIP/cloud-kitchen/api/closeRegister?auth=$authToken';
  static const int screenStartTime = 3;

  static User _currentUser;
  static set currentUser(user) => _currentUser = user;
  static User get currentUser => _currentUser;

  static Shift _currentShift;
  static set currentShift(shift) => _currentShift = shift;
  static Shift get currentShift => _currentShift;

  static Device _currentDevice;
  static set currentDevice(device) => _currentDevice = device;
  static Device get currentDevice => _currentDevice;

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

  static String getCurrentDateTimeDBFormat() {
    DateTime dateTime = DateTime.now();
    DateFormat formatDateTime = DateFormat("yyyy-MM-dd HH:mm:ss");
    String currentDateTime = formatDateTime.format(dateTime);
    return currentDateTime;
  }

  static String getCurrentDate() {
    DateTime dateTime = DateTime.now();
    DateFormat formatDateTime = DateFormat("yyyy-MM-dd");
    String currentDate = formatDateTime.format(dateTime);
    return currentDate;
  }

  static String getCurrentTime24Format() {
    DateTime dateTime = DateTime.now();
    DateFormat formatDateTime = DateFormat("HH:mm:ss");
    String currentTime = formatDateTime.format(dateTime);
    return currentTime;
  }
}

enum DATABASE { STABLE, CREATE, UPGRADE, DOWNGRADE }
