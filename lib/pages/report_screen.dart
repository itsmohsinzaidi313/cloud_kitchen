import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controller/report_controller.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/report_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  ReportModel model;

  ReportScreen({this.model});

  @override
  _ReportScreenState createState() => _ReportScreenState(this.model);
}

class _ReportScreenState extends State<ReportScreen> {
  AutoCompleteTextField autoCompleteTextField;
  GlobalKey<AutoCompleteTextFieldState<SalesMaster>> key = GlobalKey();
  ReportModel model;
  bool isDuplicateSlipView = false, isReportView = false;
  String fromDate = 'Tap to select date', toDate = 'Tap to select date';
  double totalDiscount = 0.0, totalPaidAmount = 0.0, totalSubTotal = 0.0;

  _ReportScreenState(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.appBarNormal(
          context: context,
          appBarBgColor: AppTheme.appBarColor,
          appBarElevation: 0.0,
          appBarTitle: 'Reports'),
      body: Container(
        height: Config.getDeviceHeight(context),
        width: Config.getDeviceWidth(context),
        color: Colors.grey[300],
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  height: Config.getDeviceHeight(context) * 0.85,
                  width: Config.getDeviceWidth(context) * 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 3,
                          child: InkWell(
                            onTap: () => setState(() {
                              model.viewType = 1;
                              isReportView = false;
                            }),
                            child: Container(
                              // height: Config.getDeviceHeight(context) * 0.4,
                              width: Config.getDeviceWidth(context) * 1.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.copy_rounded,
                                    size: 60,
                                    color: Colors.redAccent.shade200,
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
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 3,
                          child: InkWell(
                            onTap: () => setState(() {
                              model.viewType = 2;
                              isDuplicateSlipView = false;
                            }),
                            child: Container(
                              // height: Config.getDeviceHeight(context) * 0.4,
                              width: Config.getDeviceWidth(context) * 1.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    size: 60,
                                    color: Colors.redAccent.shade200,
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Container(
                  height: Config.getDeviceHeight(context),
                  width: Config.getDeviceWidth(context),
                  child: Column(
                    children: [
                      // !isDuplicateSlipView
                      //     ? Container()
                      //     :
                      Expanded(
                        flex: 1,
                        child: getView(model.viewType),
                      ),
                      model.viewType == 1 ? Expanded(
                        flex: 4,
                        // flex: !isDuplicateSlipView ? 1 : 4,
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Container(
                            width: Config.getDeviceWidth(context) * 0.9,
                            height: Config.getDeviceHeight(context),
                            padding: EdgeInsets.all(8.0),
                            margin: EdgeInsets.only(
                              bottom: 60,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: duplicateSlip(isDuplicateSlipView,
                                model.listOfSalesDetails, model.salesMaster),
                          ),
                        ),
                      ) : Expanded(
                        flex: 4,
                        // flex: !isDuplicateSlipView ? 1 : 4,
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Container(
                            width: Config.getDeviceWidth(context) * 0.9,
                            height: Config.getDeviceHeight(context),
                            padding: EdgeInsets.all(8.0),
                            margin: EdgeInsets.only(
                              bottom: 60,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: reportView(isReportView),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getView(int viewType) {
    switch (viewType) {
      case 1:
        return Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(
            right: 5,
            top: 4,
            bottom: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: autoCompleteTextField =
                          AutoCompleteTextField<SalesMaster>(
                        clearOnSubmit: false,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search Sale',
                          contentPadding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        keyboardType: TextInputType.number,
                        itemSubmitted: (item) {
                          setState(() {
                            model.salesMaster = item;
                            autoCompleteTextField.textField.controller.text =
                                item.saleNo;
                            print(
                                '${autoCompleteTextField.textField.controller.text}');
                          });
                        },
                        key: key,
                        suggestions: model.listOfSalesMaster,
                        itemBuilder: (context, item) {
                          return row(item);
                        },
                        itemFilter: (item, query) {
                          return item.saleNo.toLowerCase().startsWith(
                              Lib.codeGenerator('ORD', int.parse(query))
                                  .toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.saleNo.compareTo(b.saleNo);
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search_rounded),
                    color: Colors.grey,
                    onPressed: () {
                      model.listOfSalesDetails.clear();
                      int id = int.parse(model.salesMaster.localId);
                      ReportController.getSalesDetailsList(id).then((value) {
                        if(value != null){
                          value.forEach((element) {
                            model.listOfSalesDetails
                                .add(SalesDetails.fromJson(element));
                          });
                        } else{
                          print('Sales Details Contains Nothing');
                        }
                      }).whenComplete(() {
                        setState(() {
                          isDuplicateSlipView = true;
                          isReportView = false;
                        });
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
        break;

      case 2:
        return Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(
            right: 5,
            top: 4,
            bottom: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text('From: '),
                  RaisedButton(
                    color: Colors.white,
                    textColor: Colors.yellow.shade800,
                    elevation: 0.0,
                    onPressed: () async {
                      fromDate = await _selectDate(
                          context: context,
                          selectedDate: DateTime.now(),
                          firstDate: DateTime(2000, 1, 1));
                      fromDate =
                          Config.convertDateTimeToDate(DateTime.parse(fromDate))
                              .toString();
                      print('From DATE: $fromDate');
                    },
                    child: Text(
                      fromDate.contains('Tap')
                          ? fromDate
                          : DateFormat('EEE, MMM d, ' 'yy').format(
                              DateTime.parse(fromDate),
                            ),
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('To: '),
                  RaisedButton(
                    color: Colors.white,
                    textColor: Colors.yellow.shade800,
                    elevation: 0.0,
                    onPressed: () async {
                      toDate = await _selectDate(
                          context: context,
                          selectedDate:
                              DateTime.parse(fromDate).add(Duration(days: 1)),
                          firstDate:
                              DateTime.parse(fromDate).add(Duration(days: 1)));
                      setState(() {
                        toDate =
                            Config.convertDateTimeToDate(DateTime.parse(toDate))
                                .toString();
                      });
                    },
                    child: Text(
                      toDate.contains('Tap')
                          ? toDate
                          : DateFormat('EEE, MMM d, ' 'yy').format(
                              DateTime.parse(toDate),
                            ),
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              Material(
                child: IconButton(
                  icon: Icon(
                    Icons.search_rounded,
                  ),
                  iconSize: 30, // color: Colors.white,
                  color: Colors.redAccent,
                  tooltip: 'Search',
                  onPressed: () {
                    model.listOfSalesMaster.clear();
                    // totalDiscount = 0.0;
                    // totalPaidAmount = 0.0;
                    // totalSubTotal = 0.0;
                    model.salesMaster.getSalesByDate(fromDate, toDate).then((value) {
                      if(value != null){
                        value.forEach((element) {
                          model.listOfSalesMaster.add(element);
                          totalDiscount += double.parse(element.totalDiscountAmount);
                          totalSubTotal += double.parse(element.subTotalWithDiscount);
                          totalPaidAmount += double.parse(element.paidAmount);
                        });
                      } else{
                        print('Sales Master List Contains Nothing');
                      }
                    }).whenComplete(() {
                      setState(() {
                        isReportView = true;
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        );
        break;
      default:
        return Container();
        break;
    }
  }

  Widget duplicateSlip(
      bool view, List<SalesDetails> list, SalesMaster salesMaster) {
    switch (view) {
      case true:
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DataTable(
                dividerThickness: 0.0,
                showBottomBorder: true,
                dataRowHeight: 20,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Name',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Unit Price',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Qty',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total Price',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: getSlipDataRowList(model.listOfSalesDetails),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Amount:'),
                  Text(
                    salesMaster.subTotal,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discount:'),
                  Text(
                    salesMaster.totalDiscountAmount,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Divider(
                thickness: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Net Amount:'),
                  Text(
                    salesMaster.subTotalWithDiscount,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      //
      // case false:
      //   return Container();
      //   break;

      default:
        return Container();
        break;
    }
  }

  Widget reportView(
      bool view) {
    switch (view) {
      case true:
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DataTable(
                dividerThickness: 0.0,
                showBottomBorder: true,
                dataRowHeight: 20,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Paid Amount',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Sub Total',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Discount',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: getReportDataRowList(model.listOfSalesMaster),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Paid Amount:'),
                  Text(
                    totalPaidAmount.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Sub Total:'),
                  Text(
                    totalSubTotal.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Discount:'),
                  Text(
                    totalDiscount.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
        );
        break;

      default:
        return Container();
        break;
    }
  }

  Future<String> _selectDate(
      {BuildContext context, DateTime selectedDate, DateTime firstDate}) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: DateTime(2100, 1, 1),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Colors.redAccent),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
    }
    return selectedDate.toString();
  }

  Widget row(SalesMaster item) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.saleNo,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ],
    );
  }

  List<DataRow> getSlipDataRowList(List<SalesDetails> listOfSalesDetails) {
    List<DataRow> rows = [];
    listOfSalesDetails.forEach((element) {
      rows.add(DataRow(cells: <DataCell>[
        DataCell(Text(element.menuName)),
        DataCell(Text(element.menuUnitPrice)),
        DataCell(Text(element.qty)),
        DataCell(Text(
            '${double.parse(element.menuUnitPrice) * double.parse(element.qty)}')),
      ]));
    });
    return rows;
  }

  List<DataRow> getReportDataRowList(List<SalesMaster> listOfSalesMaster) {
    List<DataRow> rows = [];
    listOfSalesMaster.forEach((element) {
      rows.add(DataRow(cells: <DataCell>[
        DataCell(Text(element.dateTime)),
        DataCell(Text(element.paidAmount)),
        DataCell(Text(element.subTotalWithDiscount)),
        DataCell(Text(element.totalDiscountAmount)),
      ]));
    });
    return rows;
  }
}
