import 'package:food_app/models/objects/sales_master.dart';

class OrderModel{

  List<String> _orderTypeList;
  List<SalesMaster> _itemHoldList;

   get getOrderTypeList => _orderTypeList;

  void setOrderTypeList(List<String> value) => _orderTypeList = value;

   get getItemHoldList => _itemHoldList;

  void setItemHoldList(List<SalesMaster> value) => _itemHoldList = value;

  void onOrderCancelled(SalesMaster salesMaster){
      _itemHoldList.remove(salesMaster);
  }

}