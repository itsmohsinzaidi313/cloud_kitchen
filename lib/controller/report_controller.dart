import 'package:flutter/material.dart';
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
    reportModel.listOfSalesMaster = [];
    getSalesMasterTable().whenComplete(() => print('Done'));
  }

  launch(BuildContext context) => Navigator.of(context).push(
    new MaterialPageRoute(builder: (context) => new ReportScreen(model: reportModel,)));

  Future getSalesMasterTable() async{
    List<Map<String, dynamic>> map = await Config.database.query(SalesMasterTable.tableName);
    map.forEach((element) => reportModel.listOfSalesMaster.add(SalesMaster.fromJson(element)));
    reportModel.listOfSalesMaster.forEach((element) => print('${element.saleNo}\n'));
  }
}