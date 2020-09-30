import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controller/new_sale_controller.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/models/view_models/dashboard_model.dart';
import 'package:food_app/models/generic_models/dashboard_item.dart';
import 'package:food_app/pages/sql_view_page.dart';
import 'package:food_app/shared/app_theme.dart';
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
    if (dashboardItem.name == 'Sales') {
      AppTheme.showAlertDialog(
        context,
        title: 'SELECT Order Type'.toUpperCase(),
        fontSize: 20,
        fontWeight: FontWeight.bold,
        content: alertDialogContent(),
        barrier: false
      );
      // NewSaleController().launch(context);
    } else if (dashboardItem.name == 'Orders') {
      OrderController().launch(context);
    } else if (dashboardItem.name == 'Database') {
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => SqlView()));
    }
  }

  Widget alertDialogContent() {
  return Wrap(
    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      RaisedButton(
        onPressed: () {
          alertDialogButtonOnPressed('1');
        },
        color: Colors.redAccent,
        child: Text(
          'DINE-IN',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      RaisedButton(
        onPressed: () {
          alertDialogButtonOnPressed('2');
        },
        color: Colors.redAccent,
        child: Text(
          'TAKEAWAY',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      RaisedButton(
        onPressed: () {
          alertDialogButtonOnPressed('3');
        },
        color: Colors.redAccent,
        child: Text(
          'DELIVERY',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

alertDialogButtonOnPressed(String str) {
  switch (str) {
    case 'DINE-IN':
      NewSaleController().launchDinein(context, str);
      break;
    case 'TAKEAWAY':
      NewSaleController().launchTakeaway(context, str);
      break;
    case 'DELIVERY':
      // Navigator.pop(context);
      NewSaleController().launchDelivery(context, str);
      break;
  }
}
}
