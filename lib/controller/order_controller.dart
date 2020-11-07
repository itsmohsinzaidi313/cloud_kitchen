import 'package:flutter/material.dart';
import 'package:food_app/controller/new_sale_controller.dart';
import 'package:food_app/database/table_object/customer_table.dart';
import 'package:food_app/database/table_object/sales_master_table.dart';
import 'package:food_app/models/objects/payment_method.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/order_model.dart';
import 'package:food_app/pages/orders_screen.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';

class OrderController {
  OrderModel model;
  List<SalesMaster> salesMasterList = [];
  List<PaymentMethod> paymentMethodList = [];

  OrderController(int orderType) {
    this.model = new OrderModel();
    model.paymentMethodList = DataLists.instance.listPaymentMethods;
    model.orderType = orderType;
    getDineInList();
    model.dineInColumns = [
      'Pay',
      'Sale No',
      'Table No',
      'Waiter Name',
      'DueAmount',
      'Delete',
      'Edit'
    ];
    getTakeawayList();
    model.takeawayAndDeliveryColumns = [
      'Pay',
      'Sale No',
      'Cell No',
      'Customer Name',
      'DueAmount',
      'Delete',
      'Edit'
    ];
  }

  void getDineInList() async {
    List<SalesMaster> list = await SalesMaster().getDineInList(Config.database);
    model.dineInList = list;
  }

  void getTakeawayList() async {
    List<SalesMaster> list =
        await SalesMaster().getTakeawayList(Config.database);
    model.takeawayList = list;
  }

  void getDeliveryList() async {
    List<SalesMaster> list =
        await SalesMaster().getDeliveryList(Config.database);
    model.deliveryList = list;
  }

  void getHoldingOrders() async {
    Database db = Config.database;
    List<SalesMaster> list = await SalesMaster().queryAllRows(db);
    model.setItemHoldList(list);
  }

