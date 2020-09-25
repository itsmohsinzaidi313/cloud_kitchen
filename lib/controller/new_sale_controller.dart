import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/generic_models/customer_order.dart';
import 'package:food_app/models/view_models/new_sale_model.dart';
import 'package:food_app/pages/new_sale.dart';
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
      .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));
}
