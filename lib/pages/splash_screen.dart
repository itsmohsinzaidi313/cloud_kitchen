import 'package:flutter/material.dart';
import 'package:food_app/pages/login_screen.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
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
  String _msg = 'Downloading...';
  bool _isProgress = true;
  bool _isUpdate = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppTheme.timerWithNavigation(context, Config.SCREEN_START_TIME, UserLogin());
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);

    Future _showProgressDialogue() async {
      _progressDialog.style(
        message: _msg,
        progressTextStyle: TextStyle(
          fontSize: 3,
        ),
        borderRadius: 5.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
          padding: EdgeInsets.all(10.0),
          child: CircularProgressIndicator(
            strokeWidth: 5,
            backgroundColor: Colors.yellow[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
        ),
        elevation: 10.0,
      );
      await _progressDialog.show();
    }

    // Future _downloadingServices() async {
    //   await _showProgressDialogue();

    //   _progressDialog.update(message: "Adding Company Table");

    //   _progressDialog.update(message: "Added Company Table");

    //   _progressDialog.update(message: "Adding Outlet Table");

    //   _progressDialog.update(message: "Added Outlet Table");

    //   _progressDialog.update(message: "Adding Users Table");

    //   _progressDialog.update(message: "Added Users Table");

    //   _progressDialog.update(message: "Adding Tables Table");

    //   _progressDialog.update(message: "Added Tables Table");

    //   _progressDialog.update(message: "Adding Categories Table");

    //   _progressDialog.update(message: "Added Categories Table");

    //   _progressDialog.update(message: "Adding Modifiers Table");

    //   _progressDialog.update(message: "Added Modifiers Table");

    //   _progressDialog.update(message: "Adding ItemMenus Table");

    //   _progressDialog.update(message: "Added ItemMenus Table");

    //   _progressDialog.update(message: "Adding ItemModifiers Table");

    //   _progressDialog.update(message: "Added ItemModifiers Table");

    //   _progressDialog.update(message: "Adding Customers Table");

    //   _progressDialog.update(message: "Added Customers Table");

    //   _hideProgressDialog();
    // }

    return Scaffold(
      backgroundColor: Colors.yellow[600],
      key: globalScaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              height:Config.getDeviceHeight(context) * 0.3,
              width: Config.getDeviceWidth(context) * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/splash_pic.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              Config.APP_TITLE,
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
