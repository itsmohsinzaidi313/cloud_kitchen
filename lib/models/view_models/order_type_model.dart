import 'package:food_app/models/objects/table.dart' as t;
import 'package:food_app/models/objects/user.dart';

class OrderTypeModel{

  String errorMsg;
  int customerId;
  int listLength;
  bool customerExists;
  bool takeawaySearchButton;
  bool deliverySearchButton;
  bool isWaiterSelected;
  t.Table table;
  User waiter;
  List<t.Table> tables;
  List<t.Table> listTables;
  List<User> listWaiters;
}
