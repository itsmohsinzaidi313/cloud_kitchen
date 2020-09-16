import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final Color appBarColor = Colors.red;
  static final Color lisTextColor = Colors.amber[400];

  static Widget appBarNormal({BuildContext context, String appBarTitle,
    Color appBarBgColor, double appBarElevation}) {

    final appBar = AppBar(
      backgroundColor: appBarBgColor,
      elevation: appBarElevation == null ? 0.0 : appBarElevation,
      title: Text(appBarTitle),
      centerTitle: true,
    );
    return appBar;
  }

  static Widget appBarWithBadge({BuildContext context, String appBarTitle, String badgeText,
      Color appBarBgColor, double appBarElevation, Function appBarOnTap}) {

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

  static Widget textWidget({String tText, double tFontSize, String tFontFamily,
    FontWeight tFontWeight, double tLetterSpacing, Color tTextColor})
  {
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

}
