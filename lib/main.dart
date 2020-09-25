import 'package:flutter/material.dart';
import 'package:food_app/controller/splash_controller.dart';
import 'package:food_app/shared/config.dart';

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
