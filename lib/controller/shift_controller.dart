import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/models/objects/shift.dart';
import 'package:food_app/models/view_models/shift_model.dart';
import 'package:food_app/pages/shift_screen.dart';
import 'package:food_app/shared/config.dart';

class ShiftController {
  ShiftModel model;
  ShiftController(int layoutType) {
    model = new ShiftModel();
    model.layoutType = layoutType;

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
  void launchShiftClosing(BuildContext context) {
    this.model.layoutType = 2;
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => new ShiftScreen(this.model)));
  }

  void launch(BuildContext context) async {
    List<Map<String, dynamic>> data = await Config.database.rawQuery(
        "select count(${Columns.shiftData[0]}) as count from ${Tables.shiftData} where ${Columns.shiftData[9]} = '1' order by id desc");
    int count = data[0]['count'];
    if (count > 0) {
      List<Map<String, dynamic>> map = await Config.database.query(
          Tables.shiftData,
          where: '${Columns.shiftData[9]} = ?',
          whereArgs: ['1']);
      Shift shift = new Shift.fromJson(map[0]);
      Config.currentShift = shift;
      DashboardController(context).pushAndRemoveUntil(context);
    } else {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new ShiftScreen(this.model)));
    }
  }

  Future<void> onAmountEntered(BuildContext context) async =>
      DashboardController(context).launch();
}
