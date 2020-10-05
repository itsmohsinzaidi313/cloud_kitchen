import 'package:flutter/material.dart';
import 'package:food_app/controller/login_controller.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/controller/shift_controller.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/models/view_models/dashboard_model.dart';
import 'package:food_app/models/generic_models/dashboard_item.dart';
import 'package:food_app/pages/order_type_screen.dart';
import 'package:food_app/pages/sql_view_page.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
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
        title: Text('My Dashboard'),
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
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => OrderTypeScreen()));
    } else if (dashboardItem.name == 'Pending Orders') {
      OrderController(1).launch(context);
    } else if (dashboardItem.name == 'Database') {
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => SqlView()));
    } else if (dashboardItem.name == 'Register') {
      ShiftController shiftController = ShiftController(0);
      shiftController.model.layoutType = 2;
      shiftController.launchShiftClosing(context);
    } else if (dashboardItem.name == 'Logout') {
      AppTheme.showAlertDialogYN(context,
          title: 'Logout',
          message: 'Are you sure?',
          onYes: () {
            LoginController().pushAndRemoveUntil(context);
          },
          onNo: () => Navigator.pop(context));
    }
  }

  Widget registerPopupContent() {
    return Container(
      // padding: EdgeInsets.all(10.0),
      // margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
      width: Config.getDeviceWidth(context) * 0.4,
      child: Wrap(
        children: [
          Container(
            child: Card(
              color: Colors.grey[100],
              child: ListTile(
                leading: Icon(
                  Icons.monetization_on,
                  color: Colors.grey[600],
                ),
                title: TextField(
                  keyboardType: TextInputType.number,
                  controller: closingAmount,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.amberAccent, width: 1),
                      ),
                      hintText: 'Closing Amount',
                      errorText: checkField ? errorMessage : null),
                ),
                trailing: RaisedButton(
                  elevation: 2.0,
                  onPressed: () {
                    setState(() {
                      checkField = closingAmount.text == '' ? true : false;
                      errorMessage = 'Required.';
                    });

                    if (!checkField) {
                      double amount = double.parse(closingAmount.text);
                      if (amount > 0) {
                        Config.currentShift.closingBalance = closingAmount.text;
                        Config.currentShift.closingBalanceDateTime =
                            Config.getCurrentDateTimeDBFormat();
                        Config.database.update(
                            Tables.shiftData,
                            {
                              Columns.shiftData[3]: closingAmount.text,
                              Columns.shiftData[5]:
                                  Config.getCurrentDateTimeDBFormat(),
                              Columns.shiftData[9]: '2'
                            },
                            where: '${Columns.shiftData[0]} = ?',
                            whereArgs: [Config.currentShift.remoteId]);
                        Lib.closeRegister(Config.currentShift);
                      } else {
                        checkField = true;
                        errorMessage = 'Invalid Amount.';
                      }
                    }
                  },
                  color: AppTheme.listTextColor,
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
