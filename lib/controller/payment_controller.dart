import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/database/table_object/sales_detail_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/payment_view_model.dart';
import 'package:food_app/pages/payment_screen.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:http/http.dart';

class PaymentController {
  PaymentViewModel model;
  PaymentController(SalesMaster salesMaster/*Map<String, dynamic> map*/) {
    model = new PaymentViewModel();
    model.paymentMethodList = DataLists.instance.listPaymentMethods;
    /*model.map = map;*/
    model.salesMaster = salesMaster;
  }

  void launch(BuildContext context) => Navigator.of(context)
      .push(new MaterialPageRoute(builder: (context) => PaymentScreen(model)));

  static dynamic uploadOrder(Map<String, dynamic> element) async {
    Config.database.update(
        SalesMasterTable.tableName,
        {
          SalesMasterTable.orderStatus: '3',
          SalesMasterTable.paidAmount: element[SalesMasterTable.dueAmount]
        },
        where: '${SalesMasterTable.localId} = ?',
        whereArgs: [element[SalesMasterTable.localId]]);

    Map<String, dynamic> values =
        new SalesMaster.fromJson(element).getValuesForUpload();
    List<Map<String, dynamic>> values1 = [];
    //COLUMNS
    List<Map<String, dynamic>> values2 = await Config.database.query(
        SalesDetailTable.tableName,
        columns: SalesDetailTable.columnsName
            .getRange(1, SalesDetailTable.columnsName.length - 1)
            .toList(),
        where: '${SalesDetailTable.salesMasterId} = ?',
        whereArgs: [new SalesMaster.fromJson(element).localId]);
    values[SalesDetailTable.tableName] = values2;
    values1.add(values);
    Map<String, dynamic> json = new Map();
    json[SalesDetailTable.userId] = '1';
    json['json'] = jsonEncode(values1);
    log(
      json.toString(),
      name: 'Order Upload Json: ',
    );
    Response response =
        await post(Config.addUpdateOrderApi, body: json).timeout(
      Duration(seconds: 5),
      onTimeout: () => null,
    );
    if (response != null) {
      log(response.body, name: 'Server Response: ');
      Map<String, dynamic> x = jsonDecode(response.body);
      if (x['status']) {
        List<dynamic> y = x['orders_synced'];
        String id = y[0]['id'];
        String remoteId = y[0]['remote_id'];
        Config.database.update(
            SalesMasterTable.tableName, {'${SalesMasterTable.serverId}': '$id'},
            where: '${SalesMasterTable.localId} = ?', whereArgs: [remoteId]);
      }
    } else {
      log('Response Timeout', name: 'Request Timeout');
    }
  }

  static double getDiscount(double totalAmount, double discount) {
    double res = totalAmount - discount;
    return res;
  }

  static double getDiscountByPercentage(double totalAmount, double percentage){
    double res = totalAmount * (percentage / 100);
    return res;
  }

  static double getAmountWithTax (double totalAmount, double tax){
    double res = (totalAmount + (tax * totalAmount)/100);
    return res;
  }
}
