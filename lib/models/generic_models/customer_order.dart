import 'package:food_app/models/objects/item.dart';

class CustomerOrder {

  List<Item> _itemList = [];
  String _tableNo, _orderType, _discount, _salesTax, _customerId;

  get customerId => _customerId;
  set customerId(value) {
    _customerId = value;
  }

  get tableNo => _tableNo;
  set tableNo(value) => _tableNo = value;

  get orderType => _orderType;
  set orderType(value) => _orderType = value;

  get salesTax => _salesTax;
  set salesTax(value) => _salesTax = value;

  get discount => _discount;
  set discount(value) => _discount = value;

  List<Item> get itemList => _itemList;
  set setItemList(List<Item> value) => _itemList = value;

  void less(Item item) {
    if (itemList.length > 0) {
      for (int i = 0; i < itemList.length; i++) {
        String prodId = itemList[i].code;
        if (prodId == item.code) {
          int productQty = int.parse(itemList[i].quantity);
          if ((productQty - int.parse(itemList[i].quantity)) >= 0) {
            itemList[i].less();
          }
          break;
        }
      }
    }
  }

  void addItem(Item item) {
    if (!this.itemList.contains(item)) {
      this.itemList.add(item);
    } else {
      String qty = this
          .itemList
          .where((element) => element.code == item.code)
          .toList()[0]
          .quantity;
      int qty2 = int.parse(qty);
      qty2++;
      this
          .itemList
          .where((element) => element.code == item.code)
          .toList()[0]
          .quantity = qty2.toString();
    }
  }

  void removeItem(Item item) {
    _itemList.remove(item);
  }

  double getSubTotal() {
    double subTotalAmount = 0;
    _itemList.forEach((item) {
      subTotalAmount =
          subTotalAmount + double.parse(item.salePrice) * int.parse(item.quantity);
    });
    return subTotalAmount;
  }

  double getNetAmount() {
    double netAmount = 0;
    netAmount = getSubTotal() + salesTax - discount ?? 0;
    return netAmount;
  }

  double getAmountWithoutDiscount() {
    double withoutDiscount = 0;
    withoutDiscount = getSubTotal() + salesTax;
    return withoutDiscount;
  }

  double getAmountWithoutTax() {
    double withoutTax = 0;
    withoutTax = getSubTotal() - discount ?? 0;
    return withoutTax;
  }

  int totalItem(){
    int totalItem = 0;
    _itemList.forEach((items) {
      totalItem += int.parse(items.quantity);
    });
    return totalItem;
  }
}
