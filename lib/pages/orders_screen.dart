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
            NewSaleController().editOrder(item, context);
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
                  Config.database.update(
                      Tables.salesMaster, {Columns.salesMaster[30]: '3'},
                      where: '${Columns.salesMaster[0]} = ?',
                      whereArgs: [item.id]);
                  Map<String, dynamic> values = item.getValuesForUpload();
                  List<Map<String, dynamic>> values1 = [];
                  //COLUMNS 
                  List<Map<String, dynamic>> values2 = await Config.database
                      .query(Tables.salesDetails,
                          columns: Columns.salesDetails
                              .getRange(1, Columns.salesDetails.length - 1)
                              .toList(),
                          where: '${Columns.salesDetails[18]} = ?',
                          whereArgs: [item.id]);
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
                      await post(Config.addUpdateOrderApi, body: json).timeout(
                    Duration(seconds: 5),
                    onTimeout: () => null,
                  );
                  if (response != null)
                    log(response.body, name: 'Server Response: ');
                  else
                    log('Response Timeout', name: 'Request Timeout');
                },
              ),
              title: Center(child: Text(item.saleNo)),
              subtitle: Center(child: Text(item.totalPayable)),
              trailing: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () async {
                  await onOrderCancelled(item);
                  List<SalesMaster> list =
                      await SalesMaster().queryAllRows(Config.database);
                  setState(() {
                    this.model.setItemHoldList(list);
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
          onTap: () => NewSaleController().launchAndReplacement(context),
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
    await Config.database.execute(
        'update ${Columns.salesMaster[37]} set ${Columns.salesMaster[5]} = ${Columns.salesMaster[6]} where id = ${itm.id}');
    OrderController().launchAndReplacement(context);
  }
}

/*
{user_id: 1, json: [{"customer_id":"1","sale_no":"ORD/01/0001","total_items":"1","sub_total":null,"paid_amount":"0.0","due_amount":"1600.0","disc":null,"disc_actual":null,"vat":null,"total_payable":"1600.0","payment_method_id":"1","close_time":null,"table_id":"1","total_item_discount_amount":null,"sub_total_with_discount":null,"sub_total_discount_amount":null,"total_discount_amount":null,"delivery_charge":null,"sub_total_discount_value":null,"sub_total_discount_type":null,"sale_date":null,"date_time":"9/30/2020 1:50 PM","order_time":null,"cooking_start_time":null,"cooking_done_time":null,"modified":null,"user_id":"1","waiter_id":"1","outlet_id":"1","order_status":null,"order_type":"DINEIN","del_status":null,"sale_vat_objects":null,"device_key":"1","remote_id":null,"company_id":"1","sale_details":[{"id":1,"food_menu_id":"001","menu_name":null,"qty":"4","menu_price_without_discount":"1600.0","menu_price_with_discount":null,"menu_unit_price":"400.00","menu_vat_percentage":null,"menu_taxes":null,"menu_discount_value":null,"discount_type":null,"menu_note":null,"discount_amount":null,"item_type":null,"cooking_status":null,"cooking_start_time":null,"cooking_done_time":null,"previous_id":null,"sales_id":"1","order_status":null,"user_id":"1","outlet_id":"1","del_status":null}]}]}
*/
//1 dinein 2 takeaway 3 delivery
