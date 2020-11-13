import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:food_app/database/table_object/sales_detail_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/services/common.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
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
      log('Responding', name: 'Order Service : ${Config.getCurrentTime()}');
      List<Map<String, dynamic>> masterRows = await _db.query(
          SalesMasterTable.tableName,
          where:
              '${SalesMasterTable.isUpload} = ? and ${SalesMasterTable.orderStatus} = ?',
          whereArgs: ['0', '3']); // GETTING ORDERS FOR UPLOAD FROM DATABASE
      for (int i = 0; i < masterRows.length; i++) {
        SalesMaster salesMaster = SalesMaster.fromJson(masterRows[i]);

        List<Map<String, dynamic>> detailRows = await _db.query(
            SalesDetailTable.tableName,
            where: '${SalesDetailTable.salesMasterId} = ?',
            whereArgs: [salesMaster.localId]);

        List<Map<String, dynamic>> details = [];
        detailRows.forEach(
            (element) => details.add(Map<String, dynamic>.from(element)));
        details.forEach((element) => element.remove(SalesDetailTable.isUpload));

        List<Map<String, dynamic>> masterJson = [];

        Map<String, dynamic> map = salesMaster.getValuesForUpload();
        map.remove(SalesMasterTable.shift);
        map.remove(SalesMasterTable.isDelete);
        map.remove(SalesMasterTable.isUpload);
        map['sale_details'] = details;
        masterJson.add(map);
        Map<String, dynamic> json = {
          'user_id': Config.currentUser.serverId,
          'json': jsonEncode(masterJson)
        };
        Response response = await post(Config.addUpdateOrderApi, body: json)
            .timeout(Duration(seconds: 5), onTimeout: () => null);
        log(response.body, name: 'Order Service');
        if (response != null) {
          Map<String, dynamic> result = jsonDecode(response.body);
          bool status = result['status'];
          if (status) {
            List<dynamic> y = result['orders_synced'];
            String id = y[0]['id'].toString();
            await _db.update(SalesMasterTable.tableName,
                {SalesMasterTable.isUpload: '1', SalesMasterTable.serverId: id},
                where: '${SalesMasterTable.localId} = ?',
                whereArgs: [salesMaster.localId]);
          } else {
            if(result['message'].toString().contains('Customer does not exist')){
              List<Customer> listCustomer = await Customer().getCustomerById(_db, int.parse(salesMaster.customerId));
              await Lib.uploadCustomer(listCustomer[0]) ? log('Customer uploaded Successfully', name: 'Order Service', time: DateTime.now()) : log('Customer upload unsuccessful', name: 'Order Service', time: DateTime.now());
            }
            log(json.toString(), name: 'Order Service', time: DateTime.now());
          }
        }
      }
      return true;
    } catch (e) {
      log('Error occured on Order Service',
          name: 'Order Service', time: DateTime.now(), error: e);
      return true;
    }
  }
}
