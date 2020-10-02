import 'package:food_app/models/generic_models/customer_order.dart';
import 'package:food_app/models/objects/category.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/sales_master.dart';

class NewSaleModel {
  List<Category> lstCategory;
  SalesMaster salesMaster;
  List<Item> lstItem;
  String categoryName;
  CustomerOrder order;
  String leadingString;
  String titleString;
  String trailingString;
}
