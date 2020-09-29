import 'package:flutter/material.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/models/generic_models/customer_order.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/new_sale_model.dart';
import 'package:food_app/pages/dashboard_screen.dart';
import 'package:food_app/pages/new_sale.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';

class NewSaleController {
  NewSaleModel model;

  NewSaleController() {
    model = new NewSaleModel();
    model.lstCategory = DataLists.instance.listCategories;
    model.lstItem = DataLists.instance.listItem;
    model.order = new CustomerOrder();
  }

  void launch(BuildContext context) => Navigator.of(context)
      .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));

  void launchAndReplacement(BuildContext context) => Navigator.of(context)
      .pushReplacement(new MaterialPageRoute(builder: (context) => new NewSale(model)));

  void editOrder(SalesMaster salesMaster, BuildContext context) async{
    List<Item> updatedList = await SalesDetails().getOrderWhereMasterId(Config.database, salesMaster);
    this.model.order.setItemList = updatedList;
    this.model.salesMaster = salesMaster;
    launchAndReplacement(context);
  }

}
