import 'package:flutter/material.dart';
import 'package:food_app/pages/settings_screen.dart';
import 'package:food_app/pages/splash_screen.dart';
import 'package:food_app/shared/config.dart';

void main() => runApp(
      MaterialApp(
        title: Config.appTitle,
        // debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        routes: {
          '/' : (context) => SettingsScreen(),
          '/splashScreen': (context) => SplashScreen(),
        },
      ),
    );