  void launch(BuildContext context) =>
      SalesMaster().queryAllRows(Config.database).then((value) {
        this.model.setItemHoldList(value);
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new OrderScreen(
                  model: model,
                )));
      });

  bool launchAndReplacement(BuildContext context) {
    SalesMaster().queryAllRows(Config.database).then((value) {
      this.model.setItemHoldList(value);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => new OrderScreen(
                model: model,
              )));
    });
    return true;
  }

  bool popScreen(BuildContext context) {
    Navigator.pop(context);
    return true;
  }

  static Future<Widget> getDineInOrders(
      BuildContext context,
      void onOk(Map<String, dynamic> id),
      void onNo(Map<String, dynamic> id),
      int _orderType) async {
    try {
      List<Map<String, dynamic>> data = await Config.database.rawQuery(
          "select *, IFNULL((select name from tables where id = a.table_id),'x') as tables, (select full_name from users where id = a.user_id) as waiter, a.due_amount from sales_master a where a.order_type = '1' and a.paid_amount = '0.0' and a.is_delete = '0'");

      List<ExpansionTile> expansionTiles = [];
      data.forEach((element) {
        // SalesMaster salesMaster = new SalesMaster.fromJson(element);
        expansionTiles.add(ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${element['sale_no']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${element['tables']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${element['waiter']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${element['due_amount']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          children: [
            Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Column(
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            color: Colors.yellow[900],
                            size: 20,
                          ),
                          Text('Order\nPayment', style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
                        ],
                      ),
                      onTap: () => onOk(element),
                    ),
                    InkWell(
                      child: Column(
                        children: [
                          Icon(
                            Icons.edit_rounded,
                            color: Colors.grey[700],
                            size: 20,
                          ),
                          Text('Edit\nOrder', style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
                        ],
                      ),
                      onTap: () => NewSaleController().editOrder(
                          new SalesMaster.fromJson(element), _orderType, context),
                    ),
                    InkWell(
                      child: Column(
                        children: [
                          Icon(
                            Icons.delete_rounded,
                            color: Colors.red,
                            size: 20,
                          ),
                          Text('Cancel\nOrder', style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
                        ],
                      ),
                      onTap: () => onNo(element),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
      });
      return Column(
        children: [
          ListTile(
            tileColor: Colors.grey[200],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Sale No.',
                  style: GoogleFonts.staatliches(
                    letterSpacing: 2,
                    wordSpacing: 1,
                    fontWeight: FontWeight.w500,
                    // fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Table',
                  style: GoogleFonts.staatliches(
                    letterSpacing: 2,
                    wordSpacing: 1,
                    fontWeight: FontWeight.w500,
                    // fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Waiter',
                  style: GoogleFonts.staatliches(
                    letterSpacing: 2,
                    wordSpacing: 1,
                    fontWeight: FontWeight.w500,
                    // fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Amount',
                  style: GoogleFonts.staatliches(
                    letterSpacing: 2,
                    wordSpacing: 1,
                    fontWeight: FontWeight.w500,
                    // fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                children: expansionTiles,
              ),
            ),
          ),
        ],
      );
    } catch (e) {
      return Container(
        child: Text('An error has occured \n$e'),
      );
    }
  }

  static Future<Widget> getTakeAwayOrders(
      BuildContext context,
      void onOk(Map<String, dynamic> id),
      void onNo(Map<String, dynamic> id),
      int _orderType) async {
    List<Map<String, dynamic>> data = await Config.database.rawQuery(
        "select *, IFNULL((select name from customers where ${CustomerTable.localId} = a.customer_id),'') as customer_name, IFNULL((select phone from customers where  ${CustomerTable.localId} = a.customer_id),'') as contact, a.due_amount from sales_master a where a.order_type = '2' and a.paid_amount = '0.0' and a.is_delete = '0'");

    List<ExpansionTile> expansionTiles = [];
    data.forEach((element) {
      // SalesMaster salesMaster = new SalesMaster.fromJson(element);
      expansionTiles.add(ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '${element['sale_no']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${element['customer_name']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${element['contact']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${element['due_amount']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        children: [
          Column(
            children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Column(
                      children: [
                        Icon(
                          Icons.attach_money_rounded,
                          color: Colors.yellow[900],
                          size: 20,
                        ),
                        Text('Order\nPayment', style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
                      ],
                    ),
                    onTap: () => onOk(element),
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Icon(
                          Icons.edit_rounded,
                          color: Colors.grey[700],
                          size: 20,
                        ),
                        Text('Edit\nOrder', style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
                      ],
                    ),
                    onTap: () => NewSaleController().editOrder(
                        new SalesMaster.fromJson(element),  _orderType, context),
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Icon(
                          Icons.delete_rounded,
                          color: Colors.red,
                          size: 20,
                        ),
                        Text('Cancel\nOrder', style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
                      ],
                    ),
                    onTap: () => onNo(element),
                  ),
                ],
              ),
            ],
          ),
        ],
      ));
    });
    return Column(
      children: [
        ListTile(
          tileColor: Colors.grey[200],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Sale No.',
                style: GoogleFonts.staatliches(
                  letterSpacing: 2,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500,
                  // fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Customer',
                style: GoogleFonts.staatliches(
                  letterSpacing: 2,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500,
                  // fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Contact',
                style: GoogleFonts.staatliches(
                  letterSpacing: 2,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500,
                  // fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Amount',
                style: GoogleFonts.staatliches(
                  letterSpacing: 2,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500,
                  // fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView(
              children: expansionTiles,
            ),
          ),
        ),
      ],
    );
  }

  static Future<Widget> getDeliveryOrders(
      BuildContext context,
      void onOk(Map<String, dynamic> id),
      void onNo(Map<String, dynamic> id),
      int _orderType) async {
    List<Map<String, dynamic>> data = await Config.database.rawQuery(
        "select *, IFNULL((select name from customers where ${CustomerTable.localId} = a.customer_id),'') as customer_name,IFNULL((select phone from customers where ${CustomerTable.localId} = a.customer_id),'') as contact, a.due_amount from sales_master a where a.order_type = '3' and a.paid_amount = '0.0' and a.is_delete = '0'");

    List<ExpansionTile> expansionTiles = [];
    data.forEach((element) {
      // SalesMaster salesMaster = new SalesMaster.fromJson(element);
      expansionTiles.add(ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '${element['sale_no']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${element['customer_name']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${element['contact']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${element['due_amount']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        children: [
          Column(
            children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Column(
                      children: [
                        Icon(
                          Icons.attach_money_rounded,
                          color: Colors.yellow[900],
                          size: 20,
                        ),
                        Text('Order\nPayment', style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
                      ],
                    ),
                    onTap: () => onOk(element),
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Icon(
                          Icons.edit_rounded,
                          color: Colors.grey[700],
                          size: 20,
                        ),
                        Text('Edit\nOrder', style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
                      ],
                    ),
                    onTap: () => NewSaleController().editOrder(
                        new SalesMaster.fromJson(element),  _orderType, context),
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Icon(
                          Icons.delete_rounded,
                          color: Colors.red,
                          size: 20,
                        ),
                        Text('Cancel\nOrder', style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
                      ],
                    ),
                    onTap: () => onNo(element),
                  ),
                ],
              ),
            ],
          ),
        ],
      ));
    });
    return Column(
      children: [
        ListTile(
          tileColor: Colors.grey[200],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Sale No.',
                style: GoogleFonts.staatliches(
                  letterSpacing: 2,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500,
                  // fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Customer',
                style: GoogleFonts.staatliches(
                  letterSpacing: 2,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500,
                  // fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Contact',
                style: GoogleFonts.staatliches(
                  letterSpacing: 2,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500,
                  // fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Amount',
                style: GoogleFonts.staatliches(
                  letterSpacing: 2,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w500,
                  // fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView(
              children: expansionTiles,
            ),
          ),
        ),
      ],
    );
  }

  static Future onOrderCompleted(SalesMaster itm) async {
    await Config.database.execute(
        'update ${SalesMasterTable.isDelete} set ${SalesMasterTable.paidAmount} = ${SalesMasterTable.dueAmount} where ${SalesMasterTable.serverId} = ${itm.serverId}');
  }

  static Widget getSpacer({BuildContext context, double width}) {
    return SizedBox(
      width: Config.getDeviceWidth(context) * width,
    );
  }
}
