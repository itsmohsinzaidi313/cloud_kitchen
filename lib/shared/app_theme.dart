import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppTheme {
  static final Color appBarColor = Colors.red;
  static final Color dialogButtonColor = Colors.amberAccent;
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

  static Future<Widget> showAlertDialog(BuildContext context,
      {String title,
      FontWeight fontWeight,
      double fontSize,
      bool barrier,
      Widget content,
      List<FlatButton> buttons}) =>
      showDialog(
        context: context,
        barrierDismissible: barrier,
        builder: (BuildContext context) => AlertDialog(
              title: Container(
                  child: Text(title,
                      style: textStyle(
                          fontWeight: fontWeight, fontSize: fontSize))),
              content: content,
              actions: buttons,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ));


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

  static circularProgressIndicator(Color color) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.amberAccent,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

  static void showAlertDialogYN(BuildContext context,
      {String title, String message, Function onYes, Function onNo}) {
    showDialog(
        context: context,
        builder: (value) => AlertDialog(
            title: text(text: title, fontWeight: FontWeight.bold, fontSize: 20),
            content: text(text: message),
            actions: [
              FlatButton(
                  child: text(text: 'Yes', color: Colors.blue),
                  onPressed: onYes),
              FlatButton(
                  child: text(text: 'No', color: Colors.blue), onPressed: onNo)
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8))));
  }

  static Text text(
      {String text,
      double fontSize = 15,
      FontWeight fontWeight = FontWeight.normal,
      Color color = Colors.black}) {
    return Text(
      text,
      style:
          textStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }

  static TextStyle textStyle(
      {double fontSize = 18,
      FontWeight fontWeight = FontWeight.normal,
      Color color = Colors.black}) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }
}
