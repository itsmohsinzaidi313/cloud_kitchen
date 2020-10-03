import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/controller/payment_controller.dart';
import 'package:food_app/models/objects/payment_method.dart';
import 'package:food_app/models/view_models/payment_view_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';

class PaymentScreen extends StatefulWidget {
  PaymentViewModel model;

  PaymentScreen(this.model);

  @override
  _PaymentScreenState createState() => _PaymentScreenState(model);
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentViewModel model;

  _PaymentScreenState(this.model) {}
  PaymentMethod selectedPayment;
  List<TextEditingController> controllers = [
    new TextEditingController(),
    new TextEditingController()
  ];
  List<bool> check = [false, false];
  String _type;

  @override
  void initState() {
    super.initState();
    _type = '0';
  }

  @override
  Widget build(BuildContext context) {
    controllers[0].text = model.map['due_amount'];
    // selectedPayment = model.paymentMethodList[0];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            width: Config.getDeviceWidth(context) * 0.5,
            child: Column(
              children: [
                Text(
                  'Payment'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Net Amount: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        // letterSpacing: 2.0,
                      ),
                    ),
                    Text(
                      model.map['due_amount'],
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        // letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    color: Colors.grey[100],
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<PaymentMethod>(
                        isExpanded: true,
                        hint: Center(child: Text("Select Your Payment Method")),
                        value: selectedPayment,
                        onChanged: (PaymentMethod payment) {
                          setState(() {
                            selectedPayment = payment;
                            _type = payment.serverId;
                          });
                        },
                        items: model.paymentMethodList
                            .map((PaymentMethod payment) {
                          return DropdownMenuItem<PaymentMethod>(
                            value: payment,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.style,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  payment.name,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                getWidget(_type),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 0.0,
                    onPressed: () {
                      setState(() {
                        check[0] = controllers[0].text == '' ? true : false;
                        check[1] = controllers[1].text == '' ? true : false;
                        AppTheme.showAlertDialogYN(
                          context,
                          title: 'Question',
                          message: 'Are you sure?',
                          onYes: () {
                            if (!check[0] || !check[1]) {
                              PaymentController.uploadOrder(model.map);
                              DashboardController(context).launchAndReplacement();
                            }
                          },
                          onNo: () => Navigator.pop(context),
                        );
                      });
                    },
                    color: AppTheme.listTextColor,
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // fontStyle: FontStyle.italic,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getWidget(String type) {
    if (type == '2') {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Card(
          color: Colors.grey[100],
          child: ListTile(
            leading: Icon(
              Icons.credit_card,
              color: Colors.grey,
            ),
            title: TextField(
              keyboardType: TextInputType.number,
              controller: controllers[1],
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amberAccent, width: 1),
                  ),
                  hintText: 'Credit Number',
                  errorText: check[1] ? 'Required' : null),
            ),
          ),
        ),
      );
    } else if (type == '1') {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Card(
          color: Colors.grey[100],
          child: ListTile(
            leading: Icon(Icons.monetization_on, color: Colors.grey),
            title: TextField(
              keyboardType: TextInputType.number,
              controller: controllers[0],
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amberAccent, width: 1),
                  ),
                  hintText: 'Amount',
                  errorText: check[0] ? 'Required' : null),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 40,
      );
    }
  }
}
