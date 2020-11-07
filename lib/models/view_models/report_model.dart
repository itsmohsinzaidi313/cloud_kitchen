import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';

class ReportModel{

  SalesMaster salesMaster;
  List<SalesMaster> listOfSalesMasterForSlip, listOfSalesMasterForSale;
  List<SalesDetails> listOfSalesDetails;
  int viewType;
  bool isDuplicateSlipView, isReportView;
  String fromDate, toDate;
  double totalDiscount, totalPaidAmount, totalSubTotal;
}