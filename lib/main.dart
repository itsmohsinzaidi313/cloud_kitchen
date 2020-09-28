import 'package:flutter/material.dart';
import 'package:food_app/shared/config.dart';
import 'controller/splash_controller.dart';

void main() => runApp(
      MaterialApp(
        title: Config.appTitle,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        routes: {
          '/splashScreen': (context) =>
              SplashController(context).launchAsWidget(),
        },
      ),
    );
