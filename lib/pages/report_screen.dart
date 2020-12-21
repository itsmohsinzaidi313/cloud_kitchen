import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/controller/report_controller.dart';
import 'package:food_app/controller/shift_controller.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/report_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
  String _dropdown = 'Morning';
  bool _isDropdownButtonPressed = false;
  ProgressDialog _progress;

  _ReportScreenState(this.model);

  @override
  Widget build(BuildContext context) {
    _progress = AppTheme.showProgressDialog(context,
        // isDismissible: false,
        widget: Center(
          child: Text('Loading..'),
        ));
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
                              model.isReportView = false;
                            }),
                            child: ReportController.getDuplicateSlipButton(
                                context: context),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 3,
                          child: InkWell(
                            onTap: () => setState(() {
                              model.viewType = 2;
                              model.isDuplicateSlipView = false;
                            }),
                            child: ReportController.getGenerateReportButton(
                                context: context),
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
                physics: ClampingScrollPhysics(),
                child: Container(
                  height: Config.getDeviceHeight(context),
                  width: Config.getDeviceWidth(context),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _getView1(model.viewType),
                      ),
                      model.viewType == 1
                          ? _getView2(
                              child: ReportController.getDuplicateSlipView(
                                  context: context,
                                  view: model.isDuplicateSlipView,
                                  list: model.listOfSalesDetails,
                                  salesMaster: model.salesMaster))
                          : _getView2(
                              child: ReportController.getReportView(
                                  context: context,
                                  view: model.isReportView,
                                  shift: model.shift,
                                  list: model.listOfSalesMasterForSale,
                                  totalDiscount: model.totalDiscount.toString(),
                                  totalSubTotal: model.totalSubTotal.toString(),
                                  totalPaidAmount:
                                      model.totalPaidAmount.toString()))
                      // : getView2(child: reportView(isReportView)),
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

  Widget _getView1(int viewType) {
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
                        child: _getAutoCompleteTextField(),
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
                  ReportController.getDateButtonLabel(labelText: 'From'),
                  RaisedButton(
                    color: Colors.grey[200],
                    textColor: Colors.yellow.shade800,
                    elevation: 0.0,
                    onPressed: () async {
                      model.fromDate = await _selectDate(
                          context: context,
                          selectedDate: DateTime.now(),
                          firstDate: DateTime(2000, 1, 1));
                      model.fromDate = Config.convertDateTimeToDate(
                              DateTime.parse(model.fromDate))
                          .toString();
                      print('From DATE: $model.fromDate');
                    },
                    child: Text(
                      model.fromDate.contains('Tap')
                          ? model.fromDate
                          : DateFormat('EEE, MMM d, ' 'yy').format(
                              DateTime.parse(model.fromDate),
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
                  ReportController.getDateButtonLabel(labelText: 'To'),
                  RaisedButton(
                    color: Colors.grey[200],
                    textColor: Colors.yellow.shade800,
                    elevation: 0.0,
                    onPressed: () async {
                      model.toDate = await _selectDate(
                          context: context,
                          selectedDate: DateTime.parse(model.fromDate)
                              .add(Duration(days: 1)),
                          firstDate: DateTime.parse(model.fromDate)
                              .add(Duration(days: 1)));
                      setState(() {
                        model.toDate = Config.convertDateTimeToDate(
                                DateTime.parse(model.toDate))
                            .toString();
                      });
                    },
                    child: Text(
                      model.toDate.contains('Tap')
                          ? model.toDate
                          : DateFormat('EEE, MMM d, ' 'yy').format(
                              DateTime.parse(model.toDate),
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
              DropdownButton<String>(
                value: _dropdown,
                underline: Container(
                  height: 2,
                  color: Colors.redAccent,
                ),
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.redAccent,
                ),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: Colors.grey[800],
                  letterSpacing: 1,
                ),
                onChanged: (newValue) {
                  setState(() {
                    _dropdown = newValue;
                    _isDropdownButtonPressed = true;
                  });
                },
                items: ShiftController.dropdownList,
              ),
              ReportController.getDateSearchIconButton(
                  onPressed: _searchSelectedDate),
            ],
          ),
        );
        break;

      default:
        return Container();
        break;
    }
  }

  Widget _getView2({Widget child}) {
    return Expanded(
      flex: 4,
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
          child: child,
        ),
      ),
    );
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

  void _searchSelectedDate() async {
    if (!model.fromDate.contains('Tap') && !model.toDate.contains('Tap')) {
      await _progress.show();
      model.listOfSalesMasterForSale.clear();
      model.totalDiscount = 0.0;
      model.totalPaidAmount = 0.0;
      model.totalSubTotal = 0.0;
      List<SalesMaster> value = await model.salesMaster.getSalesByDate(
          model.fromDate,
          model.toDate,
          _isDropdownButtonPressed ? _dropdown : '');
      if (value != null) {
        value.forEach((element) {
          model.listOfSalesMasterForSale.add(element);
          model.totalDiscount += double.parse(element.totalDiscountAmount);
          model.totalSubTotal += double.parse(element.subTotalWithDiscount);
          model.totalPaidAmount += double.parse(element.paidAmount);
          _isDropdownButtonPressed ? model.shift = _dropdown : model.shift = '';
        });
        await _progress.hide();
        setState(() {
          model.isReportView = true;
        });
      } else {
        await _progress.hide();
        print('Sales List Contains Nothing');
      }
    } else {
      await _progress.hide();
      AppTheme.showAlertDialogOK(context,
          title: 'Invalid Date Selected',
          message: 'Please select valid date to generate report',
          onOK: () => Navigator.pop(context));
    }
  }

  Widget _getAutoCompleteTextField() {
    AutoCompleteTextField _autoCompleteTextField;
    try {
      _autoCompleteTextField = AutoCompleteTextField<SalesMaster>(
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
              _autoCompleteTextField.textField.controller.text = '';
            },
          ),
          contentPadding: EdgeInsets.fromLTRB(10, 30, 10, 20),
          hintStyle: TextStyle(color: Colors.grey),
        ),
        keyboardType: TextInputType.number,
        itemSubmitted: (item) async {
          setState(() {
            model.salesMaster = item;
            _autoCompleteTextField.textField.controller.text = item.saleNo;
            model.listOfSalesDetails.clear();
          });
          int id = int.parse(model.salesMaster.localId);
          await _progress.show();
          List<Map<String, dynamic>> value =
              await ReportController.getSalesDetailsList(id: id);
          if (value != null) {
            value.forEach((element) {
              model.listOfSalesDetails.add(SalesDetails.fromJson(element));
            });
            await _progress.hide();
            setState(() {
              model.isDuplicateSlipView = true;
              model.isReportView = false;
            });
          } else {
            await _progress.hide();
            print('Sales Details Contains Nothing');
          }
        },
        key: key,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        suggestions: model.listOfSalesMasterForSlip,
        itemBuilder: (context, item) {
          return ReportController.row(item: item);
        },
        itemFilter: (item, query) {
          if (_autoCompleteTextField.textField.controller.text.isEmpty)
            query = '';
          return item.saleNo.toLowerCase().startsWith(
              Lib.codeGenerator('ORD', int.tryParse(query) ?? 0).toLowerCase());
        },
        itemSorter: (a, b) {
          return a.saleNo.compareTo(b.saleNo);
        },
      );
    } catch (e) {
      AppTheme.showToast(e.toString(), context);
    }
    return _autoCompleteTextField;
  }
}
