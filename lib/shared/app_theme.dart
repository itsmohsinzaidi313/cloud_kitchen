import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppTheme {
  static final Color appBarColor = Colors.red;
  static final Color listTextColor = Colors.amber[400];
  static final Color appThemeColor = Colors.blue;

  static Widget appBarNormal(
      {BuildContext context,
      String appBarTitle,
      Color appBarBgColor,
      double appBarElevation}) {
    final appBar = AppBar(
      backgroundColor: appBarBgColor,
      elevation: appBarElevation == null ? 0.0 : appBarElevation,
      title: Text(appBarTitle),
      centerTitle: true,
    );
    return appBar;
  }

  static Widget appBarWithBadge(
      {BuildContext context,
      String appBarTitle,
      String badgeText,
      Color appBarBgColor,
      double appBarElevation,
      Function appBarOnTap}) {
    final appBar = AppBar(
      backgroundColor: appBarBgColor,
      elevation: appBarElevation == null ? 0.0 : appBarElevation,
      title: Text(appBarTitle),
      centerTitle: true,
      actions: <Widget>[
        InkWell(
          onTap: appBarOnTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Badge(
              child: Icon(Icons.shopping_cart, color: Colors.white, size: 40),
              badgeContent: Text(
                badgeText,
                style: TextStyle(color: Colors.white),
              ),
              badgeColor: Colors.red,
              toAnimate: true,
              animationType: BadgeAnimationType.fade,
            ),
          ),
        ),
      ],
    );
    return appBar;
  }

  static Widget textWidget(
      {String tText,
      double tFontSize,
      String tFontFamily,
      FontWeight tFontWeight,
      double tLetterSpacing,
      Color tTextColor}) {
    final myText = Text(
      tText,
      style: TextStyle(
        fontSize: tFontSize,
        fontFamily: tFontFamily,
        fontWeight: tFontWeight,
        letterSpacing: tLetterSpacing,
        color: tTextColor,
      ),
    );
    return myText;
  }

  static ProgressDialog showProgressDialog(BuildContext context,
      {String text = '', bool isDismissible = true}) {
    final spinKit = new SpinKitFadingCube(
      itemBuilder: (context, index) => DecoratedBox(
        decoration: BoxDecoration(color: appThemeColor),
      ),
    );
    ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        customBody: Container(
          color: Colors.transparent,
          height: 250,
          width: 100,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                spinKit,
                SizedBox(
                  height: 30,
                ),
                Text('Loading...')
              ]),
        ));
    return progressDialog;
  }

  static timerWithNavigation(BuildContext context, int seconds, Widget widget){
    Timer(
        Duration(seconds: seconds),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => widget)));
  }

  static circularProgressIndicator(Color color){
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.amberAccent,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

}
