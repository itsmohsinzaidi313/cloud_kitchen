import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:food_app/controller/report_controller.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/report_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
import 'package:google_fonts/google_fonts.dart';

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
  bool isDuplicateSlipView = false;

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
                      !isDuplicateSlipView
                          ? Container()
                          : Expanded(
                              flex: 1,
                              child: getView(model.viewType),
                            ),
                      Expanded(
                        flex: !isDuplicateSlipView ? 1 : 4,
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
                    onPressed: () async {
                      model.listOfSalesDetails.clear();
                      int id = int.parse(model.salesMaster.localId);
                      ReportController.getSalesDetailsList(id).then((value) {
                        value.forEach((element) {
                          model.listOfSalesDetails
                              .add(SalesDetails.fromJson(element));
                        });
                      }).whenComplete(() {
                        // model.listOfSalesDetails.forEach((element)
                        //     {
                        //       print(
                        //           '${element.menuName} : ${element.menuUnitPrice} x ${element.qty} = ${double.parse(element.menuUnitPrice) * double.parse(element.qty)}');
                        //     });
                        //   print('Discount: ${model.salesMaster.subTotalDiscountAmount}\nTotal Amount: ${model.salesMaster.subTotal}\n Net Amount: ${model.salesMaster.subTotalWithDiscount}');
                        // duplicateSlip(isDuplicateSlipView,
                        //     model.listOfSalesDetails, model.salesMaster);
                        setState(() {
                          isDuplicateSlipView = true;
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
                  Text('Order No:'),
                  Text(
                    salesMaster.saleNo,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date:'),
                  Text(
                    salesMaster.saleDate,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
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
                rows: getDataRowList(model.listOfSalesDetails),
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

      case false:
        return Container(
          child: Column(
            children: [
              FlatButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2100, 1, 1),
                      // theme: DatePickerTheme(
                      //   containerHeight: 100.0,
                      // ),
                      onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    Config.convertDateTimeToDate(date);
                    print(
                        'Confirm DATE: ${Config.convertDateTimeToDate(date)}');
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Text(
                  'Pick Date',
                  style: TextStyle(color: Colors.blue),
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

  Widget row(SalesMaster item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item.localId,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          item.saleNo,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  List<DataRow> getDataRowList(List<SalesDetails> listOfSalesDetails) {
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
}
