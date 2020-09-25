import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/view_models/order_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';

class OrderScreen extends StatefulWidget {

  final OrderModel model;
  OrderScreen({this.model});
  @override
  _OrderScreenState createState() => _OrderScreenState(this.model);
}

class _OrderScreenState extends State<OrderScreen> {

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final OrderModel model;

  _OrderScreenState(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _key,
      appBar: AppTheme.appBarNormal(
          appBarTitle: 'New Order',
          appBarBgColor: AppTheme.appBarColor,
          appBarElevation: 0.0,
          context: context),
      body: Container(
        height: Config.getDeviceHeight(context),
        width: Config.getDeviceWidth(context),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: getHoldingOrderList(model.getItemHoldList),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: getOrderTypeList(model.getOrderTypeList),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getHoldingOrderList(List<Item> lstItem) {
    List<Widget> widgets = [];
    lstItem.forEach((item) {
      widgets.add(
        InkWell(
          onTap: () {
            setState(() {
              _key.currentState.showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 100),
                  content: Text('${item.name} Tapped'),
                ),
              );
            });
          },
          child: Card(
            elevation: 5,
            child: ListTile(
              title: Text(item.name),
            ),
          ),
        ),
      );
    });
    return widgets;
  }

  List<Widget> getOrderTypeList(List<String> type) {
    List<Widget> widgets = [];
    type.forEach((item) {
      widgets.add(
        InkWell(
          onTap: () {
            setState(() {
              _key.currentState.showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 100),
                  content: Text('$item Tapped'),
                ),
              );
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2,),
            height: Config.getDeviceHeight(context) * 0.25,
            width: Config.getDeviceWidth(context),
            child: Card(
              elevation: 5,
              child: Center(child: Text(item),),
              ),
          ),
          ),
      );
    });
    return widgets;
  }
}
