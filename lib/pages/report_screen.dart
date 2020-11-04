import 'dart:math';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool isAutoCompleteTextEmpty = false;

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
                      model.viewType == 1
                          ? Expanded(
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
                                  child: duplicateSlip(
                                      isDuplicateSlipView,
                                      model.listOfSalesDetails,
                                      model.salesMaster),
                                ),
                              ),
                            )
                          : Expanded(
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
              Expanded(
                flex: 1,
                child: Row(
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
                            suffixIcon: IconButton(
                              icon: Icon(Icons.cancel),
                              iconSize: 25,
                              color: Colors.yellow[700],
                              onPressed: () {
                                autoCompleteTextField
                                    .textField.controller.text = '';
                              },
                            ),
                            contentPadding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          keyboardType: TextInputType.number,
                          itemSubmitted: (item) {
                            setState(() {
                              model.salesMaster = item;
                              autoCompleteTextField.textField.controller.text =
                                  item.saleNo;
                              model.listOfSalesDetails.clear();
                              int id = int.parse(model.salesMaster.localId);
                              ReportController.getSalesDetailsList(id)
                                  .then((value) {
                                if (value != null) {
                                  value.forEach((element) {
                                    model.listOfSalesDetails
                                        .add(SalesDetails.fromJson(element));
                                  });
                                } else {
                                  print('Sales Details Contains Nothing');
                                }
                              }).whenComplete(() {
                                setState(() {
                                  isDuplicateSlipView = true;
                                  isReportView = false;
                                });
                              });
                              print(
                                  '${autoCompleteTextField.textField.controller.text}');
                            });
                          },
                          key: key,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          suggestions: model.listOfSalesMasterForSlip,
                          itemBuilder: (context, item) {
                            return row(item);
                          },
                          itemFilter: (item, query) {
                            if (autoCompleteTextField
                                .textField.controller.text.isEmpty) query = '';
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
                  ],
                ),
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
                  Text(
                    'From: ',
                    style: GoogleFonts.ubuntuCondensed(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.0,
                      wordSpacing: 1.0,
                    ),
                  ),
                  RaisedButton(
                    color: Colors.grey[200],
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
                  Text(
                    'To: ',
                    style: GoogleFonts.ubuntuCondensed(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1.0,
                      wordSpacing: 1.0,
                    ),
                  ),
                  RaisedButton(
                    color: Colors.grey[200],
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
              Container(
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
                  onPressed: () {
                    if (!fromDate.contains('Tap') && !toDate.contains('Tap')) {
                      model.listOfSalesMasterForSale.clear();
                      totalDiscount = 0.0;
                      totalPaidAmount = 0.0;
                      totalSubTotal = 0.0;
                      model.salesMaster
                          .getSalesByDate(fromDate, toDate)
                          .then((value) {
                        if (value != null) {
                          value.forEach((element) {
                            model.listOfSalesMasterForSale.add(element);
                            totalDiscount +=
                                double.parse(element.totalDiscountAmount);
                            totalSubTotal +=
                                double.parse(element.subTotalWithDiscount);
                            totalPaidAmount += double.parse(element.paidAmount);
                          });
                        } else {
                          print('Sales List Contains Nothing');
                        }
                      }).whenComplete(() {
                        setState(() {
                          isReportView = true;
                        });
                      });
                    } else {
                      AppTheme.showAlertDialogOK(context,
                          title: 'Invalid Date Selected',
                          message:
                              'Please select valid date to generate report',
                          onOK: () => Navigator.pop(context));
                    }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order No: ',
                    style: GoogleFonts.ubuntuCondensed(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2.0,
                      wordSpacing: 1.0,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  Text(
                    salesMaster.saleNo,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date:',
                    style: GoogleFonts.ubuntuCondensed(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2.0,
                      wordSpacing: 1.0,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  Text(
                    salesMaster.saleDate,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              DataTable(
                showBottomBorder: true,
                dataRowHeight: 25,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Name',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow[800],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Unit Price',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow[800],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Qty',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow[800],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total Price',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow[800],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
                rows: getSlipDataRowList(model.listOfSalesDetails),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount:',
                    style: GoogleFonts.ubuntuCondensed(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2.0,
                      wordSpacing: 1.0,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  Text(
                    'Rs. ${salesMaster.subTotal}/=',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount:',
                    style: GoogleFonts.ubuntuCondensed(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2.0,
                      wordSpacing: 1.0,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  Text(
                    'Rs. ${salesMaster.totalDiscountAmount}/=',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[400],
              ),
              SizedBox(
                height: 5,
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
                    Text(
                      'Net Amount:',
                      style: GoogleFonts.ubuntuCondensed(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 2.0,
                        wordSpacing: 1.0,
                      ),
                    ),
                    Text(
                      'Rs. ${salesMaster.subTotalWithDiscount}/=',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[400],
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

  Widget reportView(bool view) {
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
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow[800],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Paid Amount',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow[800],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Sub Total',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow[800],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Discount',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow[800],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
                rows: getReportDataRowList(model.listOfSalesMasterForSale),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Sub Total:',
                    style: GoogleFonts.ubuntuCondensed(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2.0,
                      wordSpacing: 1.0,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  Text(
                    'Rs. ${totalSubTotal.toString()}/=',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Discount:',
                    style: GoogleFonts.ubuntuCondensed(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2.0,
                      wordSpacing: 1.0,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  Text(
                    'Rs. ${totalDiscount.toString()}/=',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[400],
              ),
              SizedBox(
                height: 5,
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
                    Text(
                      'Total Paid Amount:',
                      style: GoogleFonts.ubuntuCondensed(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 2.0,
                        wordSpacing: 1.0,
                      ),
                    ),
                    Text(
                      'Rs. ${totalPaidAmount.toString()}/=',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[400],
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
        DataCell(
          Text(
            element.menuName,
            style: GoogleFonts.ubuntu(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              // letterSpacing: 1.0,
              wordSpacing: 0.5,
            ),
          ),
        ),
        DataCell(
          Text(
            element.menuUnitPrice,
            style: GoogleFonts.ubuntu(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              // letterSpacing: 1.0,
              wordSpacing: 0.5,
            ),
          ),
        ),
        DataCell(
          Text(
            element.qty,
            style: GoogleFonts.ubuntu(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              // letterSpacing: 1.0,
              wordSpacing: 0.5,
            ),
          ),
        ),
        DataCell(
          Text(
            '${double.parse(element.menuUnitPrice) * double.parse(element.qty)}',
            style: GoogleFonts.ubuntu(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              // letterSpacing: 1.0,
              wordSpacing: 0.5,
            ),
          ),
        ),
      ]));
    });
    return rows;
  }

  List<DataRow> getReportDataRowList(List<SalesMaster> listOfSalesMaster) {
    List<DataRow> rows = [];
    listOfSalesMaster.forEach((element) {
      rows.add(DataRow(cells: <DataCell>[
        DataCell(Text(
          element.dateTime,
          style: GoogleFonts.ubuntu(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            wordSpacing: 0.5,
          ),
        )),
        DataCell(Text(
          element.paidAmount,
          style: GoogleFonts.ubuntu(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            // letterSpacing: 1.0,
            wordSpacing: 0.5,
          ),
        )),
        DataCell(Text(
          element.subTotalWithDiscount,
          style: GoogleFonts.ubuntu(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            // letterSpacing: 1.0,
            wordSpacing: 0.5,
          ),
        )),
        DataCell(Text(
          element.totalDiscountAmount,
          style: GoogleFonts.ubuntu(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            // letterSpacing: 1.0,
            wordSpacing: 0.5,
          ),
        )),
      ]));
    });
    return rows;
  }
}
