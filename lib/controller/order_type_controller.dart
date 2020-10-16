import 'package:flutter/material.dart';
import 'package:food_app/database/table_object/orders_table.dart';
import 'package:food_app/database/table_object/tables_table.dart';
import 'package:food_app/models/objects/table.dart' as T;
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
    getTables(Config.database)
        .then((value) => model.listTables = value);
    model.listWaiters = DataLists.instance.listUsers
        .where((element) => element.designation == 'Waiter')
        .toList();
  }

  launch(BuildContext context) => Navigator.push(
      context, new MaterialPageRoute(builder: (context) => OrderTypeScreen(model)));

  Future<List<T.Table>> getTables(Database db) async {
    List<T.Table> listTables = [];
    List<Map<String, dynamic>> map = await db.query(TablesTable.tableName);
    map.forEach((element) async {
      T.Table table = new T.Table.fromJson(element);
      table.delStatus = await getTableDelStatus(db, table.serverId);
      listTables.add(table);
    });
    return listTables;
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
