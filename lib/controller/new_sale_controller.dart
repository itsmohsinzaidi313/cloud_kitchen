import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/generic_models/customer_order.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/new_sale_model.dart';
import 'package:food_app/pages/new_sale.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';

class NewSaleController {
  NewSaleModel model;
  NewSaleController() {
    model = new NewSaleModel();
    model.lstCategory = DataLists.onlineInstance.listCategories;
    model.lstItem = DataLists.onlineInstance.listItem;
    model.order = new CustomerOrder();
  }

  void launch(BuildContext context) => Navigator.of(context)
      .pushReplacement(new MaterialPageRoute(builder: (context) => new NewSale(model)));

  void editOrder(SalesMaster salesMaster, BuildContext context) async{
    List<Item> updatedList = await SalesDetails().getOrderWhereMasterId(Config.database, salesMaster);
    this.model.order.setItemList = updatedList;
    launch(context);
  }
}
