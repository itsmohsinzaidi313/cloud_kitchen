import 'package:flutter/material.dart';
import 'package:food_app/controller/new_sale_controller.dart';
import 'package:food_app/database/table_object/customer_table.dart';
import 'package:food_app/database/table_object/orders_table.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/view_models/order_type_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/models/objects/table.dart' as T;
import 'package:google_fonts/google_fonts.dart';

class OrderTypeScreen extends StatefulWidget {
  OrderTypeModel model;

  OrderTypeScreen(OrderTypeModel model) {
    this.model = model;
  }

  @override
  _OrderTypeScreenState createState() => _OrderTypeScreenState(this.model);
}

class _OrderTypeScreenState extends State<OrderTypeScreen> {
  final OrderTypeModel model;

  _OrderTypeScreenState(this.model);

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
      body: Container(
        height: Config.getDeviceHeight(context),
        width: Config.getDeviceWidth(context),
        child: Row(
          children: [
            Expanded(
              child: getLayout(_viewType),
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        color: Color(0xff7c94b6),
                        elevation: 5,
                        child: InkWell(
                          onTap: () => setState(() => _viewType = 1),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/dine_in.jpg'),
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.dstATop),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 2,
                            ),
                            height: Config.getDeviceHeight(context) * 0.25,
                            width: Config.getDeviceWidth(context),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Dine-In',
                                style: GoogleFonts.ptSans(
                                  fontSize: 35,
                                  letterSpacing: 3.0,
                                  wordSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Color(0xff7c94b6),
                        elevation: 5,
                        child: InkWell(
                          onTap: () => setState(() => _viewType = 2),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/takeaway.jpg'),
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.dstATop),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 2,
                            ),
                            height: Config.getDeviceHeight(context) * 0.25,
                            width: Config.getDeviceWidth(context),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Takeaway',
                                style: GoogleFonts.ptSans(
                                  fontSize: 35,
                                  letterSpacing: 3.0,
                                  wordSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Color(0xff7c94b6),
                        elevation: 5,
                        child: InkWell(
                          onTap: () => setState(() => _viewType = 3),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/delivery.jpg'),
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.dstATop),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 2,
                            ),
                            height: Config.getDeviceHeight(context) * 0.25,
                            width: Config.getDeviceWidth(context),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Delivery',
                                style: GoogleFonts.ptSans(
                                  fontSize: 35,
                                  letterSpacing: 3.0,
                                  wordSpacing: 1.0,
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
            ),
          ],
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
          margin: EdgeInsets.all(5.0),
          child: Column(
            children: [
              Card(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        ListTile(
                          title: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey.shade200,
                              border: Border(
                                left: BorderSide(
                                  color: Colors.yellow.shade700,
                                  width: 3.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: controllers[1],
                              cursorColor: Colors.yellow[700],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.group,
                                    color: Colors.yellow.shade800,
                                    size: 20,
                                  ),
                                  hintText: 'Persons',
                                  border: InputBorder.none,
                                  errorText: check[1] ? errorMsg : null),
                            ),
                          ),
                        ),
                        ListTile(
                          title: FlatButton(
                            child: Text('Ok',
                                style: TextStyle(color: Colors.white)),
                            color: isWaiterSelected ? Colors.red : null,
                            onPressed: isWaiterSelected
                                ? () {
                                    setState(() {
                                      check[1] = controllers[1].text == ''
                                          ? true
                                          : false;
                                      errorMsg = controllers[1].text == ''
                                          ? 'Required'
                                          : '';
                                    });
                                    if (!check[1]) {
                                      int persons =
                                          int.parse(controllers[1].text);
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
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  color: Colors.white70,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    children: getGridViewWidget(gridViewType),
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case 2:
        return SingleChildScrollView(
          child: Container(
            height: Config.getDeviceHeight(context) * 0.8,
            margin: EdgeInsets.all(5.0),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    ListTile(
                      title: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey.shade200,
                          border: Border(
                            left: BorderSide(
                              color: Colors.yellow.shade700,
                              width: 3.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: controllers[3],
                          cursorColor: Colors.yellow.shade700,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.dialpad,
                                color: Colors.yellow.shade800,
                                size: 20,
                              ),
                              hintText: 'Contact',
                              border: InputBorder.none,
                              errorText: check[3] ? errorMsg : null),
                        ),
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              check[3] =
                                  controllers[3].text == '' ? true : false;
                              errorMsg =
                                  controllers[3].text == '' ? 'Required' : '';
                              !check[3]
                                  ? takeawaySearchButton = true
                                  : takeawaySearchButton = false;
                            });
                            if (!check[3]) {
                              Config.database
                                  .rawQuery(
                                "select count(${CustomerTable.serverId}) as count from ${CustomerTable.tableName} where ${CustomerTable.phone} = '${controllers[3].text}'",
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
                                    this.customerId =
                                        value2[0][CustomerTable.localId];
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
                    ),
                    ListTile(
                      title: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey.shade200,
                          border: Border(
                            left: BorderSide(
                              color: Colors.yellow.shade700,
                              width: 3.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: TextField(
                          controller: controllers[2],
                          cursorColor: Colors.yellow.shade700,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                size: 20,
                                color: Colors.yellow.shade800,
                              ),
                              border: InputBorder.none,
                              hintText: 'Name',
                              errorText: check[2] ? errorMsg : null),
                        ),
                      ),
                    ),
                    ListTile(
                      title: FlatButton(
                        child:
                            Text('Ok', style: TextStyle(color: Colors.white)),
                        onPressed: takeawaySearchButton
                            ? () {
                                setState(() {
                                  check[2] =
                                      controllers[2].text == '' ? true : false;
                                  check[3] =
                                      controllers[3].text == '' ? true : false;
                                  errorMsg = controllers[2].text == ''
                                      ? 'Required'
                                      : '';
                                  errorMsg = controllers[3].text == ''
                                      ? 'Required'
                                      : '';
                                  if (!check[2] && !check[3]) {
                                    if (customerExists) {
                                      NewSaleController().launchTakeaway(
                                          context,
                                          _viewType.toString(),
                                          customerId.toString(), [
                                        controllers[2].text,
                                        controllers[3].text,
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
                                          isUpload: '0');

                                      Customer()
                                          .insertCustomer(
                                              Config.database, customer)
                                          .then((value) {
                                        customer.remoteId = value.toString();
                                        if (value > 0) {
                                          NewSaleController().launchTakeaway(
                                              context,
                                              _viewType.toString(),
                                              value.toString(), [
                                            controllers[2].text,
                                            controllers[3].text,
                                            ''
                                          ]);
                                        }
                                      });
                                    }
                                  }
                                });
                              }
                            : null,
                        color: takeawaySearchButton ? Colors.redAccent : null,
                      ),
                      // tileColor: takeawaySearchButton ? Colors.redAccent : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        break;
      case 3:
        return SingleChildScrollView(
          child: Container(
            height: Config.getDeviceHeight(context) * 0.8,
            margin: EdgeInsets.all(5.0),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    ListTile(
                      title: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey.shade200,
                          border: Border(
                            left: BorderSide(
                              color: Colors.yellow.shade700,
                              width: 3.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.yellow.shade700,
                          controller: controllers[5],
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.dialpad,
                                size: 20,
                                color: Colors.yellow.shade800,
                              ),
                              hintText: 'Contact',
                              border: InputBorder.none,
                              errorText: check[5] ? 'Required' : null),
                        ),
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              check[5] =
                                  controllers[5].text == '' ? true : false;
                              !check[5]
                                  ? deliverySearchButton = true
                                  : deliverySearchButton = false;
                            });
                            if (!check[5]) {
                              Config.database
                                  .rawQuery(
                                "select count(${CustomerTable.serverId}) as count from ${CustomerTable.tableName} where ${CustomerTable.phone} = '${controllers[5].text}'",
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
                                    this.customerId =
                                        value2[0][CustomerTable.localId];
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
                    ),
                    ListTile(
                      title: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey.shade200,
                          border: Border(
                            left: BorderSide(
                              color: Colors.yellow.shade700,
                              width: 3.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: TextField(
                          controller: controllers[4],
                          cursorColor: Colors.yellow.shade700,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                size: 20,
                                color: Colors.yellow.shade800,
                              ),
                              hintText: 'Name',
                              border: InputBorder.none,
                              errorText: check[4] ? 'Required' : null),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey.shade200,
                          border: Border(
                            left: BorderSide(
                              color: Colors.yellow.shade700,
                              width: 3.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: TextField(
                          controller: controllers[6],
                          cursorColor: Colors.yellow.shade700,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.home,
                                size: 20,
                                color: Colors.yellow.shade800,
                              ),
                              hintText: 'Address',
                              border: InputBorder.none,
                              errorText: check[4] ? 'Required' : null),
                        ),
                      ),
                    ),
                    ListTile(
                      title: FlatButton(
                        child: Text(
                          'Ok',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: deliverySearchButton
                            ? () {
                                setState(() {
                                  check[4] =
                                      controllers[4].text == '' ? true : false;
                                  check[5] =
                                      controllers[5].text == '' ? true : false;
                                  check[6] =
                                      controllers[6].text == '' ? true : false;

                                  errorMsg = controllers[4].text == ''
                                      ? 'Required'
                                      : '';
                                  errorMsg = controllers[5].text == ''
                                      ? 'Required'
                                      : '';
                                  errorMsg = controllers[6].text == ''
                                      ? 'Required'
                                      : '';
                                  if (!check[4] && !check[5] && !check[6]) {
                                    if (customerExists) {
                                      NewSaleController().launchDelivery(
                                          context,
                                          _viewType.toString(),
                                          customerId.toString(), [
                                        controllers[4].text,
                                        controllers[5].text,
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
                                          isUpload: '0');

                                      Customer()
                                          .insertCustomer(
                                              Config.database, customer)
                                          .then((value) {
                                        customer.remoteId = value.toString();
                                        if (value > 0) {
                                          NewSaleController().launchDelivery(
                                              context,
                                              _viewType.toString(),
                                              value.toString(), [
                                            controllers[4].text,
                                            controllers[5].text,
                                            ''
                                          ]);
                                        }
                                      });
                                    }
                                  }
                                });
                              }
                            : null,
                        color: deliverySearchButton ? Colors.redAccent : null,
                      ),
                      // tileColor: deliverySearchButton ? Colors.redAccent : null,
                    ),
                  ],
                ),
              ),
            ),
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
    List<T.Table> listTables = model.listTables;
    List<User> listWaiters = model.listWaiters;
    if (viewType == 1) {
      listTables.forEach((element) {
        // Color color = Colors.white;
        // Color textColor = Colors.black;
        Icon icon = Icon(
          Icons.lock_open_rounded,
          size: 20,
          color: Colors.green,
        );
        if (element.delStatus == OrdersTable.RESERVED) {
          // color = Colors.grey;
          // textColor = Colors.white;
          icon = Icon(
            Icons.lock_rounded,
            size: 20,
            color: Colors.red,
          );
        }
        listWidget.add(
          Card(
            elevation: 10,
            color: Colors.grey.shade100,
            child: InkWell(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 2,
                    left: 2,
                    child: Text(
                      element.name,
                      style: GoogleFonts.ubuntuCondensed(
                        color: Colors.grey.shade800,
                        fontSize: 14,
                        letterSpacing: 1.0,
                        wordSpacing: 1.0,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Image(
                        image: AssetImage('assets/table.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(-1, -1),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: icon,
                    ),
                  ),
                ],
              ),
              onTap: element.delStatus == OrdersTable.RESERVED
                  ? () => _key.currentState.showSnackBar(
                      SnackBar(content: Text('Table is reserved.')))
                  : () {
                      table = element;
                      setState(() {
                        gridViewType = 2;
                      });
                    },
            ),
          ),
        );
      });
    } else if (viewType == 2) {
      listWidget.add(Card(
        color: Colors.grey,
        child: Center(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: () => setState(() => gridViewType = 1),
          ),
        ),
      ));
      listWaiters.forEach((element) {
        listWidget.add(Container(
          child: Card(
            color: waiter == element ? Colors.redAccent[200] : Colors.white,
            child: InkWell(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 2,
                    left: 2,
                    child: Text(
                      element.fullName.toUpperCase(),
                      style: GoogleFonts.ubuntuCondensed(
                        color: waiter == element ? Colors.white : Colors.grey[800],
                        fontSize: 14,
                        letterSpacing: 1.0,
                        wordSpacing: 1.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Image(
                        image: AssetImage('assets/waiter.png'),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  waiter = element;
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
