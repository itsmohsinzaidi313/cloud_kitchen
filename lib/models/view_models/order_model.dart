import 'package:food_app/models/objects/item.dart';

class OrderModel{

  List<String> _orderTypeList;
  List<Item> _itemHoldList;

   get getOrderTypeList => _orderTypeList;

  void setOrderTypeList(List<String> value) => _orderTypeList = value;

   get getItemHoldList => _itemHoldList;

  void setItemHoldList(List<Item> value) => _itemHoldList = value;

}