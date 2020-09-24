import 'package:food_app/models/objects/item.dart';

class CustomerOrder{

  List<Item> _itemList = [];
  String _tableNo, _orderType, _discount, _salesTax;

  get tableNo => _tableNo;
  set tableNo(value) => _tableNo = value;

  get orderType => _orderType;
  set orderType(value) => _orderType = value;

  get salesTax => _salesTax;
  set salesTax(value) => _salesTax = value;

  get discount => _discount;
  set discount(value) => _discount = value;

  get itemList => _itemList;

  void addItem(Item item){
    _itemList.add(item);
  }

  void removeItem(Item item){
    _itemList.remove(item);
  }

  double getOrderAmount(){
    double orderAmount = 0;
    _itemList.forEach((item) {
      orderAmount = orderAmount + double.parse(item.salePrice) * int.parse(item.quantity);
    });
    return orderAmount;
  }

  double getTotalAmount(){
    return null;
  }

  double getAmountWithDiscount(){
    return null;
  }

  double getAmountWithoutTax(){
    return null;
  }
}