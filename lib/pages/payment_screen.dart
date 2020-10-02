import 'package:flutter/material.dart';
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
  _PaymentScreenState(this.model);
  PaymentMethod selectedPayment;
  List<TextEditingController> controllers = [
    new TextEditingController(),
    new TextEditingController()
  ];
  List<bool> check = [false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: Config.getDeviceWidth(context) * 0.5,
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: DropdownButton<PaymentMethod>(
                    hint: Text("Select Payment Method"),
                    value: selectedPayment,
                    onChanged: (PaymentMethod payment) {
                      // setState(() {
                      selectedPayment.name = payment.name;
                      // });
                    },
                    items: model.paymentMethodList.map((PaymentMethod payment) {
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
                SizedBox(
                  height: 100,
                ),
                Container(
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.monetization_on),
                      title: TextField(
                        keyboardType: TextInputType.number,
                        controller: controllers[0],
                        decoration: InputDecoration(
                            hintText: 'Amount',
                            errorText: check[0] ? 'Required' : null),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.credit_card),
                      title: TextField(
                        keyboardType: TextInputType.number,
                        controller: controllers[1],
                        decoration: InputDecoration(
                            hintText: 'Credit Number',
                            errorText: check[1] ? 'Required' : null),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    PaymentController.uploadOrder(model.map);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
