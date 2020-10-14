import 'package:flutter/material.dart';
import 'package:food_app/models/generic_models/customer_order.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/view_models/new_sale_model.dart';
import 'package:food_app/pages/new_sale.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';

class NewSaleController {
  NewSaleModel model;
  bool _autoValidate = false;
  Customer _customer;

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userAddress = TextEditingController();

  NewSaleController() {
    model = new NewSaleModel();
    model.lstCategory = DataLists.instance.listCategories;
    model.lstItem = DataLists.instance.listItem;
    model.order = new CustomerOrder();
  }

  void launch(BuildContext context) => Navigator.of(context)
      .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));

  void launchDineIn(BuildContext context, String orderType, String orderTableId,
      String waiterId, List<String> titleStrings) {
    this.model.salesMaster = SalesMaster();
    this.model.salesMaster.orderType = orderType;
    this.model.order.orderTableId = orderTableId;
    this.model.order.waiterId = waiterId;

    this.model.leadingString = titleStrings[0];
    this.model.titleString = titleStrings[1];
    this.model.trailingString = titleStrings[2];

    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));
  }

  void launchTakeaway(BuildContext context, String orderType, String customerId,
      List<String> titleStrings) {
    this.model.salesMaster = SalesMaster();
    this.model.salesMaster.orderType = orderType;
    this.model.order.customerId = customerId;

    this.model.leadingString = titleStrings[0];
    this.model.titleString = titleStrings[1];
    this.model.trailingString = titleStrings[2];

    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));
  }

  void launchDelivery(BuildContext context, String orderType, String customerId,
      List<String> titleStrings) async {
    this.model.salesMaster = SalesMaster();
    this.model.salesMaster.orderType = orderType;
    this.model.order.customerId = customerId;

    this.model.leadingString = titleStrings[0];
    this.model.titleString = titleStrings[1];
    this.model.trailingString = titleStrings[2];

    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));
  }

  void launchAndReplacement(BuildContext context) =>
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new NewSale(model)));

  void editOrder(SalesMaster salesMaster, BuildContext context) async {
    List<Item> updatedList = await SalesDetails()
        .getOrderWhereMasterId(Config.database, salesMaster);
    this.model.order.setItemList = updatedList;
    this.model.salesMaster = salesMaster;
    this.model.order.customerId = salesMaster.customerId;
    this.model.leadingString = '';
    this.model.titleString = '';
    this.model.trailingString = '';
    launchAndReplacement(context);
  }
}
