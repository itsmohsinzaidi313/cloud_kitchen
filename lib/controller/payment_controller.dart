import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/payment_view_model.dart';
import 'package:food_app/pages/payment_screen.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:http/http.dart';

class PaymentController {
  PaymentViewModel model;
  PaymentController(Map<String, dynamic> map) {
    model = new PaymentViewModel();
    model.paymentMethodList = DataLists.instance.listPaymentMethods;
    model.map = map;
  }

  void launch(BuildContext context) => Navigator.of(context)
      .push(new MaterialPageRoute(builder: (context) => PaymentScreen(model)));

  static dynamic uploadOrder(Map<String, dynamic> element) async {
    Config.database.update(
        Tables.salesMaster,
        {
          Columns.salesMaster[30]: '3',
          Columns.salesMaster[5]: element[Columns.salesMaster[6]]
        },
        where: '${Columns.salesMaster[0]} = ?',
        whereArgs: [element[Columns.salesMaster[0]]]);
    Map<String, dynamic> values =
        new SalesMaster.fromJson(element).getValuesForUpload();
    List<Map<String, dynamic>> values1 = [];
    //COLUMNS
    List<Map<String, dynamic>> values2 = await Config.database.query(
        Tables.salesDetails,
        columns: Columns.salesDetails
            .getRange(1, Columns.salesDetails.length - 1)
            .toList(),
        where: '${Columns.salesDetails[18]} = ?',
        whereArgs: [new SalesMaster.fromJson(element).remoteId]);
    values['sale_details'] = values2;
    values1.add(values);
    Map<String, dynamic> json = new Map();
    json['user_id'] = '1';
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
            Tables.salesMaster, {'${Columns.salesMaster[35]}': '$id'},
            where: '${Columns.salesMaster[0]} = ?', whereArgs: [remoteId]);
      }
    } else {
      log('Response Timeout', name: 'Request Timeout');
    }
  }
}
