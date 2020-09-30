import 'package:flutter/material.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/controller/login_controller.dart';
import 'package:food_app/database/project_database.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/shared/lib.dart';
import 'package:logger/logger.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  Logger _log = Config.log;

  Future<void> init() async {
    ProjectDatabase().database.then((db) => Config.database = db);
    Lib.install().then((value) {
      if (value) {
        _log.v('Data loaded from online source.');
        DataLists.importToDatabase(Config.database).then((value) {
          if (value)
            _log.v('Online data loaded');
          else
            _log.v('Online data load failed');
        });
      } else {
        _log.v('Data loading from offline source.');
        DataLists.importToMemory(Config.database).then((value) {
          if (value)
            _log.v('Offline data loaded');
          else
            _log.v('Offline data load failed');
        });
      }
        // LoginController().launch(context);
        DashboardController(context).launch();
    });
  }

  @override
  void initState() {
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
