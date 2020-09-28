import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_app/controller/new_sale_controller.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/order_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:http/http.dart';
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
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: getHoldingOrderList(model.getItemHoldList),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: getOrderTypeList(model.getOrderTypeList),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getHoldingOrderList(List<SalesMaster> sales) {
    List<Widget> widgets = [];
    sales.forEach((item) {
      widgets.add(
        InkWell(
          onTap: () {
            setState(() {
              _key.currentState.showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 500),
                  content: Text('I am Tapped'),
                ),
              );
            });
          },
          child: Card(
            elevation: 5,
            child: ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () async {
                  Map<String, dynamic> values = item.getValuesForUpload();
                  List<Map<String, dynamic>> values1 = [];
                  List<Map<String, dynamic>> values2 = await Config.database
                      .query(Tables.salesDetails,
                          where: 'sales_master_id = ?', whereArgs: [item.id]);
                  print(values['sale_no']);
                  values.update('sale_no', (value) => 'ORD//00//0001');
                  print(values['sale_no']);
                  values['device_key'] = '622780154';
                  values['customer_id'] = '1';
                  values['remote_id'] = '1';
                  values['sale_details'] = values2;
                  values1.add(values);
                  Map<String, dynamic> json = new Map();
                  json['user_id'] = '1';
                  json['json'] = jsonEncode(values1);
                  log(
                    json.toString(),
                    name: 'Order Upload Json: ',
                  );
                  Response response =
                      await post(Config.addUpdateOrderApi, body: json);
                  log(response.body, name: 'Server Response: ');
                },
              ),
              title: Center(child: Text(item.saleNo)),
              subtitle: Center(child: Text(item.totalPayable)),
              trailing: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    onOrderCancelled(item);
                    model.onOrderCancelled(item);
                  });
                },
              ),
            ),
          ),
        ),
      );
    });
    return widgets;
  }

  List<Widget> getOrderTypeList(List<String> type) {
    List<Widget> widgets = [];
    type.forEach((item) {
      widgets.add(
        InkWell(
          onTap: () {
            setState(() {
              NewSaleController().launch(context);
              // _key.currentState.showSnackBar(
              //   SnackBar(
              //     duration: Duration(milliseconds: 100),
              //     content: Text('$item Tapped'),
              //   ),
              // );
            });
          },
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
                  item.toUpperCase(),
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
      );
    });
    return widgets;
  }

  Future onOrderCancelled(SalesMaster itm) async {
    Database db = Config.database;
    Map<String, dynamic> update = {
      Columns.salesMaster[37]: 1.toString(),
    };
    await SalesMaster().updateSpecificIntoDb(db, update, 'id', itm.id);
  }

  Future onOrderCompleted(SalesMaster itm) async {
    Config.database.execute(
        'update ${Columns.salesMaster[37]} set ${Columns.salesMaster[5]} = ${Columns.salesMaster[6]} where id = ${itm.id}');
    OrderController().launchAndReplacement(context);
  }
}
