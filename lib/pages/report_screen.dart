import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/report_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
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
                            onTap: () {},
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
                            onTap: () {},
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
              child: Container(
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
                    autoCompleteTextField = AutoCompleteTextField<SalesMaster>(
                      clearOnSubmit: false,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Sale',
                        contentPadding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      itemSubmitted: (item){
                        setState(() {
                          autoCompleteTextField.textField.controller.text = item.saleNo;
                          print('${autoCompleteTextField.textField.controller.text}');
                        });
                      },
                      key: key,
                      suggestions: model.listOfSalesMaster,
                      itemBuilder: (context, item){
                        return row(item);
                      },
                      itemFilter: (item, query){
                        return item.saleNo.toLowerCase().startsWith(query.toLowerCase());
                      },
                      itemSorter: (a,b ){
                        return a.saleNo.compareTo(b.saleNo);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
        SizedBox(width: 10 ,),
        Text(
          item.saleNo,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
