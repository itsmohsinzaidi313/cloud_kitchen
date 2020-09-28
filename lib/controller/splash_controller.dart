import 'package:flutter/material.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/database/project_database.dart';
import 'package:food_app/pages/splash_screen.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/shared/lib.dart';

class SplashController {
  BuildContext context;
  SplashController(BuildContext context) {
    this.context = context;
    ProjectDatabase()
        .database
        .then((db) => Config.database = db)
        .whenComplete(() {
      Lib.install().then((value) {
        if (value) DataLists.importToDatabase(Config.database);
        DashboardController(context).launch();
      });
      // Lib.timerWithNavigation(context, Config.screenStartTime, UserLogin());
    });
  }
  void launch() {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new SplashScreen()));
  }

  Widget launchAsWidget() => SplashScreen();
}
