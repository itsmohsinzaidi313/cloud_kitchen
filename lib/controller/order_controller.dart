import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_app/controller/payment_controller.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/models/objects/payment_method.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/order_model.dart';
import 'package:food_app/pages/orders_screen.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class OrderController {
  OrderModel model;
  List<SalesMaster> salesMasterList = [];
  List<PaymentMethod> paymentMethodList = [];

  OrderController(int orderType) {
    this.model = new OrderModel();
    model.paymentMethodList = DataLists.instance.listPaymentMethods;
    getDineInList();
    model.dineInColumns = [
      '...',
      'Sale No',
      'Table No',
      'Waiter Name',
      'DueAmount',
      '...'
    ];
    getTakeawayList();
    model.takeawayAndDeliveryColumns = [
      '...',
      'Sale No',
      'Cell No',
      'Customer Name',
      'DueAmount',
      '...'
    ];
    getDeliveryList();
    if (orderType == 1) {
      //DINE IN

    } else if (orderType == 2) {
      //TAKE AWAY

    } else if (orderType == 3) {
      //DELIVERY

    } else {}

    // getHoldingOrders();
  }

  void getDineInList() async {
    List<SalesMaster> list = await SalesMaster().getDineInList(Config.database);
    model.dineInList = list;
  }

  void getTakeawayList() async {
    List<SalesMaster> list =
        await SalesMaster().getTakeawayList(Config.database);
    model.takeawayList = list;
  }

  void getDeliveryList() async {
    List<SalesMaster> list =
        await SalesMaster().getDeliveryList(Config.database);
    model.deliveryList = list;
  }

  void getHoldingOrders() async {
    Database db = Config.database;
    List<SalesMaster> list = await SalesMaster().queryAllRows(db);
    model.setItemHoldList(list);
  }

  void launch(BuildContext context) =>
      SalesMaster().queryAllRows(Config.database).then((value) {
        this.model.setItemHoldList(value);
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new OrderScreen(
                  model: model,
                )));
      });

  void launchAndReplacement(BuildContext context) =>
      SalesMaster().queryAllRows(Config.database).then((value) {
        this.model.setItemHoldList(value);
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (context) => new OrderScreen(
                  model: model,
                )));
      });

  static Future<Widget> getDineInOrders(
      BuildContext context, OrderModel model) async {
    try {
      List<Map<String, dynamic>> data = await Config.database.rawQuery(
          "select *, a.id, a.sale_no, ifnull((select name from tables where id = a.table_id),'x') as tables, (select full_name from users where id = a.user_id) as waiter, a.due_amount from sales_master a where a.order_type = '1' and a.paid_amount = '0.0' and a.is_delete = '0'");

      List<DataRow> rows = [];
      data.forEach((element) {
        rows.add(DataRow(cells: [
          DataCell(IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
              onPressed: () {
                PaymentController(element).launch(context);
              })),
          DataCell(Text(element['sale_no'])),
          DataCell(Text(element['tables'])),
          DataCell(Text(element['waiter'])),
          DataCell(Text(element['due_amount'])),
          DataCell(IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () {})),
        ]));
      });
      return DataTable(
        columns: [
          DataColumn(label: Text('...')),
          DataColumn(label: Text('Sale No')),
          DataColumn(label: Text('Table#')),
          DataColumn(label: Text('Waiter')),
          DataColumn(label: Text('Amount')),
          DataColumn(label: Text('...')),
        ],
        rows: rows,
      );
    } catch (e) {
      return Container(
        child: Text('An error has occured \n$e'),
      );
    }
  }

  static Future<DataTable> getTakeAwayOrders(BuildContext context) async {
    List<Map<String, dynamic>> data = await Config.database.rawQuery(
        "select a.sale_no, IFNULL((select name from customers where id = a.customer_id),'') as customer_name, IFNULL((select phone from customers where id = a.customer_id),'') as contact, a.due_amount from sales_master a where a.order_type = '2' and a.paid_amount = '0.0' and a.is_delete = '0'");
    List<DataRow> rows = [];
    data.forEach((element) {
      rows.add(DataRow(cells: [
        DataCell(IconButton(
            icon: Icon(Icons.check, color: Colors.green), onPressed: () {})),
        DataCell(Text(element['sale_no'])),
        DataCell(Text(element['customer_name'])),
        DataCell(Text(element['contact'])),
        DataCell(Text(element['due_amount'])),
        DataCell(IconButton(
            icon: Icon(Icons.close, color: Colors.red),
            onPressed: () {
              PaymentController(element).launch(context);
            })),
      ]));
    });
    return DataTable(
      columns: [
        DataColumn(label: Text('...')),
        DataColumn(label: Text('Sale No')),
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Contact')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('...')),
      ],
      rows: rows,
    );
  }

  static Future<DataTable> getDeliveryOrders(BuildContext context) async {
    List<Map<String, dynamic>> data = await Config.database.rawQuery(
        "select *, a.sale_no, IFNULL((select full_name from users where id = a.user_id),'') as customer_name,IFNULL((select phone from customers where id = a.customer_id),'') as contact, a.due_amount from sales_master a where a.order_type = '3' and a.paid_amount = '0.0' and a.is_delete = '0'");

    List<DataRow> rows = [];
    data.forEach((element) {
      rows.add(DataRow(cells: [
        DataCell(IconButton(
            icon: Icon(Icons.check, color: Colors.green), onPressed: () {})),
        DataCell(Text(element['sale_no'])),
        DataCell(Text(element['customer_name'])),
        DataCell(Text(element['contact'])),
        DataCell(Text(element['due_amount'])),
        DataCell(IconButton(
            icon: Icon(Icons.close, color: Colors.red),
            onPressed: () {
              PaymentController(element).launch(context);
            })),
      ]));
    });
    return DataTable(
      columns: [
        DataColumn(label: Text('...')),
        DataColumn(label: Text('Sale No')),
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Contact')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('...')),
      ],
      rows: rows,
    );
  }

  static Future onOrderCancelled(SalesMaster salesMaster) async {
    Database db = Config.database;
    Map<String, dynamic> update = {
      Columns.salesMaster[37]: 1.toString(),
    };
    await SalesMaster().updateSpecificIntoDb(db, update, 'id', salesMaster.id);
  }

  static Future onOrderCompleted(SalesMaster itm) async {
    await Config.database.execute(
        'update ${Columns.salesMaster[37]} set ${Columns.salesMaster[5]} = ${Columns.salesMaster[6]} where id = ${itm.id}');
  }
}
