import 'package:flutter/material.dart';
import 'package:food_app/controller/new_sale_controller.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/models/objects/table.dart' as T;
import 'package:food_app/shared/lib.dart';

class OrderTypeScreen extends StatefulWidget {
  @override
  _OrderTypeScreenState createState() => _OrderTypeScreenState();
}

class _OrderTypeScreenState extends State<OrderTypeScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  int _viewType = 0;
  bool customerExists = true;
  int customerId = 0;
  T.Table table;
  User waiter;
  List<String> titleStrings = [];

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

  @override
  void initState() {
    super.initState();
    gridViewType = 1;
  }

  int gridViewType;
  int listLength = DataLists.instance.listTables.length;

  Widget getLayout(int viewType) {
    switch (viewType) {
      case 1:
        return Container(
          child: Column(
            children: [
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
                title:
                OutlineButton(
                  child: Text('Ok'),
                  onPressed: () {
                    setState(() {
                      check[0] = controllers[0].text == '' ? true : false;
                      check[1] = controllers[1].text == '' ? true : false;
                    });
                    titleStrings.add('Persons: ${controllers[1].text}');
                    Config.database.insert(Tables.orderTable, {
                      Columns.ordersTables[1]: controllers[1].text,
                      Columns.ordersTables[2]: Config.getCurrentTime24Format(),
                      Columns.ordersTables[5]: waiter.outletId,
                      Columns.ordersTables[6]: table.serverId,
                      Columns.ordersTables[7]: 'Live'
                    }).then((value) => NewSaleController().launchDineIn(
                        context,
                        _viewType.toString(),
                        value.toString(),
                        waiter.serverId,
                        titleStrings));
                  },
                ),
              ),
              Expanded(
                  child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                children: getGridViewWidget(gridViewType),
              ))
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
                  keyboardType: TextInputType.number,
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
                        int count = value[0]['count'] as int;
                        if (count > 0) {
                          Config.database
                              .query(Tables.customers,
                                  columns: [
                                    Columns.customers[0],
                                    Columns.customers[2],
                                    Columns.customers[3],
                                  ],
                                  where: '${Columns.customers[3]} = ?',
                                  whereArgs: [controllers[3].text])
                              .then((value2) {
                            this.customerId = value2[0][Columns.customers[0]];
                            controllers[2].text =
                                value2[0][Columns.customers[2]];
                            controllers[3].text =
                                value2[0][Columns.customers[3]];
                          });
                        } else {
                          this.customerExists = false;
                          AppTheme.showAlertDialogOK(context,
                              title: 'Attention',
                              message: 'Customer does not exists',
                              onOK: () => Navigator.pop(context));
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
                    titleStrings = [];
                    setState(() {
                      check[2] = controllers[2].text == '' ? true : false;
                      check[3] = controllers[3].text == '' ? true : false;
                      if (!check[2] && !check[3]) {
                        if (customerExists) {
                          NewSaleController().launchTakeaway(
                              context,
                              _viewType.toString(),
                              customerId.toString(),
                              [controllers[2].text, controllers[3].text, '']);
                        } else {
                          User cUser = Config.currentUser;
                          Customer customer = Customer(
                              name: controllers[2].text,
                              phone: controllers[3].text,
                              userId: cUser.serverId,
                              companyId: cUser.companyId,
                              delStatus: cUser.delStatus);

                          Customer()
                              .insertCustomer(Config.database, customer)
                              .then((value) {
                            customer.id = value.toString();
                            Lib.uploadCustomer(customer);
                            NewSaleController().launchTakeaway(
                                context,
                                _viewType.toString(),
                                value.toString(),
                                [controllers[2].text, controllers[3].text, '']);
                          });
                        }
                      }
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
                  keyboardType: TextInputType.number,
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
                        int count = value[0]['count'] as int;
                        if (count > 0) {
                          Config.database
                              .query(Tables.customers,
                                  columns: [
                                    Columns.customers[0],
                                    Columns.customers[2],
                                    Columns.customers[3],
                                    Columns.customers[5],
                                  ],
                                  where: '${Columns.customers[3]} = ?',
                                  whereArgs: [controllers[5].text])
                              .then((value2) {
                            this.customerId = value2[0][Columns.customers[0]];
                            controllers[4].text =
                                value2[0][Columns.customers[2]];
                            controllers[5].text =
                                value2[0][Columns.customers[3]];
                            controllers[6].text =
                                value2[0][Columns.customers[5]];
                          });
                        } else {
                          this.customerExists = false;
                          AppTheme.showAlertDialogOK(context,
                              title: 'Attention',
                              message: 'Customer does not exists',
                              onOK: () => Navigator.pop(context));
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
                      if (!check[4] && !check[5] && !check[6]) {
                        if (customerExists) {
                          NewSaleController().launchDelivery(context,
                              _viewType.toString(), customerId.toString(), [
                            'Customer: ${controllers[4].text}',
                            'Phone: ${controllers[5].text}',
                            ''
                          ]);
                        } else {
                          User cUser = Config.currentUser;
                          Customer customer = Customer(
                              name: controllers[4].text,
                              phone: controllers[5].text,
                              address: controllers[6].text,
                              userId: cUser.serverId,
                              companyId: cUser.companyId,
                              delStatus: cUser.delStatus);

                          Customer()
                              .insertCustomer(Config.database, customer)
                              .then((value) {
                            customer.id = value.toString();
                            Lib.uploadCustomer(customer);
                            NewSaleController().launchDelivery(context,
                                _viewType.toString(), value.toString(), [
                              'Customer: ${controllers[4].text}',
                              'Phone: ${controllers[5].text}',
                              ''
                            ]);
                          });
                        }
                      }
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

  List<Widget> getGridViewWidget(int viewType) {
    List<Widget> listWidget = [];
    List<T.Table> listTables = DataLists.instance.listTables;
    List<User> listWaiters = DataLists.instance.listUsers
        .where((element) => element.designation == 'Waiter')
        .toList();
    if (viewType == 1) {
      listTables.forEach((element) {
        listWidget.add(InkWell(
          child: Container(
            child: Card(
              child: Center(child: Text(element.name)),
            ),
          ),
          onTap: () {
            table = element;
            setState(() {
              gridViewType = 2;
              titleStrings.add('Table: ${element.name}');
            });
          },
        ));
      });
    } else if (viewType == 2) {
      listWidget.add(Card(
        child: Center(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => setState(() => gridViewType = 1),
          ),
        ),
      ));
      listWaiters.forEach((element) {
        listWidget.add(InkWell(
          child: Container(
            child: Card(
              child: Center(child: Text(element.fullName)),
            ),
          ),
          onTap: () {
            waiter = element;
            titleStrings.add('Waiter: ${element.fullName}');
          },
        ));
      });
    }
    return listWidget;
  }
}
