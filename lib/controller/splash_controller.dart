import 'package:flutter/material.dart';
import 'package:food_app/pages/splash_screen.dart';

class SplashController {
  BuildContext context;

  SplashController(BuildContext context) {
    this.context = context;


    // ProjectDatabase().database.then((db) => ImportOnlineData(db));
    // DAL.dal.importFromDatabase(ProjectDatabase().database);
  }

  // void launch() {
  //   Navigator.of(context).pushReplacement(
  //       new MaterialPageRoute(builder: (context) => new SplashScreen()));
  // }

  Widget launchAsWidget() {
    return SplashScreen();
  }

}
