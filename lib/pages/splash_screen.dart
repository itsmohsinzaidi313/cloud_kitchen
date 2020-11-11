import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/controller/login_controller.dart';
import 'package:food_app/database/project_database.dart';
import 'package:food_app/database/table_object/user_table.dart';
import 'package:food_app/models/objects/setting_detail.dart';
import 'package:food_app/models/objects/shift.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/shared/config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    ProjectDatabase().database.then((db) => Config.database = db);
    Timer(
          Duration(seconds: 3),
          () => _whichScreenToGo());
  }

  void _whichScreenToGo() async{
      SettingDetail settingDetail = await SettingDetail()
          .getUserSettingByDesc();
      if (settingDetail != null) {
        Config.settingDetail = settingDetail;
        User user = await User().getSpecificUser(settingDetail.userId);
        if(user != null){
          Config.currentUser = user;
          Shift shift = await Shift().getSpecificShift(settingDetail.shiftId);
          if(shift != null){
            Config.currentShift = shift;
            DashboardController(context).launchAndReplacement();
          }
          else{
            print('Shift Found NaN');
            LoginController().launch(context);
          }
        } else{
          print('User Found NaN');
          LoginController().launch(context);
        }
      } else{
        print('Setting Found NaN');
        LoginController().launch(context);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[600],
      key: globalScaffoldKey,
      body: Container(
        height: Config.getDeviceHeight(context),
        width: Config.getDeviceWidth(context),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                height: Config.getDeviceHeight(context) * 0.3,
                width: Config.getDeviceWidth(context) * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/splash_pic.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                Config.appTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.red,
                  letterSpacing: 3.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
