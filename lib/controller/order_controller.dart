import 'package:flutter/material.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/order_model.dart';
import 'package:food_app/pages/orders_screen.dart';
import 'package:food_app/shared/config.dart';
import 'package:sqflite/sqflite.dart';

class OrderController{

  OrderModel model;
  List<String> orderList = ['New Order'];
  List<SalesMaster> salesMasterList = [];

  OrderController()  {
    this.model = new OrderModel();
    model.setOrderTypeList(orderList);
    getHoldingOrders();
    getDineInList();
    getTakeawayList();
    getDeliveryList();
  }

  void getDineInList() async{
    List<SalesMaster> list = await SalesMaster().getDineInList(Config.database);
    model.dineInList = list;
  }

  void getTakeawayList() async{
    List<SalesMaster> list = await SalesMaster().getTakeawayList(Config.database);
    model.takeawayList = list;
  }

  void getDeliveryList() async{
    List<SalesMaster> list = await SalesMaster().getDeliveryList(Config.database);
    model.deliveryList = list;
  }

   void getHoldingOrders() async{
    Database db = Config.database;
    List<SalesMaster> list = await SalesMaster().queryAllRows(db);
    model.setItemHoldList(list);
  }

  void launch(BuildContext context) => SalesMaster().queryAllRows(Config.database).then((value) {
    this.model.setItemHoldList(value);
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => new OrderScreen(model: model,)));
  });


  void launchAndReplacement(BuildContext context) => SalesMaster().queryAllRows(Config.database).then((value) {
    this.model.setItemHoldList(value);
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new OrderScreen(model: model,)));
  });
}