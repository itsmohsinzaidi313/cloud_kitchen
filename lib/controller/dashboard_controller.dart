import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/generic_models/dashboard_item.dart';
import 'package:food_app/models/view_models/dashboard_model.dart';
import 'package:food_app/pages/dashboard_screen.dart';
import 'package:food_app/services/customer_service.dart';
import 'package:food_app/services/order_service.dart';
import 'package:food_app/services/shift_service.dart';

class DashboardController {
  DashBoardModel model;
  DashboardController(BuildContext context) {
    model = new DashBoardModel();
    model.context = context;
    model.listDashboardButtons = [
      DashboardItem(
          img: 'assets/sales.png',
          name: 'New Orders',
          subtitle: 'Your new sales'),
      DashboardItem(
          img: 'assets/order.png',
          name: 'Pending Orders',
          subtitle: 'Your pending orders'),
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
          img: 'assets/database-storage.png',
          name: 'Database',
          subtitle: 'Provides raw database access')
    ];
  }

  void launch() => Navigator.of(model.context)
      .push(new MaterialPageRoute(builder: (context) => new Dashboard(model)));

  void launchAndReplacement() => Navigator.of(model.context).pushReplacement(
      new MaterialPageRoute(builder: (context) => new Dashboard(model)));

  void pushAndRemoveUntil(BuildContext context) {
    OrderService.orderService.start();
    ShiftService.shiftService.start();
    CustomerService.customerService.start();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Dashboard(model)),
        (route) => false);
  }
}
