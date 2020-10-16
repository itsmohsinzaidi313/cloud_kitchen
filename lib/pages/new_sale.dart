import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/database/table_object/orders_table.dart';
import 'package:food_app/database/table_object/sales_detail_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/database/table_object/tables_table.dart';
import 'package:food_app/models/generic_models/customer_order.dart';
import 'package:food_app/models/objects/category.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/new_sale_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class NewSale extends StatefulWidget {
  NewSaleModel model;

  NewSale(NewSaleModel model) {
    this.model = model;
  }

  @override
  _NewSaleState createState() => _NewSaleState(this.model);
}

class _NewSaleState extends State<NewSale> {
  final NewSaleModel model;
  bool isNew = false;

  _NewSaleState(this.model);

  String categoryName = '';

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          key: _key,
          appBar: AppTheme.appBarNormal(
            context: context,
            appBarTitle: 'New Sales',
            appBarElevation: 0.0,
            appBarBgColor: AppTheme.appBarColor,
          ),
          body: Container(
            child: Column(
              children: [
                Container(
                  color: Colors.red,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: model.leadingString.isNotEmpty
                                    ? Colors.yellow
                                    : Colors.red),
                            child: Text(
                              model.leadingString,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: model.titleString.isNotEmpty
                                    ? Colors.yellow
                                    : Colors.red),
                            child: Center(
                              child: Text(model.titleString,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          trailing: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: model.trailingString.isNotEmpty
                                    ? Colors.yellow
                                    : Colors.red),
                            child: Text(model.trailingString,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            ListTile(
                              title: Center(
                                  child: Text('Categories'.toUpperCase())),
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
                                  children: getItemsWidgets(
                                      model.lstItem, categoryName),
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
                                  children:
                                      getCartItemsWidgets(model.order.itemList),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.appBarColor,
            child: Icon(Icons.done),
            onPressed: () {
              model.order.itemList.length > 0
                  ? AppTheme.showAlertDialogOK(context,
                      title: 'Success',
                      message: 'Order saved.',
                      onOK: () => _onFloatingButtonPressed())
                  : AppTheme.showAlertDialogOK(context,
                      title: 'Failed',
                      message: 'Please add Items to punch order',
                      onOK: () => Navigator.pop(context));
            },
          ),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() async {
    bool isYes = false;
    bool type = await AppTheme.showAlertDialogYNFutureReturn(context,
        title: 'Question?',
        message: 'Are you sure?',
        onNo: () => Navigator.of(context).pop(false),
        onYes: () =>
            OrderController(model.orderType).launchAndReplacement(context)
                ? isYes = true
                : isYes = false);

    if (isYes && type) {
      if (model.titleString.isNotEmpty) {
        Navigator.pop(context);
        return true;
      } else {
        Navigator.pop(context);
        OrderController(model.orderType).launchAndReplacement(context);
      }
      return false;
    } else {
      return false;
    }
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
    Navigator.pop(context);

    if (model.order.itemList.length > 0) {
      Database db = Config.database;
      SalesMaster _salesMaster;
      int localId;

      model.salesMaster =
          model.salesMaster == null ? new SalesMaster() : model.salesMaster;
      model.salesMaster.localId =
          model.salesMaster.localId == null ? '0' : model.salesMaster.localId;

      List<Map<String, dynamic>> count = await db.rawQuery(
          'SELECT IFNULL(COUNT(id),0) AS count FROM ${SalesDetailTable.tableName} WHERE ${SalesDetailTable.salesMasterId} = ?',
          [model.salesMaster.localId]);

      CustomerOrder customerOrder = this.model.order;
      //MASTER DATA
      Map<String, dynamic> saleMasterData = {
        // SalesMasterTable[0] :  ,
        SalesMasterTable.customerId: this.model.order.customerId,
        // SalesMasterTable[2] :  ,
        SalesMasterTable.totalItems: customerOrder.totalItem().toString(),
        SalesMasterTable.subTotal: customerOrder.getSubTotal().toString(),
        SalesMasterTable.paidAmount: '0.0',
        SalesMasterTable.dueAmount: customerOrder.getSubTotal().toString(),
        // SalesMasterTable[7]  :  ,
        // SalesMasterTable[8]  :  ,
        SalesMasterTable.vat: '0.0',
        SalesMasterTable.totalPayable: customerOrder.getSubTotal().toString(),
        SalesMasterTable.paymentMethodId: '1',
        SalesMasterTable.closeTime: Config.getCurrentTime24Format(),
        SalesMasterTable.tableId: this.model.order.tableId,
        SalesMasterTable.totalItemDiscountAmount: customerOrder.discount ?? 0,
        SalesMasterTable.subTotalWithDiscount: customerOrder.getNetAmount(),
        SalesMasterTable.subTotalDiscountAmount: customerOrder.discount ?? 0,
        SalesMasterTable.totalDiscountAmount: customerOrder.discount ?? 0,
        SalesMasterTable.deliveryCharge: '0.0',
        SalesMasterTable.subTotalDiscountValue: '',
        SalesMasterTable.subTotalDiscountType: 'plain',
        SalesMasterTable.saleDate: Config.getCurrentDate(),
        SalesMasterTable.dateTime: Config.getCurrentDateTimeDBFormat(),
        SalesMasterTable.orderTime: Config.getCurrentTime24Format(),
        SalesMasterTable.cookingStartTime: Config.getCurrentDateTimeDBFormat(),
        SalesMasterTable.cookingDoneTime: Config.getCurrentDateTimeDBFormat(),
        SalesMasterTable.modified: 'No',
        SalesMasterTable.userId: Config.currentUser.serverId,
        SalesMasterTable.waiterId: this.model.order.waiterId,
        SalesMasterTable.outletId: Config.currentUser.outletId,
        SalesMasterTable.orderStatus: '1',
        SalesMasterTable.orderType: this.model.salesMaster.orderType,
        SalesMasterTable.delStatus: Config.currentUser.delStatus,
        // SalesMasterTable[33]  :  ,
        SalesMasterTable.deviceKey: Config.currentShift.deviceKey,
        // SalesMasterTable[35]  :  ,
        SalesMasterTable.companyId: Config.currentUser.companyId,
        SalesMasterTable.isDelete: 0.toString(),
        SalesMasterTable.isUpload: '0'
      };

      ///EDIT ORDER
      if (count[0]['count'] > 0) {
        setState(() {
          isNew = false;
        });
        _salesMaster = this.model.salesMaster;
        db.delete(SalesDetailTable.tableName,
            where: '${SalesDetailTable.salesMasterId} = ?',
            whereArgs: [_salesMaster.localId]);
        localId = int.parse(_salesMaster.localId);

        db.update(SalesMasterTable.tableName, saleMasterData,
            where: '${SalesMasterTable.localId} = ?',
            whereArgs: [_salesMaster.localId]);
      } else {
        ///NEW ORDER INSERTION
        setState(() {
          isNew = true;
        });
        _salesMaster = SalesMaster();
        localId = await _salesMaster.insertSpecificIntoDb(
            db, saleMasterData); // INSERTING NEW ORDER IN SALES MASTER

        //UPDATING SALE NO IN SALE MASTER
        db.update(SalesMasterTable.tableName,
            {SalesMasterTable.saleNo: Lib.codeGenerator('ORD', localId)},
            where: '${SalesMasterTable.localId} = ?',
            whereArgs: [localId.toString()]);

        // ADDING ENTRY IN ORDER TABLE
        if (localId > 0 && model.salesMaster.orderType == '1') {
          int orderTableId = await db.insert(OrdersTable.tableName, {
            OrdersTable.persons: model.order.noOfPersons,
            OrdersTable.bookingTime: Config.getCurrentTime24Format(),
            OrdersTable.saleId: localId,
            OrdersTable.saleNo: Lib.codeGenerator('ORD', localId),
            OrdersTable.outletId: Config.currentUser.outletId,
            OrdersTable.tableId: model.order.tableId,
            OrdersTable.delStatus: OrdersTable.RESERVED
          });
          if (orderTableId > 0)
            db.update(TablesTable.tableName,
                {TablesTable.delStatus: TablesTable.RESERVED},
                where: '${model.order.tableId} = ?',
                whereArgs: [model.order.tableId]);
        }
      } //ELSE

      ///insert sales_details
      this.model.order.itemList.forEach((item) {
        insertIntoSalesDetails(db, item, localId);
      });
      if (isNew) {
        DashboardController(context).pushAndRemoveUntil(context);
      } else {
        // Navigator.pop(context);
        OrderController(model.orderType).launchAndReplacement(context);
      }
    }
  }

  //DETAIL DATA
  Future<void> insertIntoSalesDetails(
      Database db, Item item, int salesMasterLocalId) async {
    Map<String, dynamic> details = {
      // SalesDetailTable[0] : ,
      SalesDetailTable.foodMenuId: int.parse(item.code).toString(),
      SalesDetailTable.menuName: item.name,
      SalesDetailTable.qty: item.quantity.toString(),
      SalesDetailTable.menuPriceWithoutDiscount:
          (int.parse(item.quantity) * double.parse(item.salePrice)).toString(),
      SalesDetailTable.menuPriceWithDiscount:
          (int.parse(item.quantity) * double.parse(item.salePrice) -
                      double.parse(this.model.order.discount) ??
                  0)
              .toString(),
      SalesDetailTable.menuUnitPrice: item.salePrice.toString(),
      SalesDetailTable.menuVatPercentage: '0.0',
      // SalesDetailTable[8] : ,
      SalesDetailTable.menuDiscountValue: '0',
      SalesDetailTable.discountType: 'plain',
      // SalesDetailTable[11] : ,
      SalesDetailTable.discountAmount: this.model.order.discount ?? 0,
      SalesDetailTable.itemType: 'Kitchen Item',
      SalesDetailTable.cookingStatus: 'Done',
      SalesDetailTable.cookingStartTime: Config.getCurrentDateTimeDBFormat(),
      SalesDetailTable.cookingDoneTime: Config.getCurrentDateTimeDBFormat(),
      // SalesDetailTable[17] : ,
      SalesDetailTable.salesMasterId: salesMasterLocalId,
      SalesDetailTable.orderStatus: '0',
      SalesDetailTable.userId: Config.currentUser.serverId,
      SalesDetailTable.outletId: Config.currentUser.outletId,
      SalesDetailTable.delStatus: Config.currentUser.delStatus,
    };
    int detailsId = await SalesDetails().insertSpecificIntoDb(db, details);
  }
}
