import 'package:flutter/material.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';

class OrderTypeScreen extends StatefulWidget {
  @override
  _OrderTypeScreenState createState() => _OrderTypeScreenState();
}

class _OrderTypeScreenState extends State<OrderTypeScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  int _viewType = 0;

  List<TextEditingController> controllers = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];
  List<bool> check = [false, false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _key,
      appBar: AppTheme.appBarNormal(
          appBarTitle: 'Order Type',
          appBarBgColor: AppTheme.appBarColor,
          appBarElevation: 0.0,
          context: context),
      body: SingleChildScrollView(
        child: Container(
          height: Config.getDeviceHeight(context),
          width: Config.getDeviceWidth(context),
          child: Row(
            children: [
              Expanded(
                child: getLayout(_viewType),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => setState(() => _viewType = 1),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 2,
                          ),
                          height: Config.getDeviceHeight(context) * 0.25,
                          width: Config.getDeviceWidth(context),
                          child: Card(
                            color: Colors.amberAccent,
                            elevation: 5,
                            child: Center(
                              child: Text(
                                'Dine-In',
                                style: TextStyle(
                                  fontSize: 30,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => _viewType = 2),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 2,
                          ),
                          height: Config.getDeviceHeight(context) * 0.25,
                          width: Config.getDeviceWidth(context),
                          child: Card(
                            color: Colors.amberAccent,
                            elevation: 5,
                            child: Center(
                              child: Text(
                                'TakeAway',
                                style: TextStyle(
                                  fontSize: 30,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => _viewType = 3),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 2,
                          ),
                          height: Config.getDeviceHeight(context) * 0.25,
                          width: Config.getDeviceWidth(context),
                          child: Card(
                            color: Colors.amberAccent,
                            elevation: 5,
                            child: Center(
                              child: Text(
                                'Delivery',
                                style: TextStyle(
                                  fontSize: 30,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getLayout(int viewType) {
    switch (viewType) {
      case 1:
        return Container(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.image_aspect_ratio),
                title: TextField(
                  controller: controllers[0],
                  decoration: InputDecoration(
                      hintText: 'Table#',
                      errorText: check[0] ? 'Required' : null),
                ),
              ),
              ListTile(
                leading: Icon(Icons.group),
                title: TextField(
                  controller: controllers[1],
                  decoration: InputDecoration(
                      hintText: 'Persons',
                      errorText: check[1] ? 'Required' : null),
                ),
              ),
              ListTile(
                title: OutlineButton(
                  child: Text('Ok'),
                  onPressed: () {
                    setState(() {
                      check[0] = controllers[0].text == '' ? true : false;
                      check[1] = controllers[1].text == '' ? true : false;
                    });
                  },
                ),
              ),
            ],
          ),
        );
        break;
      case 2:
        return Container(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: TextField(
                  controller: controllers[2],
                  decoration: InputDecoration(
                      hintText: 'Name',
                      errorText: check[2] ? 'Required' : null),
                ),
              ),
              ListTile(
                leading: Icon(Icons.dialpad),
                title: TextField(
                  controller: controllers[3],
                  decoration: InputDecoration(
                      hintText: 'Contact',
                      errorText: check[3] ? 'Required' : null),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      check[3] = controllers[3].text == '' ? true : false;
                    });
                    if (!check[3]) {
                      Config.database
                          .rawQuery(
                        "select count(id) as count from ${Tables.customers} where ${Columns.customers[3]} = '${controllers[3].text}'",
                      )
                          .then((value) {
                        int count = int.parse(value[0]['count']);
                        if (count > 0) {
                          Config.database
                              .query(Tables.customers,
                                  columns: [
                                    Columns.customers[2],
                                    Columns.customers[3],
                                  ],
                                  where: '${Columns.customers[3]} = ?',
                                  whereArgs: [controllers[3].text])
                              .then((value2) {
                            controllers[2].text =
                                value2[0][Columns.customers[2]];
                            controllers[3].text =
                                value2[0][Columns.customers[3]];
                          });
                        }
                      });
                    }
                  },
                ),
              ),
              ListTile(
                title: OutlineButton(
                  child: Text('Ok'),
                  onPressed: () {
                    setState(() {
                      check[2] = controllers[2].text == '' ? true : false;
                      check[3] = controllers[3].text == '' ? true : false;
                    });
                  },
                ),
              ),
            ],
          ),
        );
        break;
      case 3:
        return Container(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: TextField(
                  controller: controllers[4],
                  decoration: InputDecoration(
                      hintText: 'Name',
                      errorText: check[4] ? 'Required' : null),
                ),
              ),
              ListTile(
                leading: Icon(Icons.dialpad),
                title: TextField(
                  controller: controllers[5],
                  decoration: InputDecoration(
                      hintText: 'Contact',
                      errorText: check[5] ? 'Required' : null),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      check[5] = controllers[5].text == '' ? true : false;
                    });
                    if (!check[5]) {
                      Config.database
                          .rawQuery(
                        "select count(id) as count from ${Tables.customers} where ${Columns.customers[3]} = '${controllers[5].text}'",
                      )
                          .then((value) {
                        int count = int.parse(value[0]['count']);
                        if (count > 0) {
                          Config.database
                              .query(Tables.customers,
                                  columns: [
                                    Columns.customers[2],
                                    Columns.customers[3],
                                    Columns.customers[5],
                                  ],
                                  where: '${Columns.customers[3]} = ?',
                                  whereArgs: [controllers[5].text])
                              .then((value2) {
                            controllers[4].text =
                                value2[0][Columns.customers[2]];
                            controllers[5].text =
                                value2[0][Columns.customers[3]];
                            controllers[6].text =
                                value2[0][Columns.customers[5]];
                          });
                        }
                      });
                    }
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: TextField(
                  controller: controllers[6],
                  decoration: InputDecoration(
                      hintText: 'Address',
                      errorText: check[4] ? 'Required' : null),
                ),
              ),
              ListTile(
                title: OutlineButton(
                  child: Text('Ok'),
                  onPressed: () {
                    setState(() {
                      check[4] = controllers[4].text == '' ? true : false;
                      check[5] = controllers[5].text == '' ? true : false;
                      check[6] = controllers[6].text == '' ? true : false;
                    });
                  },
                ),
              ),
            ],
          ),
        );
        break;
      default:
        return Container();
        break;
    }
  }
}
