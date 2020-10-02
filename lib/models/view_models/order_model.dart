import 'package:food_app/models/objects/sales_master.dart';

class OrderModel {
  List<String> _orderTypeList;
  List<SalesMaster> _itemHoldList;
  List<SalesMaster> _dineInList;
  List<SalesMaster> _takeawayList;
  List<SalesMaster> _deliveryList;
  List<String> _dineInColumns;
  List<String> _takeawayAndDeliveryColumns;

  
  List<String> get dineInColumns => _dineInColumns;

  set dineInColumns(List<String> value) {
    _dineInColumns = value;
  }

  get getOrderTypeList => _orderTypeList;

  void setOrderTypeList(List<String> value) => _orderTypeList = value;

  get getItemHoldList => _itemHoldList;

  void setItemHoldList(List<SalesMaster> value) => _itemHoldList = value;

  void onOrderCancelled(SalesMaster salesMaster) {
    _itemHoldList.remove(salesMaster);
  }

  List<SalesMaster> get dineInList => _dineInList;

  List<SalesMaster> get takeawayList => _takeawayList;

  List<SalesMaster> get deliveryList => _deliveryList;

  set deliveryList(List<SalesMaster> value) {
    _deliveryList = value;
  }

  set takeawayList(List<SalesMaster> value) {
    _takeawayList = value;
  }

  set dineInList(List<SalesMaster> value) {
    _dineInList = value;
  }

  List<String> get takeawayAndDeliveryColumns => _takeawayAndDeliveryColumns;

  set takeawayAndDeliveryColumns(List<String> value) {
    _takeawayAndDeliveryColumns = value;
  }
}
