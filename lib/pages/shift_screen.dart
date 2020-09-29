import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/models/objects/shift.dart';
import 'package:food_app/models/view_models/shift_model.dart';
import 'package:food_app/shared/config.dart';

class ShiftScreen extends StatefulWidget {
  final ShiftModel model;
  ShiftScreen(this.model);
  @override
  _ShiftScreen createState() => _ShiftScreen(this.model);
}

class _ShiftScreen extends State<ShiftScreen> {
  final ShiftModel model;
  _ShiftScreen(this.model);
  String _dropdown = 'Morning';
  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _amount = TextEditingController();
  TextEditingController _deviceKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Shift'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 90.0,
                    backgroundColor: Colors.yellow[600],
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-vector/money-bag_16734-108.jpg'),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Select Shift',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        ),
                                      )),
                                  DropdownButton<String>(
                                    value: _dropdown,
                                    icon: Icon(Icons.arrow_drop_down_circle),
                                    iconSize: 24,
                                    elevation: 16,
                                    isExpanded: true,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _dropdown = newValue;
                                      });
                                    },
                                    items: this.model.shiftList,
                                  ),
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Device Key",
                                prefixIcon: Icon(
                                  Icons.device_unknown,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey[300],
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).unfocus();
                              },
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.length < 0 ||
                                    int.parse(value) <= 0) {
                                  return 'Invalid Device Key';
                                }
                                return null;
                              },
                              controller: _deviceKey,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Amount",
                                prefixIcon: Icon(
                                  Icons.attach_money,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                hintText: "10,000",
                                hintStyle: TextStyle(
                                  color: Colors.grey[300],
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).unfocus();
                              },
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.length < 0 ||
                                    int.parse(value) <= 0) {
                                  return 'Invalid Amount';
                                }
                                return null;
                              },
                              controller: _amount,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {

            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
            Config().currentShift = Shift(
                shift: _dropdown, deviceKey: _deviceKey.text, openingBalance: _amount.text,
              userId: Config().currentUser.serverId, openingBalanceDateTime: Config.getCurrentDateTime(),
              outletId: Config().currentUser.outletId, companyId: Config().currentUser.companyId,
              registerStatus: 'false');

            Shift().insertSpecificIntoDatabase(Config.database, Config().currentShift)
                .whenComplete(() => DashboardController(context).launch());
            }else{
              _autoValidate = true;
            }
          });
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.yellow[600],
      ),
    );
  }
}
