import 'package:flutter/material.dart';
import 'package:food_app/database/table_object/orders_table.dart';
import 'package:food_app/database/table_object/tables_table.dart';
import 'package:food_app/database/table_object/user_table.dart';
import 'package:food_app/models/objects/table.dart' as T;
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/view_models/order_type_model.dart';
import 'package:food_app/pages/order_type_screen.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:sqflite/sqflite.dart';

class OrderTypeController {
  OrderTypeModel model;

  OrderTypeController() {
    model = new OrderTypeModel();
    model.customerExists = true;
    model.customerId = 0;
    model.errorMsg = '';
    model.isWaiterSelected = false;
    model.takeawaySearchButton = false;
    model.deliverySearchButton = false;
    getTablesList(Config.database)
        .then((value) {
      if(value != null){
        model.listTables = value;
      }
    });
    getUsersList().then((value) {
      if(value != null){
        model.listWaiters = value.where((element) => element.designation == 'Waiter')
            .toList();
      }
    });

  }

  launch(BuildContext context) => Navigator.push(
      context, new MaterialPageRoute(builder: (context) => OrderTypeScreen(model)));

  Future<List<T.Table>> getTablesList(Database db) async {
    List<T.Table> listTables = [];
    List<Map<String, dynamic>> map = await db.query(TablesTable.tableName);
    map.forEach((element) async {
      T.Table table = new T.Table.fromJson(element);
      table.delStatus = await getTableDelStatus(db, table.serverId);
      listTables.add(table);
    });
    return listTables;
  }

  Future<List<User>> getUsersList() async{
    List<User> _users = [];
    List<Map<String, dynamic>> userMap = await Config.database.query(UserTable.tableName);
    if(userMap.length > 0){
      userMap.forEach((element) {
        _users.add(User.fromJson(element));
      });
    }
    return _users;
  }

  Future<String> getTableDelStatus(Database db, String tableId) async {
    String delStatus = TablesTable.FREE;
    List<Map<String, dynamic>> listMap = await db.rawQuery(
        "select ${OrdersTable.delStatus} from ${OrdersTable.tableName} where ${OrdersTable.tableId} = '$tableId' order by ${OrdersTable.localId} desc limit 1");
    if(listMap.isNotEmpty) {
      delStatus = listMap[0][OrdersTable.delStatus];
    }
    return delStatus;
  }
}
