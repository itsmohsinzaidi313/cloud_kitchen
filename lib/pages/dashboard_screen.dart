import 'package:flutter/material.dart';
import 'package:food_app/controller/login_controller.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/controller/order_type_controller.dart';
import 'package:food_app/controller/report_controller.dart';
import 'package:food_app/controller/shift_controller.dart';
import 'package:food_app/models/view_models/dashboard_model.dart';
import 'package:food_app/models/generic_models/dashboard_item.dart';
import 'package:food_app/pages/settings_screen.dart';
import 'package:food_app/pages/sql_view_page.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/widgets/dashboard_card.dart';
import 'package:toast/toast.dart';

class Dashboard extends StatefulWidget {
  final DashBoardModel model;

  Dashboard(this.model);

  @override
  _DashboardState createState() => _DashboardState(this.model);
}

class _DashboardState extends State<Dashboard> {
  final DashBoardModel model;
  TextEditingController closingAmount = TextEditingController();
  bool checkField = false;
  String errorMessage = 'Required';
  _DashboardState(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(),
            ),
            Text('Shift#: ${Config.currentShift.registerNo}')
          ],
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 400) {
            return ListView.builder(
              itemCount: model.listDashboardButtons.length,
              shrinkWrap: true,
              itemBuilder: ((context, position) => Container(
                    padding: position == model.listDashboardButtons.length
                        ? const EdgeInsets.only(top: 16.0)
                        : const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: DashboardCard(
                      model.listDashboardButtons[position],
                      250.0,
                      250.0,
                      () {
                        onCardTap(model.listDashboardButtons[0]);
                      },
                    ),
                  )),
            );
          } else if (constraints.maxWidth < 700) {
            return GridView.builder(
              itemCount: model.listDashboardButtons.length,
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, position) {
                return DashboardCard(
                  model.listDashboardButtons[position],
                  220.0,
                  220.0,
                  () {
                    onCardTap(model.listDashboardButtons[0]);
                  },
                );
              },
            );
          } else {
            return GridView.builder(
              itemCount: model.listDashboardButtons.length,
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, position) {
                return DashboardCard(
                  model.listDashboardButtons[position],
                  250.0,
                  250.0,
                  () {
                    onCardTap(model.listDashboardButtons[position]);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void onCardTap(DashboardItem dashboardItem) {
    Toast.show(dashboardItem.name, context);
    if (dashboardItem.name == 'New Orders') {
      OrderTypeController().launch(context);
    } else if (dashboardItem.name == 'Pending Orders') {
      OrderController(1).launch(context);
    } else if (dashboardItem.name == 'Database') {
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => SqlView()));
    } else if(dashboardItem.name == 'Reports'){
      ReportController().launch(context);
    }
      else if (dashboardItem.name == 'Register') {
        AppTheme.showAlertDialogYN(context,
          title: 'Close Register',
          message: 'Are you sure?',
          onYes: () {
            ShiftController shiftController = ShiftController(0);
            shiftController.model.layoutType = 2;
            shiftController.launchShiftClosing(context);
          },
          onNo: () => Navigator.pop(context));
    } else if (dashboardItem.name == 'Logout') {
      AppTheme.showAlertDialogYN(context,
          title: 'Logout',
          message: 'Are you sure?',
          onYes: () {
            LoginController().pushAndRemoveUntil(context);
          },
          onNo: () => Navigator.pop(context));
    } else if (dashboardItem.name == 'Setting') {
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => SettingsScreen()));
    }
  }
}
