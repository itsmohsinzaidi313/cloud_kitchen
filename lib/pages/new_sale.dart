import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/models/generic_models/customer_order.dart';
import 'package:food_app/models/objects/category.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/new_sale_model.dart';
import 'package:food_app/pages/orders_screen.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:sqflite/sqflite.dart';

class NewSale extends StatefulWidget {
  final NewSaleModel model;

  NewSale(this.model);

  @override
  _NewSaleState createState() => _NewSaleState(this.model);
}

class _NewSaleState extends State<NewSale> {
  final NewSaleModel model;

  _NewSaleState(this.model);

  String categoryName = '';

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppTheme.appBarNormal(
        context: context,
        appBarTitle: 'New Sales',
        appBarElevation: 0.0,
        appBarBgColor: AppTheme.appBarColor,
      ),
      body: Container(
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  ListTile(
                    title: Center(child: Text('Categories'.toUpperCase())),
                  ),
                  Container(
                    height: Config.getDeviceHeight(context) * 0.1,
                    padding: EdgeInsets.only(top: 5),
                    // decoration: BoxDecoration(border: Border.all(width: 2)),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: getCategoryWidgets(model.lstCategory),
                    ),
                  ),
                  ListTile(
                    title: Center(child: Text('Items'.toUpperCase())),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.only(top: 5),
                      // decoration: BoxDecoration(border: Border.all(width: 2)),
                      child: GridView.count(
                        crossAxisCount: 4,
                        children: getItemsWidgets(model.lstItem, categoryName),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: ListView(
                        children: getCartItemsWidgets(model.order.itemList),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.appBarColor,
        child: Icon(Icons.done),
        onPressed: _onFloatingButtonPressed,
      ),
    );
  }

  List<Widget> getCategoryWidgets(List<Category> lstCategory) {
    List<Widget> widgets = [];
    lstCategory.forEach((category) {

      widgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              categoryName = category.categoryName;
            });
          },
          child: Card(
            elevation: 4,
            color: Colors.amberAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  category.categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Ubuntu',
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
    return widgets;
  }

  List<Widget> getItemsWidgets(List<Item> lstItem, String categoryName) {
    List<Widget> widgets = [];
    lstItem.forEach((item) {
      if(categoryName.isEmpty){
        categoryName = item.categoryName;
      }
      if (item.categoryName == categoryName)
        widgets.add(
          GestureDetector(
            onTap: () {
              setState(() {
                this.model.order.addItem(item);
              });
            },
            child: Card(
              elevation: 4,
              color: Colors.amberAccent,
              child: Center(
                child: Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Ubuntu',
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
        );
    });
    return widgets;
  }

  List<Widget> getCartItemsWidgets(List<Item> lstItem) {
    List<Widget> widgets = [];
    lstItem.forEach((item) {
      widgets.add(
        GestureDetector(
          onTap: (){
            setState(() {
              item.quantity = (int.parse(item.quantity) + 1).toString();
            });
          },
          child: Card(
            elevation: 4,
            child: ListTile(
              title: Text(item.name),
              subtitle: Text(item.quantity),
              trailing: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    item.quantity = 1.toString();
                    this.model.order.removeItem(item);
                  });
                },
              ),
            ),
          ),
        ),
      );
    });
    return widgets;
  }

  void _onFloatingButtonPressed() async {
    Database db =  Config.database;
    String customerOrder = CustomerOrder().getOrderAmount().toString();
    Map<String, dynamic> master = {
      'date_time' : Config.getCurrentDateTime(),
      'paid_amount' : customerOrder,
      'due_amount' : customerOrder,
      'total_payable' : customerOrder,
    };
    int masterId = await SalesMaster().insertSpecificIntoDb(db, master);
    print('SALES MASTER RETURN ID: $masterId');

    this.model.order.itemList.forEach((item) {
      insertIntoSalesDetails(db, item, masterId);
    });

    OrderController().launchAndReplacement(context);
  }

  Future<void> insertIntoSalesDetails(Database db, Item item, int masterId) async{
    Map<String, dynamic> details = {
      'food_menu_id' : item.code,
      'qty' : item.quantity,
      'menu_price_without_discount' : (int.parse(item.quantity)  * double.parse(item.salePrice)).toString(),
      'sales_master_id' : masterId,
    };
    int detailsId = await SalesDetails().insertSpecificIntoDb(db, details);
    print('SALES DETAILS RETURN ID: $detailsId');
  }
}
