import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/models/objects/category.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/new_sale_model.dart';
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
      if (categoryName.isEmpty) {
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
          onTap: () {
            setState(() {
              model.order.addItem(item);
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
    if (model.order.itemList.length > 0) {
      Database _db = Config.database;
      SalesMaster _salesMaster;
      int masterId;
      if (model.salesMaster == null) {
        this.model.salesMaster = new SalesMaster();
        this.model.salesMaster.id = "0";
      }
      List<Map<String, dynamic>> count = await _db.rawQuery(
          'SELECT IFNULL(COUNT(id),0) AS count FROM sales_details WHERE sales_master_id = ?',
          [model.salesMaster.id]);

      String customerOrderAmount = this.model.order.getOrderAmount().toString();

      Map<String, dynamic> master = {
        'date_time': Config.getCurrentDateTime(),
        'paid_amount': '0.0',
        'due_amount': customerOrderAmount,
        'total_payable': customerOrderAmount,
        'user_id': Config().currentUser.serverId,
        'device_key': Config().currentShift.deviceKey,
        'is_delete': 0.toString(),
      };

      ///EDIT ORDER
      if (count[0]['count'] > 0) {
        _salesMaster = this.model.salesMaster;
        _db.delete(Tables.salesDetails,
            where: 'sales_master_id = ?', whereArgs: [_salesMaster.id]);
        masterId = int.parse(_salesMaster.id);
        _db.update(Tables.salesMaster, master,
            where: '${Columns.salesMaster[0]} = ?',
            whereArgs: [_salesMaster.id]);
      } //IF
      else {
        ///NEW ORDER INSERTION
        _salesMaster = SalesMaster();
        masterId = await _salesMaster.insertSpecificIntoDb(_db, master);
        String code = codeGenerator(masterId); // GENERATES CODE FROM MASTER ID
        Map<String, dynamic> update = {
          'sale_no': code,
        };

        int updateId = await _salesMaster.updateSpecificIntoDb(
            _db, update, 'id', masterId);
        print('UPDATE RETURN ID: $updateId');
      } //ELSE

      ///insert sales_details
      this.model.order.itemList.forEach((item) {
        insertIntoSalesDetails(_db, item, masterId);
      });
    }
    // OrderController().launchAndReplacement(context);
    DashboardController(context).pushAndRemoveUntil(context);
  }

  Future<void> insertIntoSalesDetails(
      Database db, Item item, int masterId) async {
    Map<String, dynamic> details = {
      'food_menu_id': item.code,
      'qty': item.quantity,
      'menu_price_without_discount':
          (int.parse(item.quantity) * double.parse(item.salePrice)).toString(),
      'sales_master_id': masterId,
    };
    int detailsId = await SalesDetails().insertSpecificIntoDb(db, details);
    print('SALES DETAILS RETURN ID: $detailsId');
  }

  String codeGenerator(int id) {
    String code = 'ORD/';
    // String deviceId = Config().currentShift.deviceKey;
    String deviceId = '1';
    if (int.parse(deviceId) < 10) {
      deviceId = '0$deviceId/';
    }
    String digits = '';
    if (id < 10)
      digits = '000$id';
    else if (id < 100)
      digits = '00$id';
    else if (id < 1000)
      digits = '0$id';
    else
      digits = '$id';
    return code + deviceId + digits;
  }

  void uploadOrder(SalesMaster salesMaster, SalesDetails salesDetails) {}
}
