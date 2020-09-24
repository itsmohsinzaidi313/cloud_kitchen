import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/models/view_models/shift_model.dart';
import 'package:food_app/pages/shift_screen.dart';

class ShiftController {
  ShiftModel model;
  ShiftController() {
    model = new ShiftModel();
    this.model.shiftList = [
      DropdownMenuItem(
        value: 'Morning',
        child: Text('Morning'),
      ),
      DropdownMenuItem(
        value: 'Evening',
        child: Text('Evening'),
      ),
      DropdownMenuItem(
        value: 'Night',
        child: Text('Night'),
      )
    ];
  }

  void launch(BuildContext context) => Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) => new ShiftScreen(this.model)));

  Future<void> onAmountEntered(BuildContext context) async =>
      DashboardController().launch(context);
}
