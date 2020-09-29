import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/generic_models/dashboard_item.dart';
import 'package:food_app/models/view_models/dashboard_model.dart';
import 'package:food_app/pages/dashboard_screen.dart';

class DashboardController {
  DashBoardModel model;
  DashboardController(BuildContext context) {
    model = new DashBoardModel();
    model.context = context;
    model.listDashboardButtons = [
      DashboardItem(
          img: 'assets/sales.png', name: 'Sales', subtitle: 'Your daily sales'),
      DashboardItem(
          img: 'assets/order.png', name: 'Orders', subtitle: 'Your new orders'),
      DashboardItem(
          img: 'assets/report.png',
          name: 'Reports',
          subtitle: 'Your daily reports'),
      DashboardItem(
          img: 'assets/setting.png',
          name: 'Setting',
          subtitle: 'Application setting'),
      DashboardItem(
          img: 'assets/register.png',
          name: 'Register',
          subtitle: 'Close your register'),
      DashboardItem(
          img: 'assets/logout.png', name: 'Logout', subtitle: 'You can rest'),
      DashboardItem(
          img: 'assets/register.png',
          name: 'Database',
          subtitle: 'Provides raw database access')
    ];
  }

  void launch() => Navigator.of(model.context).push(
      new MaterialPageRoute(builder: (context) => new Dashboard(model)));

  void launchAndReplacement() => Navigator.of(model.context).pushReplacement(
      new MaterialPageRoute(builder: (context) => new Dashboard(model)));

  void pushAndRemoveUntil(BuildContext context) =>  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (c) => Dashboard(model)),
          (route) => false);

}
