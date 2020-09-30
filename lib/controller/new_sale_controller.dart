import 'package:flutter/material.dart';
import 'package:food_app/models/generic_models/customer_order.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/sales_detail.dart';
import 'package:food_app/models/objects/sales_master.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/view_models/new_sale_model.dart';
import 'package:food_app/pages/new_sale.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';

class NewSaleController {
  NewSaleModel model;
  bool _autoValidate = false;
  bool _userPhoneValidate = false;
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

  void launchDinein(BuildContext context, String orderType) {
    this.model.salesMaster = SalesMaster();
    this.model.salesMaster.orderType = orderType;
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));
  }

  void launchTakeaway(BuildContext context, String orderType) {
    this.model.salesMaster = SalesMaster();
    this.model.salesMaster.orderType = orderType;
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new NewSale(model)));
  }

  void launchDelivery(BuildContext context, String orderType) async {
    this.model.salesMaster = SalesMaster();
    this.model.salesMaster.orderType = orderType;
    Navigator.pop(context);
    await AppTheme.showAlertDialog(
      context,
      title: 'Customer Details'.toUpperCase(),
      fontSize: 20,
      fontWeight: FontWeight.bold,
      content: customerAlertDialog(),
      barrier: true
    );
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
    launchAndReplacement(context);
  }

  Widget customerAlertDialog() {
    return Wrap(
      children: [
        Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[100]))),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  controller: userName,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[100]),
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Cell No.',
                          errorText: _userPhoneValidate ? 'Please Enter Cell Phone' : null,
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: userPhone,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        // userPhone.text.isEmpty ?  _userPhoneValidate = true : _userPhoneValidate = false;
                        if(userPhone.text.isEmpty){
                         userPhone.text = 'Please Enter Phone No.';
                         return;
                        }
                        try{
                          List<Customer> customerList = await Customer().getCustomer(Config.database);
                          if(customerList.length > 0){
                            for (int i = 0; i < customerList.length; i++){
                              if(customerList[i].phone == userPhone.text){
                                this._customer = customerList[i];
                                this.model.order.customerId = customerList[i].serverId;
                                userName.text = _customer.name;
                                userPhone.text = _customer.phone;
                                userAddress.text = _customer.address;
                                break;
                              }
                            }
                          }else{
                            User cUser = Config().currentUser;
                            Customer inputFromPopup = Customer(name: userName.text,
                                phone: userPhone.text, address: userAddress.text, userId: cUser.serverId,
                              companyId: cUser.companyId, delStatus: cUser.delStatus);
                            int id = await Customer().insertCustomer(Config.database, inputFromPopup);
                            if(id > 0){
                              this.model.order.customerId = id;
                              print('Customer inserted successfully...');
                            }
                          }
                        } catch (e){
                          Config.log.e('CUSTOMER PHONE ENTER\n $e');
                        }
                      },
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[100]),
                  ),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Address',
                    labelStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.streetAddress,
                  controller: userAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Address';
                    }
                    return null;
                  },
                ),
              ),
              RaisedButton(onPressed: (){
                if(_formKey.currentState.validate()){
                  _formKey.currentState.save();
                  userPhone.text.isEmpty ? userPhone.text = 'Please Enter Cell Phone' : userPhone.text = userPhone.text;
                }
              },
                child: Text('OK'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
