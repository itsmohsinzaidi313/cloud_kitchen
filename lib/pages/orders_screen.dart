import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/controller/payment_controller.dart';
import 'package:food_app/database/table_object/orders_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/database/table_object/tables_table.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/order_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:sqflite/sqflite.dart';

class OrderScreen extends StatefulWidget {
  final OrderModel model;

  OrderScreen({this.model});

  @override
  _OrderScreenState createState() => _OrderScreenState(this.model);
}

class _OrderScreenState extends State<OrderScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final OrderModel model;

  _OrderScreenState(this.model);

  int orderType;

  @override
  void initState() {
    super.initState();
    orderType = model.orderType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _key,
      appBar: AppTheme.appBarNormal(
          appBarTitle: 'New Order',
          appBarBgColor: AppTheme.appBarColor,
          appBarElevation: 0.0,
          context: context),
      body: Container(
        height: Config.getDeviceHeight(context),
        width: Config.getDeviceWidth(context),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: RaisedButton.icon(
                      onPressed: () {
                        setState(() {
                          orderType = 1;
                          model.orderType = orderType;
                        });
                      },
                      color: AppTheme.listTextColor,
                      icon: Icon(
                        Icons.local_dining,
                      ),
                      label: Text('Dine-In'.toUpperCase()),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: RaisedButton.icon(
                      onPressed: () {
                        setState(() {
                          orderType = 2;
                          model.orderType = orderType;
                        });
                      },
                      color: AppTheme.listTextColor,
                      icon: Icon(
                        Icons.directions_walk,
                      ),
                      label: Text('Takeaway'.toUpperCase()),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: RaisedButton.icon(
                      onPressed: () {
                        setState(() {
                          orderType = 3;
                          model.orderType = orderType;
                        });
                      },
                      color: AppTheme.listTextColor,
                      icon: Icon(
                        Icons.directions_bike,
                      ),
                      label: Text('Delivery'.toUpperCase()),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                flex: 1,
                child: FutureBuilder(
                    future: getOrdersList(orderType),
                    initialData: Container(
                      child: SpinKitRing(
                        color: Colors.yellow[800],
                      ),
                    ),
                    builder: (context, snapshot) => snapshot.data)),
          ],
        ),
      ),
    );
  }

  Future<Widget> getOrdersList(int orderType) async {
    Widget widget;
    switch (orderType) {
      case 1:
        widget = await OrderController.getDineInOrders(
            context,
            (element) => PaymentController(new SalesMaster.fromJson(element))
                .launch(context),
            (element) => onOrderCancelled(new SalesMaster.fromJson(element)),
            orderType);
        break;
      case 2:
        widget = await OrderController.getTakeAwayOrders(
            context,
            (element) => PaymentController(new SalesMaster.fromJson(element))
                .launch(context),
            (element) => onOrderCancelled(new SalesMaster.fromJson(element)),
            orderType);
        break;
      case 3:
        widget = await OrderController.getDeliveryOrders(
            context,
            (element) => PaymentController(new SalesMaster.fromJson(element))
                .launch(context),
            (element) => onOrderCancelled(new SalesMaster.fromJson(element)),
            orderType);
        break;
      default:
        break;
    }
    return widget;
  }

  Future onOrderCancelled(SalesMaster salesMaster) async {
    await AppTheme.showAlertDialogYNFutureReturn(context,
        title: 'Question',
        message: 'Are you sure?',
        onNo: () => Navigator.of(context).pop(),
        onYes: () async {
          Database db = Config.database;
          if (salesMaster.orderType == SalesMaster.DINEIN) {
            await db.update(OrdersTable.tableName,
                {TablesTable.delStatus: TablesTable.FREE},
                where: '${OrdersTable.tableId} = ?',
                whereArgs: [salesMaster.tableId]) > 0 ? print('ORDERS_TABLE TABLE UPDATED') : print('ORDERS_TABLE TABLE NOT UPDATED');
          }
          Map<String, dynamic> _update = {
            SalesMasterTable.isDelete: 1.toString(),
          };
          await SalesMaster()
              .updateSpecificIntoDb(db, _update, SalesMasterTable.localId, salesMaster.localId)
              .whenComplete(() {
            setState(() {
              Navigator.pop(context);
              print('SALES MASTER TABLE UPDATED');
            });
          });
        });
  }
}
