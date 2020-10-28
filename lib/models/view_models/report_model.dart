import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';

class ReportModel{

  SalesMaster salesMaster;
  List<SalesMaster> listOfSalesMaster;
  List<SalesDetails> listOfSalesDetails;
  int viewType;
}