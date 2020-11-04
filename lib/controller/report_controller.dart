import 'package:flutter/material.dart';
import 'package:food_app/database/table_object/sales_detail_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/report_model.dart';
import 'package:food_app/pages/report_screen.dart';
import 'package:food_app/shared/config.dart';

class ReportController{
  ReportModel reportModel;

  ReportController(){
    reportModel = ReportModel();
    reportModel.salesMaster =   SalesMaster();
    reportModel.listOfSalesMasterForSlip = [];
    reportModel.listOfSalesMasterForSale = [];
    reportModel.listOfSalesDetails = [];
    reportModel.viewType = 1;
    getSalesMasterTable().whenComplete(() => print('Done'));
    reportModel.isDuplicateSlipView = false;
    reportModel.isReportView = false;
    reportModel.fromDate = 'Tap to select date';
    reportModel.toDate = 'Tap to select date';
    reportModel.totalDiscount = 0.0;
    reportModel.totalPaidAmount = 0.0;
    reportModel.totalSubTotal = 0.0;
  }

  launch(BuildContext context) => Navigator.of(context).push(
    new MaterialPageRoute(builder: (context) => new ReportScreen(model: reportModel,)));

  static Future<List<Map<String, dynamic>>> getSalesDetailsList(int id) async{
    List<Map<String, dynamic>> map = await Config.database
        .rawQuery('SELECT * FROM ${SalesDetailTable.tableName} WHERE ${SalesDetailTable.salesMasterId} = $id');
    return map;
  }

  Future getSalesMasterTable() async {
    List<Map<String, dynamic>> map = await Config.database.query(SalesMasterTable.tableName);
    map.forEach((element) => reportModel.listOfSalesMasterForSlip.add(SalesMaster.fromJson(element)));
    reportModel.listOfSalesMasterForSlip.forEach((element) => print('${element.saleNo}\n'));
  }


}