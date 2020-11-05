import 'package:flutter/material.dart';
import 'package:food_app/database/table_object/sales_detail_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/report_model.dart';
import 'package:food_app/pages/report_screen.dart';
import 'package:food_app/shared/config.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportController {
  ReportModel reportModel;

  static const List<String> _duplicateSlipDataColumnList = [
    'Name',
    'Unit Price',
    'Qty',
    'Total Price'
  ];

  static const List<String> _reportDataColumnList = [
    'Date',
    'Paid Amount',
    'Sub Total',
    'Discount'
  ];

  ReportController() {
    reportModel = ReportModel();
    reportModel.salesMaster = SalesMaster();
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

  launch({BuildContext context}) =>
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new ReportScreen(
                model: reportModel,
              )));

  static Future<List<Map<String, dynamic>>> getSalesDetailsList(
      {int id}) async {
    List<Map<String, dynamic>> map = await Config.database.rawQuery(
        'SELECT * FROM ${SalesDetailTable.tableName} WHERE ${SalesDetailTable.salesMasterId} = $id');
    return map;
  }

  Future getSalesMasterTable() async {
    List<Map<String, dynamic>> map =
        await Config.database.query(SalesMasterTable.tableName);
    map.forEach((element) => reportModel.listOfSalesMasterForSlip
        .add(SalesMaster.fromJson(element)));
    reportModel.listOfSalesMasterForSlip
        .forEach((element) => print('${element.saleNo}\n'));
  }

  static Widget getDuplicateSlipButton({BuildContext context}) {
    return Container(
      width: Config.getDeviceWidth(context) * 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.copy_rounded,
            size: 60,
            color: Colors.red,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Duplicate\nReport',
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntuCondensed(
              color: Colors.grey.shade700,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  static Widget getGenerateReportButton({BuildContext context}) {
    return Container(
      // height: Config.getDeviceHeight(context) * 0.4,
      width: Config.getDeviceWidth(context) * 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.trending_up,
            size: 60,
            color: Colors.red,
          ),
          Text(
            'My\nSales',
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntuCondensed(
              color: Colors.grey.shade700,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  static Widget getDateButtonLabel({String labelText}) {
    return Text(
      '$labelText: ',
      style: GoogleFonts.ubuntuCondensed(
        color: Colors.grey.shade600,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.0,
        wordSpacing: 1.0,
      ),
    );
  }

  static Widget row({SalesMaster item}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.saleNo,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              letterSpacing: 1.0,
              wordSpacing: 1.0,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  static Widget getDateSearchIconButton({Function onPressed}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent,
      ),
      child: IconButton(
        icon: Icon(
          Icons.search_rounded,
        ),
        iconSize: 22,
        // color: Colors.white,
        color: Colors.white,
        tooltip: 'Search',
        onPressed: onPressed,
      ),
    );
  }

  static Widget getDivider() {
    return Divider(
      thickness: 2,
      color: Colors.grey[400],
    );
  }

  static Widget getDataListRowBoldText({String element}) {
    return Text(
      element,
      style: GoogleFonts.ubuntu(
        color: Colors.black87,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        wordSpacing: 0.5,
      ),
    );
  }

  static Widget getDataListRowNormalText({String element}) {
    return Text(
      element,
      style: GoogleFonts.ubuntu(
        color: Colors.black87,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        // letterSpacing: 1.0,
        wordSpacing: 0.5,
      ),
    );
  }

  static Widget getDataColumnText({String element}) {
    return Text(
      element,
      style: TextStyle(
        fontStyle: FontStyle.italic,
        color: Colors.yellow[800],
        fontWeight: FontWeight.normal,
      ),
    );
  }

  static Widget getTextWithBackground({String text, Color color}) {
    return Text(
      text,
      style: GoogleFonts.ubuntuCondensed(
        color: color == null ? Colors.grey.shade600 : color,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 2.0,
        wordSpacing: 1.0,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  static List<DataRow> getDuplicateSlipDataRowList(
      {List<SalesDetails> listOfSalesDetails}) {
    List<DataRow> rows = [];
    listOfSalesDetails.forEach((element) {
      rows.add(DataRow(cells: <DataCell>[
        DataCell(
          getDataListRowBoldText(
            element: element.menuName,
          ),
        ),
        DataCell(
          getDataListRowNormalText(
            element: element.menuUnitPrice,
          ),
        ),
        DataCell(
          getDataListRowNormalText(
            element: element.qty,
          ),
        ),
        DataCell(
          getDataListRowNormalText(
            element:
                '${double.parse(element.menuUnitPrice) * double.parse(element.qty)}',
          ),
        ),
      ]));
    });
    return rows;
  }

  static List<DataRow> getReportDataRowList(
      {List<SalesMaster> listOfSalesMaster}) {
    List<DataRow> rows = [];
    listOfSalesMaster.forEach((element) {
      rows.add(
        DataRow(cells: <DataCell>[
          DataCell(
            getDataListRowBoldText(
              element: element.dateTime,
            ),
          ),
          DataCell(
            getDataListRowNormalText(
              element: element.paidAmount,
            ),
          ),
          DataCell(
            getDataListRowNormalText(
              element: element.subTotalWithDiscount,
            ),
          ),
          DataCell(
            getDataListRowNormalText(
              element: element.totalDiscountAmount,
            ),
          ),
        ]),
      );
    });
    return rows;
  }

  static List<DataColumn> getDataColumnList(
      {List<String> columnNames}) {
    List<DataColumn> columns = [];
    columnNames.forEach((element) {
      columns.add(DataColumn(
        label: getDataColumnText(element: element),
      ));
    });
    return columns;
  }


  static Widget getDuplicateSlipView(
      {BuildContext context,
      bool view,
      List<SalesDetails> list,
      SalesMaster salesMaster}) {
    switch (view) {
      case true:
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTextWithBackground(text: 'Order No: '),
                  Text(
                    salesMaster.saleNo,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTextWithBackground(text: 'Date:'),
                  Text(
                    salesMaster.saleDate,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              DataTable(
                showBottomBorder: true,
                dataRowHeight: 25,
                columns: getDataColumnList(
                    columnNames: _duplicateSlipDataColumnList),
                rows: getDuplicateSlipDataRowList(listOfSalesDetails: list),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTextWithBackground(text: 'Amount:'),
                  Text(
                    'Rs. ${salesMaster.subTotal}/=',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTextWithBackground(text: 'Discount:'),
                  Text(
                    'Rs. ${salesMaster.totalDiscountAmount}/=',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              getDivider(),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey[200],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTextWithBackground(
                        text: 'Net Amount:', color: Colors.black),
                    Text(
                      'Rs. ${salesMaster.paidAmount}/=',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              getDivider(),
            ],
          ),
        );
        break;

      default:
        return Container();
        break;
    }
  }

  static Widget getReportView({BuildContext context, bool view, List<SalesMaster> list, String totalSubTotal, String totalDiscount, String totalPaidAmount}) {
    switch (view) {
      case true:
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DataTable(
                showBottomBorder: true,
                dataRowHeight: 25,
                columns: getDataColumnList(columnNames: _reportDataColumnList),
                rows: getReportDataRowList(listOfSalesMaster: list),
              ),
              SizedBox(
                height: 20
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTextWithBackground(
                    text: 'Total Sub Total: '
                  ),
                  Text(
                    'Rs. ${totalSubTotal.toString()}/=',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                height: 10
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTextWithBackground(
                      text: 'Total Discount: '
                  ),
                  Text(
                    'Rs. ${totalDiscount.toString()}/=',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              getDivider(),
              SizedBox(
                height: 5
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey[200],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTextWithBackground(
                        text: 'Total Paid Amount: ',
                      color: Colors.black
                    ),
                    Text(
                      'Rs. ${totalPaidAmount.toString()}/=',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              getDivider(),
            ],
          ),
        );
        break;

      default:
        return Container();
        break;
    }
  }
}
