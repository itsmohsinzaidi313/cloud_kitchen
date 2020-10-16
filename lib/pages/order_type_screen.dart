import 'package:flutter/material.dart';
import 'package:food_app/controller/new_sale_controller.dart';
import 'package:food_app/database/table_object/customer_table.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/models/objects/table.dart' as T;

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
  String errorMsg;
  bool takeawaySearchButton = false;
  bool deliverySearchButton = false;

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
    errorMsg = '';
  }

  int gridViewType;
  bool isWaiterSelected = false;
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Persons',
                      errorText: check[1] ? errorMsg : null),
                ),
              ),
              ListTile(
                title: FlatButton(
                  child: Text('Ok', style : TextStyle(color: isWaiterSelected ? Colors.white : null)),
                  color: isWaiterSelected ? Colors.red : null,
                  onPressed: isWaiterSelected ? () {
                    setState(() {
                      check[1] = controllers[1].text == '' ? true : false;
                      errorMsg = controllers[1].text == '' ? 'Required' : '';
                    });
                    if (!check[1]) {
                      int persons = int.parse(controllers[1].text);
                      if (persons > 0) {
                        NewSaleController().launchDineIn(
                                context,
                                _viewType.toString(),
                                table.serverId,
                                waiter.serverId, [
                              controllers[1].text,
                              table.name,
                              waiter.fullName
                            ]);
                      } else {
                        setState(() {
                          check[1] = true;
                          errorMsg = 'Invalid no of persons.';
                          isWaiterSelected = false;
                        });
                      }
                    }
                  } : null,
                ),
              ),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  children: getGridViewWidget(gridViewType),
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
                leading: Icon(Icons.dialpad),
                title: TextField(
                  keyboardType: TextInputType.number,
                  controller: controllers[3],
                  decoration: InputDecoration(
                      hintText: 'Contact',
                      errorText: check[3] ? errorMsg : null),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      check[3] = controllers[3].text == '' ? true : false;
                      errorMsg = controllers[3].text == '' ? 'Required' : '';
                      !check[3] ? takeawaySearchButton = true : takeawaySearchButton = false;
                    });
                    if (!check[3]) {
                      Config.database
                          .rawQuery(
                        "select count(id) as count from ${CustomerTable.tableName} where ${CustomerTable.phone} = '${controllers[3].text}'",
                      )
                          .then((value) {
                        int count = value[0]['count'] as int;
                        if (count > 0) {
                          Config.database
                              .query(CustomerTable.tableName,
                                  columns: [
                                    CustomerTable.localId,
                                    CustomerTable.name,
                                    CustomerTable.phone,
                                  ],
                                  where: '${CustomerTable.phone} = ?',
                                  whereArgs: [controllers[3].text])
                              .then((value2) {
                            this.customerId = value2[0][CustomerTable.localId];
                            controllers[2].text =
                                value2[0][CustomerTable.name];
                            controllers[3].text =
                                value2[0][CustomerTable.phone];
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
                leading: Icon(Icons.person),
                title: TextField(
                  controller: controllers[2],
                  decoration: InputDecoration(
                      hintText: 'Name', errorText: check[2] ? errorMsg : null),
                ),
              ),
              ListTile(
                title: FlatButton(
                  child: Text('Ok', style: TextStyle(color: Colors.white)),
                  onPressed: takeawaySearchButton ? () {
                    setState(() {
                      check[2] = controllers[2].text == '' ? true : false;
                      check[3] = controllers[3].text == '' ? true : false;
                      errorMsg = controllers[2].text == '' ? 'Required' : '';
                      errorMsg = controllers[3].text == '' ? 'Required' : '';
                      if (!check[2] && !check[3]) {
                        if (customerExists) {
                          NewSaleController().launchTakeaway(context,
                              _viewType.toString(), customerId.toString(), [
                            'Customer: ${controllers[2].text}',
                            'Contact: ${controllers[3].text}',
                            ''
                          ]);
                        } else {
                          User cUser = Config.currentUser;
                          Customer customer = Customer(
                              name: controllers[2].text,
                              phone: controllers[3].text,
                              userId: cUser.serverId,
                              companyId: cUser.companyId,
                              delStatus: cUser.delStatus,
                              isUpload: '0'
                          );

                          Customer()
                              .insertCustomer(Config.database, customer)
                              .then((value) {
                            customer.remoteId = value.toString();
                            if(value > 0){
                              NewSaleController().launchTakeaway(context,
                                  _viewType.toString(), value.toString(), [
                                    controllers[2].text,
                                    controllers[3].text,
                                    ''
                                  ]);
                            }
                          });
                        }
                      }
                    });
                  } : null,
                  color:  takeawaySearchButton ? Colors.redAccent : null,
                ),
                // tileColor: takeawaySearchButton ? Colors.redAccent : null,
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
                      !check[5] ? deliverySearchButton = true : deliverySearchButton = false;
                    });
                    if (!check[5]) {
                      Config.database
                          .rawQuery(
                        "select count(id) as count from ${CustomerTable.tableName} where ${CustomerTable.phone} = '${controllers[5].text}'",
                      )
                          .then((value) {
                        int count = value[0]['count'] as int;
                        if (count > 0) {
                          Config.database
                              .query(CustomerTable.tableName,
                                  columns: [
                                    CustomerTable.localId,
                                    CustomerTable.name,
                                    CustomerTable.phone,
                                    CustomerTable.address,
                                  ],
                                  where: '${CustomerTable.phone} = ?',
                                  whereArgs: [controllers[5].text])
                              .then((value2) {
                            this.customerId = value2[0][CustomerTable.localId];
                            controllers[4].text =
                                value2[0][CustomerTable.name];
                            controllers[5].text =
                                value2[0][CustomerTable.phone];
                            controllers[6].text =
                                value2[0][CustomerTable.address];
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
                leading: Icon(Icons.person),
                title: TextField(
                  controller: controllers[4],
                  decoration: InputDecoration(
                      hintText: 'Name',
                      errorText: check[4] ? 'Required' : null),
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
                title: FlatButton(
                  child: Text('Ok', style: TextStyle(color: Colors.white),),
                  onPressed: deliverySearchButton ? () {
                    setState(() {
                      check[4] = controllers[4].text == '' ? true : false;
                      check[5] = controllers[5].text == '' ? true : false;
                      check[6] = controllers[6].text == '' ? true : false;

                      errorMsg = controllers[4].text == '' ? 'Required' : '';
                      errorMsg = controllers[5].text == '' ? 'Required' : '';
                      errorMsg = controllers[6].text == '' ? 'Required' : '';
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
                              delStatus: cUser.delStatus,
                              isUpload: '0'
                          );

                          Customer()
                              .insertCustomer(Config.database, customer)
                              .then((value) {
                            customer.remoteId = value.toString();
                            if(value > 0){
                              NewSaleController().launchDelivery(context,
                                  _viewType.toString(), value.toString(), [
                                    controllers[4].text,
                                    controllers[5].text,
                                    ''
                                  ]);
                            }
                          });
                        }
                      }
                    });
                  } : null,
                  color :  deliverySearchButton ? Colors.redAccent : null,
                ),
                // tileColor: deliverySearchButton ? Colors.redAccent : null,
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
        listWidget.add(Container(
          child: Card(
            child: InkWell(
              child: Center(child: Text(element.name)),
              onTap: () {
                table = element;
                setState(() {
                  gridViewType = 2;
                });
              },
            ),
          ),
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
        listWidget.add(Container(
          child: Card(
            child: InkWell(
              child: Center(child: Text(element.fullName)),
              onTap: () {
                waiter = element;
                setState(() {
                  isWaiterSelected = true;
                });
              },
            ),
          ),
        ));
      });
    }
    return listWidget;
  }
}
