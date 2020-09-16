import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Config{

  static const String APP_TITLE = 'Cloud Kitchen';
  static const int DATABASE_VERSION = 1;
  static const String DATABASE_NAME = 'CloudKitchen.db';

  static const String SERVER_IP = '72.52.142.19';
  static const String CLOUD_KITCHEN_API = 'http://$SERVER_IP/cloud-kitchen/api/install?auth=622780154&sale_limit=20&expense_limit=20';

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
          methodCount: 0));
}