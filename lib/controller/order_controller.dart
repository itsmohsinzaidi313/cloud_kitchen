import 'package:flutter/material.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/view_models/order_model.dart';
import 'package:food_app/pages/orders_screen.dart';

class OrderController{

  OrderModel model;
  List<String> orderList = ['Dine-In', 'Delivery', 'Takeaway'];
  List<Item> holdingList = [
    Item(name: 'Item 1'),
    Item(name: 'Item 2'),
    Item(name: 'Item 3'),
    Item(name: 'Item 4'),
    Item(name: 'Item 5'),
    Item(name: 'Item 6'),];

  OrderController(){
    this.model = new OrderModel();
    model.setOrderTypeList(orderList);
    model.setItemHoldList(holdingList);
  }

  void launch(BuildContext context) => Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) => new OrderScreen(model: model,)));
}