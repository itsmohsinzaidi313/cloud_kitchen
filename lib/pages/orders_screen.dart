import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/models/objects/sales_master.dart';
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
  int orderType = 1;
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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: RaisedButton.icon(
                      onPressed: () {
                        setState(() {
                          orderType = 1;
                        });
                      },
                      color: AppTheme.listTextColor,
                      icon: Icon(
                        Icons.local_dining,
                      ),
                      label: Text('Dine-In'.toUpperCase()),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: RaisedButton.icon(
                      onPressed: () {
                        setState(() {
                          orderType = 2;
                        });
                      },
                      color: AppTheme.listTextColor,
                      icon: Icon(
                        Icons.directions_walk,
                      ),
                      label: Text('Takeaway'.toUpperCase()),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: RaisedButton.icon(
                      onPressed: () {
                        setState(() {
                          orderType = 3;
                        });
                      },
                      color: AppTheme.listTextColor,
                      icon: Icon(
                        Icons.directions_bike,
                      ),
                      label: Text('Delivery'.toUpperCase()),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                  child: Card(
                      child: FutureBuilder(
                          future: getOrdersList(orderType),
                          initialData: Container(
                            child: SpinKitRing(
                              color: Colors.yellow,
                            ),
                          ),
                          builder: (context, snapshot) => snapshot.data)),
                          onTap: (){
                            
                          },
            )),
          ],
        ),
      ),
    );
  }

  Future<Widget> getOrdersList(int orderType) async {
    Widget widget;
    switch (orderType) {
      case 1:
        widget = await OrderController.getDineInOrders();
        break;
      case 2:
        widget = await OrderController.getTakeAwayOrders();
        break;
      case 3:
        widget = await OrderController.getDeliveryOrders();
        break;
      default:
        break;
    }
    return widget;
  }

  List<DataColumn> getDataTableColumnsList(int orderType) {
    List<DataColumn> cols = [];
    switch (orderType) {
      case 1:
        model.dineInColumns.forEach((element) {
          cols.add(DataColumn(label: Text(element)));
        });
        break;
      case 2:
        model.takeawayAndDeliveryColumns.forEach((element) {
          cols.add(DataColumn(label: Text(element)));
        });
        break;
      case 3:
        model.takeawayAndDeliveryColumns.forEach((element) {
          cols.add(DataColumn(label: Text(element)));
        });
        break;
      default:
        break;
    }
    return cols;
  }

  List<DataRow> getDineInList(List<SalesMaster> dineIn) {
    List<DataRow> rows = [];
    dineIn.forEach((e) {
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(IconButton(icon: Icon(Icons.check), onPressed: () {})),
          DataCell(Text(e.saleNo)),
          DataCell(Text(e.tableId)),
          DataCell(Text(e.waiterId)),
          DataCell(Text(e.dueAmount)),
          DataCell(IconButton(icon: Icon(Icons.close), onPressed: () {})),
        ],
      ));
    });
    return rows;
  }

  List<DataRow> getTakeawayList(List<SalesMaster> takeaway) {
    List<DataRow> rows = [];
    takeaway.forEach((e) {
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(IconButton(icon: Icon(Icons.check), onPressed: () {})),
          DataCell(Text(e.saleNo)),
          DataCell(Text(e.customerId)),
          DataCell(Text(e.customerId)),
          DataCell(Text(e.dueAmount)),
          DataCell(IconButton(icon: Icon(Icons.close), onPressed: () {})),
        ],
      ));
    });
    return rows;
  }

  List<DataRow> getDeliveryList(List<SalesMaster> delivery) {
    List<DataRow> rows = [];
    delivery.forEach((e) {
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(IconButton(icon: Icon(Icons.check), onPressed: () {})),
          DataCell(Text(e.saleNo)),
          DataCell(Text(e.customerId)),
          DataCell(Text(e.customerId)),
          DataCell(Text(e.dueAmount)),
          DataCell(IconButton(icon: Icon(Icons.close), onPressed: () {})),
        ],
      ));
    });
    return rows;
  }

  // List<Widget> getHoldingOrderList(List<SalesMaster> sales) {
  //   List<Widget> widgets = [];
  //   sales.forEach((item) {
  //     widgets.add(
  //       InkWell(
  //         onTap: () {
  //           NewSaleController().editOrder(item, context);
  //         },
  //         child: Card(
  //           elevation: 5,
  //           child: ListTile(
  //             leading: IconButton(
  //               icon: Icon(
  //                 Icons.check,
  //                 color: Colors.green,
  //               ),
  //               onPressed: () async {
  //                 Config.database.update(
  //                     Tables.salesMaster, {Columns.salesMaster[30]: '3'},
  //                     where: '${Columns.salesMaster[0]} = ?',
  //                     whereArgs: [item.id]);
  //                 Map<String, dynamic> values = item.getValuesForUpload();
  //                 List<Map<String, dynamic>> values1 = [];
  //                 //COLUMNS
  //                 List<Map<String, dynamic>> values2 = await Config.database
  //                     .query(Tables.salesDetails,
  //                         columns: Columns.salesDetails
  //                             .getRange(1, Columns.salesDetails.length - 1)
  //                             .toList(),
  //                         where: '${Columns.salesDetails[18]} = ?',
  //                         whereArgs: [item.id]);
  //                 values['sale_details'] = values2;
  //                 values1.add(values);
  //                 Map<String, dynamic> json = new Map();
  //                 json['user_id'] = '1';
  //                 json['json'] = jsonEncode(values1);
  //                 log(
  //                   json.toString(),
  //                   name: 'Order Upload Json: ',
  //                 );
  //                 Response response =
  //                     await post(Config.addUpdateOrderApi, body: json).timeout(
  //                   Duration(seconds: 5),
  //                   onTimeout: () => null,
  //                 );
  //                 if (response != null)
  //                   log(response.body, name: 'Server Response: ');
  //                 else
  //                   log('Response Timeout', name: 'Request Timeout');
  //               },
  //             ),
  //             title: Center(child: Text(item.saleNo)),
  //             subtitle: Center(child: Text(item.totalPayable)),
  //             trailing: IconButton(
  //               icon: Icon(
  //                 Icons.close,
  //                 color: Colors.red,
  //               ),
  //               onPressed: () async {
  //                 await onOrderCancelled(item);
  //                 List<SalesMaster> list =
  //                     await SalesMaster().queryAllRows(Config.database);
  //                 setState(() {
  //                   this.model.setItemHoldList(list);
  //                 });
  //               },
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  //   return widgets;
  // }
  //
  // List<Widget> getOrderTypeList(List<String> type) {
  //   List<Widget> widgets = [];
  //   type.forEach((item) {
  //     widgets.add(
  //       InkWell(
  //         onTap: () => NewSaleController().launchAndReplacement(context),
  //         child: Container(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: 16,
  //             vertical: 2,
  //           ),
  //           height: Config.getDeviceHeight(context) * 0.25,
  //           width: Config.getDeviceWidth(context),
  //           child: Card(
  //             color: Colors.amberAccent,
  //             elevation: 5,
  //             child: Center(
  //               child: Text(
  //                 item.toUpperCase(),
  //                 style: TextStyle(
  //                   fontSize: 30,
  //                   letterSpacing: 2.0,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  //   return widgets;
  // }
  //
  // Future onOrderCancelled(SalesMaster itm) async {
  //   Database db = Config.database;
  //   Map<String, dynamic> update = {
  //     Columns.salesMaster[37]: 1.toString(),
  //   };
  //   await SalesMaster().updateSpecificIntoDb(db, update, 'id', itm.id);
  // }
  //
  // Future onOrderCompleted(SalesMaster itm) async {
  //   await Config.database.execute(
  //       'update ${Columns.salesMaster[37]} set ${Columns.salesMaster[5]} = ${Columns.salesMaster[6]} where id = ${itm.id}');
  //   OrderController().launchAndReplacement(context);
  // }
}
