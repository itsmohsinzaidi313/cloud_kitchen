import 'package:flutter/material.dart';
import 'package:food_app/database/table_object/category_table.dart';
import 'package:food_app/database/table_object/item_table.dart';
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
import 'package:food_app/pages/new_sale.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/shared/lib.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sqflite/sqflite.dart';

class NewSaleController {
  NewSaleModel model;

  TextEditingController userName = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userAddress = TextEditingController();

  NewSaleController() {
    model = new NewSaleModel();
    model.lstCategory = [];
    model.lstItem = [];
    model.order = new CustomerOrder();
  }

  void launch(BuildContext context) => Navigator.of(context)
      .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));

  Future<void> launchDineIn(BuildContext context, String orderType, String tableId,
      String waiterId, List<String> titleStrings) async{
    this.model.salesMaster = SalesMaster();
    this.model.salesMaster.orderType = orderType;
    this.model.order.tableId = tableId;
    this.model.order.waiterId = waiterId;
    this.model.order.noOfPersons = titleStrings[0];

    this.model.leadingString = 'Persons: ${titleStrings[0]}';
    this.model.titleString = 'Table: ${titleStrings[1]}';
    this.model.trailingString = 'Waiter: ${titleStrings[2]}';

    await setCategoryAndItemsList(context);
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));
  }

  Future<void> launchTakeaway(BuildContext context, String orderType, String customerId,
      List<String> titleStrings) async{
    this.model.salesMaster = SalesMaster();
    this.model.salesMaster.orderType = orderType;
    this.model.order.customerId = customerId;

    this.model.leadingString = 'Customer: ${titleStrings[0]}';
    this.model.titleString = 'Contact: ${titleStrings[1]}';
    this.model.trailingString = titleStrings[2];

    await setCategoryAndItemsList(context);

    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));
  }

  Future<void> launchDelivery(BuildContext context, String orderType, String customerId,
      List<String> titleStrings) async {
    this.model.salesMaster = SalesMaster();
    this.model.salesMaster.orderType = orderType;
    this.model.order.customerId = customerId;

    this.model.leadingString = 'Customer: ${titleStrings[0]}';
    this.model.titleString = 'Phone: ${titleStrings[1]}';
    this.model.trailingString = titleStrings[2];

    await setCategoryAndItemsList(context);
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));
  }

  void launchAndReplacement(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new NewSale(this.model)));

  void editOrder(SalesMaster salesMaster, int orderType, BuildContext context) async {
    await setCategoryAndItemsList(context);
    List<Item> updatedList = await SalesDetails()
        .getOrderWhereMasterId(Config.database, salesMaster);
    this.model.order.setItemList = updatedList;
    this.model.salesMaster = salesMaster;
    this.model.order.customerId = salesMaster.customerId;
    this.model.order.tableId = salesMaster.tableId;
    this.model.order.waiterId = salesMaster.waiterId;
    this.model.orderType = orderType;
    this.model.leadingString = '';
    this.model.titleString = '';
    this.model.trailingString = '';
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new NewSale(this.model)));
  }

  static Map<String,dynamic> getSalesMasterData(NewSaleModel model) {

    Map<String, dynamic> saleMasterData = {
      // SalesMasterTable[0] :  ,
      SalesMasterTable.customerId: model.order.customerId,
      // SalesMasterTable[2] :  ,
      SalesMasterTable.totalItems: model.order.totalItem().toString(),
      SalesMasterTable.subTotal: model.order.getSubTotal().toString(),
      SalesMasterTable.paidAmount: '0.0',
      SalesMasterTable.dueAmount: model.order.getSubTotal().toString(),
      // SalesMasterTable[7]  :  ,
      // SalesMasterTable[8]  :  ,
      SalesMasterTable.vat: '0.0',
      SalesMasterTable.totalPayable: model.order.getSubTotal().toString(),
      SalesMasterTable.paymentMethodId: '1',
      SalesMasterTable.closeTime: Config.getCurrentTime24Format(),
      SalesMasterTable.tableId: model.order.tableId,
      SalesMasterTable.totalItemDiscountAmount: model.order.discount ?? 0,
      SalesMasterTable.subTotalWithDiscount: model.order.getNetAmount(),
      SalesMasterTable.subTotalDiscountAmount: model.order.discount ?? 0,
      SalesMasterTable.totalDiscountAmount: model.order.discount ?? 0,
      SalesMasterTable.deliveryCharge: '0.0',
      SalesMasterTable.subTotalDiscountValue: '',
      SalesMasterTable.subTotalDiscountType: 'plain',
      SalesMasterTable.saleDate: Config.getCurrentShiftDate(Config.currentShift.openingBalanceDateTime),
      SalesMasterTable.dateTime: Config.getCurrentDateTimeDBFormat(),
      SalesMasterTable.orderTime: Config.getCurrentTime24Format(),
      SalesMasterTable.cookingStartTime: Config.getCurrentDateTimeDBFormat(),
      SalesMasterTable.cookingDoneTime: Config.getCurrentDateTimeDBFormat(),
      SalesMasterTable.modified: 'No',
      SalesMasterTable.userId: Config.currentUser.serverId,
      SalesMasterTable.waiterId: model.order.waiterId,
      SalesMasterTable.outletId: Config.currentUser.outletId,
      SalesMasterTable.orderStatus: '1',
      SalesMasterTable.orderType: model.salesMaster.orderType,
      SalesMasterTable.delStatus: Config.currentUser.delStatus,
      // SalesMasterTable[33]  :  ,
      SalesMasterTable.deviceKey: Config.currentShift.deviceKey,
      // SalesMasterTable[35]  :  ,
      SalesMasterTable.companyId: Config.currentUser.companyId,
      SalesMasterTable.isDelete: 0.toString(),
      SalesMasterTable.isUpload: '0',
      SalesMasterTable.shift: Config.currentShift.shift
    };
    return saleMasterData;
  }

    static Future<int> editPreviousOrder(SalesMaster _salesMaster, Map<String, dynamic> mapSalesMaster) async{
    Database db = Config.database;
    int localId;
    await db.delete(SalesDetailTable.tableName,
        where: '${SalesDetailTable.salesMasterId} = ?',
        whereArgs: [_salesMaster.localId]);
        localId = int.parse(_salesMaster.localId);

    await db.update(SalesMasterTable.tableName, mapSalesMaster,
        where: '${SalesMasterTable.localId} = ?',
        whereArgs: [_salesMaster.localId]);
    return localId;
  }

  static Future<int> newSaleOrder(Map<String,dynamic> saleMasterData,
      CustomerOrder customerOrder, String orderType) async {
    int localId;
    Database db = Config.database;
    SalesMaster _salesMaster = new SalesMaster();
    localId = await _salesMaster.insertSpecificIntoDb(db, saleMasterData); // INSERTING NEW ORDER IN SALES MASTER

    //UPDATING SALE NO IN SALE MASTER
    db.update(SalesMasterTable.tableName,
        {SalesMasterTable.saleNo: Lib.codeGenerator('ORD', localId)},
        where: '${SalesMasterTable.localId} = ?',
        whereArgs: [localId.toString()]);

    // ADDING ENTRY IN ORDER TABLE
    // int id = customerOrder.orderType;
    if (localId > 0 && orderType == '1') {
      int orderTableId = await db.insert(OrdersTable.tableName, {
        OrdersTable.persons: customerOrder.noOfPersons,
        OrdersTable.bookingTime: Config.getCurrentTime24Format(),
        OrdersTable.saleId: localId,
        OrdersTable.saleNo: Lib.codeGenerator('ORD', localId),
        OrdersTable.outletId: Config.currentUser.outletId,
        OrdersTable.tableId: customerOrder.tableId,
        OrdersTable.delStatus: OrdersTable.RESERVED
      });
      if (orderTableId > 0)
        db.update(TablesTable.tableName,
            {TablesTable.delStatus: TablesTable.RESERVED},
            where: '${customerOrder.tableId} = ?',
            whereArgs: [customerOrder.tableId]);
    }
    return localId;
  }

  static Future<List<Category>> getCategoriesList() async{
    List<Category> _category = [];
    List<Map<String, dynamic>> categoryMap = await Config.database.query(CategoryTable.tableName);
    if(categoryMap.length > 0){
      categoryMap.forEach((element) {
        _category.add(Category.fromJson(element));
      });
    }
    return _category;
  }

  static Future<List<Item>> getItemsList() async{
    List<Item> _items = [];
    List<Map<String, dynamic>> itemMap = await Config.database.query(ItemTable.tableName);
    if(itemMap.length > 0){
      itemMap.forEach((element) {
        _items.add(Item.fromJson(element));
      });
    }
    return _items;
  }

  Future<void> setCategoryAndItemsList(BuildContext context)async{
    ProgressDialog _progressDialog = AppTheme.showProgressDialog(context, widget: Center(child: Text('Loading..'),),);
    await _progressDialog.show();
    if(model.lstCategory.isEmpty){
      model.lstCategory = await getCategoriesList();
      DataLists.instance.listCategories = model.lstCategory;
    }
    if(model.lstItem.isEmpty)
    {
      model.lstItem = await getItemsList();
      DataLists.instance.listItem = model.lstItem;
    }
    await _progressDialog.hide();
  }


}
