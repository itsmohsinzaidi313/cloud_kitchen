import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/pages/settings_screen.dart';
import 'package:food_app/pages/splash_screen.dart';
import 'package:food_app/shared/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Screen orientation set to landscape
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(
      MaterialApp(
        title: Config.appTitle,
        // debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.red[400],
          primaryColor: Colors.redAccent,
          accentColor: Colors.yellow[700],

        ),
        routes: {
          '/': (context) => SettingsScreen(),
          '/splashScreen': (context) => SplashScreen(),
        },
      ),
    );
  });
}
