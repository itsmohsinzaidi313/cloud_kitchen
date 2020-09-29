import 'package:flutter/material.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/controller/login_controller.dart';
import 'package:food_app/database/project_database.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/shared/lib.dart';
import 'package:logger/logger.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  Logger _log = Config.log;
  ProgressDialog _progressDialog;

  void init() {
    _progressDialog = AppTheme.showProgressDialog(context);
    ProjectDatabase().database.then((db) {
      Config.database = db;
      Lib.install().then((value) async {
        if (value) {
          bool x = await DataLists.importToDatabase(db);
          if (x)
            _log.v('Data imported into database successfully');
          else
            _log.v('Data import into database unsuccessful');
          // if (x) {
          //   bool y = await DataLists.importToMemory(db);
          // }
        }
      });
    }).whenComplete(() {
      // Lib.timerWithNavigation(context, Config.screenStartTime, UserLogin());
      LoginController().launch(context);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[600],
      key: globalScaffoldKey,
      body: Center(
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
    );
  }
}
