import 'package:food_app/models/objects/item.dart';

class CustomerOrder {
  List<Item> _itemList = [];
  String _tableNo, _orderType, _discount, _salesTax, _customerId, _tableId, _waiterId, _noOfPersons;

  get noOfPersons => _noOfPersons;

  set noOfPersons(value) {
    _noOfPersons = value;
  }

  get tableId => _tableId;

  set tableId(value) {
    _tableId = value;
  }

  get customerId {
    if (_customerId == null) _customerId = '1';
    return _customerId;
  }

  set customerId(value) {
    _customerId = value;
  }

  get tableNo => _tableNo;
  set tableNo(value) => _tableNo = value;

  get orderType => _orderType;
  set orderType(value) => _orderType = value;

  get salesTax {
    if (_salesTax == null) _salesTax = '0.0';
    return _salesTax;
  }

  set salesTax(value) => _salesTax = value;

  get discount {
    if (_discount == null) _discount = '0.0';
    return _discount;
  }

  set discount(value) => _discount = value;

  List<Item> get itemList => _itemList;
  set setItemList(List<Item> value) => _itemList = value;


  void addItem(Item item) {
    if (!this._itemList.contains(item)) {
      this._itemList.add(item);
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

  void resetQty(){
    this._itemList.forEach((element) {
      if(int.tryParse(element.quantity) > 1){
        element.quantity = 1.toString();
      }
    });
  }

  void removeItem(Item item) {
    _itemList.remove(item);
  }

  double getSubTotal() {
    double subTotalAmount = 0;
    _itemList.forEach((item) {
      subTotalAmount = subTotalAmount +
          double.parse(item.salePrice) * int.parse(item.quantity);
    });
    return subTotalAmount;
  }

  double getNetAmount() {
    double netAmount = 0;
    netAmount =
        getSubTotal() + double.parse(salesTax) - double.parse(discount) ?? 0;
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

  int totalItem() {
    int totalItem = 0;
    _itemList.forEach((items) {
      totalItem += int.parse(items.quantity);
    });
    return totalItem;
  }

  get waiterId => _waiterId;

  set waiterId(value) {
    _waiterId = value;
  }
}
