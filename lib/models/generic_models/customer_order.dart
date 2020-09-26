import 'package:food_app/models/objects/item.dart';

class CustomerOrder {
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

  List<Item> get itemList => _itemList;

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
    Item newInstance = new Item.fromItem(item);
    if (itemList.length == 0) {
      itemList.add(newInstance);
    } else {
      for (int i = 0; i <= itemList.length; i++) {
        if (i < itemList.length && itemList[i].code == newInstance.code) {
          itemList.add(newInstance);
          break;
        }
        // IF THE ABOVE BREAK IS NOT TRIGGERED ON THE LAST LOOP CYCLE
        // THAT IS CONSIDERED AS A NEW PRODUCT AND THEREFORE THE IF STATEMENT
        // WILL AND THE PRODUCT AS NEW PRODUCT
        if (i == itemList.length) {
          itemList.add(newInstance);
          break;
        }
      }
    }
  }

  void removeItem(Item item) {
    _itemList.remove(item);
  }

  double getOrderAmount() {
    double orderAmount = 0;
    _itemList.forEach((item) {
      orderAmount =
          orderAmount + double.parse(item.salePrice) * int.parse(item.quantity);
    });
    return orderAmount;
  }

  double getTotalAmount() {
    return null;
  }

  double getAmountWithDiscount() {
    return null;
  }

  double getAmountWithoutTax() {
    return null;
  }
}
