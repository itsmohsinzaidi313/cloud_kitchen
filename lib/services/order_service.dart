import 'dart:convert';

import 'package:food_app/database/table_object/sales_detail_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/services/common.dart';
import 'package:food_app/shared/config.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class OrderService extends ServiceCommon {
  static final OrderService orderService =
      OrderService._instance(Config.database);

  Database _db;
  OrderService._instance(this._db) {
    initiate();
  }
  @override
  Future<bool> perform() async {
    try {
      List<Map<String, dynamic>> masterRows = await _db.query(
          SalesMasterTable.tableName,
          where: '${SalesMasterTable.isUpload} = ? and ${SalesMasterTable.orderStatus} = ?',
          whereArgs: ['0', '3']); // GETTING ORDERS FOR UPLOAD FROM DATABASE
      for (int i = 0; i < masterRows.length; i++) {
        SalesMaster salesMaster = SalesMaster.fromJson(masterRows[i]);

        List<Map<String, dynamic>> detailRows = await _db.query(
            SalesDetailTable.tableName,
            where: '${SalesDetailTable.salesMasterId} = ?',
            whereArgs: [salesMaster.remoteId]);

        Map<String, dynamic> masterJson = masterRows[i];
        masterJson['sale_details'] = detailRows;

        Map<String, dynamic> json = {
          'user_id': Config.currentUser.serverId,
          'json': jsonEncode(masterJson)
        };
        Response response = await post(Config.addUpdateOrderApi, body: json)
            .timeout(Duration(seconds: 5), onTimeout: () => null);
        if (response != null) {
          Map<String, dynamic> result = jsonDecode(response.body);
          bool status = result['status'];
          if (status) {
            List<dynamic> y = result['orders_synced'];
            String id = y[0]['id'].toString();
            _db.update(SalesMasterTable.tableName,
                {SalesMasterTable.isUpload: '1', SalesMasterTable.serverId: id},
                where: '${SalesMasterTable.localId} = ?',
                whereArgs: [salesMaster.remoteId]);
          }
        }
      }
      return true;
    } catch (e) {
      return true;
    }
  }
}
