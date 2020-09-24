import 'package:flutter/material.dart';
import 'package:food_app/pages/login_screen.dart';
import 'package:food_app/pages/splash_screen.dart';
import 'package:food_app/pos/new_sale.dart';
import 'package:food_app/shared/config.dart';

void main() => runApp(
      MaterialApp(
        title: Config.appTitle,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        routes: {
          '/splashScreen': (context) => SplashScreen(),
          '/loginScreen': (context) => UserLogin(),
          // '/shiftScreen': (context) => ShiftScreen(),
          // '/dashboardScreen': (context) => Dashboard(),
          // '/salesScreen': (context) => NewSale(),
        },
      ),
    );
