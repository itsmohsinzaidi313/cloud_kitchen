import 'dart:convert';
import 'dart:developer';
import 'package:food_app/database/table_object/customer_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/services/common.dart';
import 'package:food_app/shared/config.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class CustomerService extends ServiceCommon{

  static final CustomerService customerService = CustomerService._instance(Config.database);
  Database _db;
  CustomerService._instance(this._db){
    initiate();
  }

  @override
  Future<bool> perform() async{
    try{

      log('Responding', name: 'Customer Service : ${Config.getCurrentTime()}');

      List<Map<String, dynamic>> customerRows = await _db.query(
          CustomerTable.tableName,
        where:'${CustomerTable.isUpload} = ?', whereArgs: ['0']
      );

      for (int i = 0; i < customerRows.length; i++){
        Customer customer = Customer.fromJson(customerRows[i]);

        Map<String, dynamic> data = new Map<String, dynamic>();
        List<Map<String, dynamic>> map = [];

        map.add({
          'remote_id': customer.remoteId,
          'name': customer.name,
          'phone': customer.phone,
          'address': customer.address,
          'device_key': Config.currentDevice.deviceKey,
          'user_id': customer.userId,
          'company_id': Config.currentDevice.companyId,
          'outlet_id': Config.currentDevice.outletId
        });

        data['user_id'] = Config.currentUser.serverId;
        data['json'] = jsonEncode(map);
        print(data);
        print(Config.customerUploadApi);
        Response response = await post(Config.customerUploadApi, body: data)
            .timeout(Duration(seconds: 5), onTimeout: () => null);
        if (response != null) {
          Config.log.i(response.body);
          Map<String, dynamic> result = jsonDecode(response.body);
          List<dynamic> x = result['customers_synced'];
          print('ID: ${x[0]['id']}\n SERVER ID: ${x[0]['remote_id']}');
          String id = x[0]['id'];
          String remoteId = x[0]['remote_id'];
          int y = await Config.database.update(
              CustomerTable.tableName, {'${CustomerTable.serverId}': id, '${CustomerTable.isUpload}': '1'},
              where: '${CustomerTable.localId} = ?', whereArgs: [remoteId]);
          if(y > 0){
              print('Customer and SalesMaster Tables updated successfully..');
          }
        }
      }
      return true;
    } catch(e){
      log('Error occurred in Customer Service', name: 'Customer Service', time: DateTime.now(), error: e);
      return true;
    }
  }

}