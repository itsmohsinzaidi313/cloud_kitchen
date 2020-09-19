import 'package:flutter/material.dart';
import 'package:food_app/pos/new_sale.dart';
import 'package:food_app/shared/app_theme.dart';
import 'file:///D:/Flutter/cloud_kitchen/lib/models/generic_models/dashboard_item.dart';
import 'package:food_app/shared/widgets/dashboard_card.dart';
import 'package:toast/toast.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
//  Map<String, dynamic> args;

  DashboardItem dashboardItem = DashboardItem(
      img: 'assets/sales.png', name: 'Sales', subtitle: 'Your daily sales');

  List<DashboardItem> lst = [
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
        img: 'assets/logout.png', name: 'Logout', subtitle: 'You can rest')
  ];

  @override
  Widget build(BuildContext context) {
//    args = ModalRoute.of(context).settings.arguments;
//    print('Dashboard : ${args['regId']}');

  void onCardTap(DashboardItem dashboardItem){
    Toast.show(dashboardItem.name, context);
    if (dashboardItem.name == 'Sales'){
      AppTheme.timerWithNavigation(context, 0, NewSale());
    }
  }

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
              itemCount: lst.length,
              shrinkWrap: true,
              itemBuilder: (context, position) {
                return Container(
                  padding: position == lst.length
                      ? const EdgeInsets.only(top: 16.0)
                      : const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: DashboardCard(
                    lst[position],
                    250.0,
                    250.0,
                    () {
                      onCardTap(dashboardItem);
                    },
                  ),
                );
              },
            );
          } else if (constraints.maxWidth < 700) {
            return GridView.builder(
              itemCount: lst.length,
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, position) {
                return DashboardCard(
                  lst[position],
                  220.0,
                  220.0,
                  () {
                    onCardTap(dashboardItem);
                  },
                );
              },
            );
          } else {
            return GridView.builder(
              itemCount: lst.length,
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, position) {
                return DashboardCard(
                  lst[position],
                  250.0,
                  250.0,
                  () {
                    onCardTap(dashboardItem);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
