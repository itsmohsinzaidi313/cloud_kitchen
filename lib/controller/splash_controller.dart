import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/database/DAL.dart';
import 'package:food_app/database/project_database.dart';
import 'package:food_app/pages/splash_screen.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/import_online_data.dart';
import 'package:food_app/shared/lib.dart';

class SplashController {
  SplashController() {
    ProjectDatabase()
        .database
        .then((db) => Config.database = db)
        .whenComplete(() {
      Lib.install().then((value) {
        ProjectDatabase().database.then((db) => ImportOnlineData(db));
        DAL.dal.importFromDatabase(ProjectDatabase().database);
      });
      // Lib.timerWithNavigation(context, Config.screenStartTime, UserLogin());
    });
  }
  void launch(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/splashScreen');
  }

  Widget launchAsWidget() => SplashScreen();
}
