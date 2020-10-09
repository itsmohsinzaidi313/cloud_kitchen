import 'package:flutter/material.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/controller/login_controller.dart';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/models/objects/shift.dart';
import 'package:food_app/models/view_models/shift_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/shared/lib.dart';

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
  TextEditingController closingAmount = TextEditingController();
  TextEditingController openingAmount = TextEditingController();
  bool checkField = false;
  String errorMessage = 'Required';

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _deviceKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _deviceKey.text = Config.authToken;
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
                        backgroundImage: AssetImage('asset/money-bag.jpg'),
                      ),
                    ),
                  ),
                ),
                bodyLayoutController(model.layoutType)
              ]),
            ),
          ),
        ),
        floatingActionButton: floatingButtonLayoutController(model.layoutType));
  }

  Widget bodyLayoutController(int layoutType) {
    switch (layoutType) {
      case 1:
        return Container(
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
                          hintText: "1000",
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
                        controller: openingAmount,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        break;
      case 2:
        return Container(
          // padding: EdgeInsets.all(10.0),
          // margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          width: Config.getDeviceWidth(context) * 0.4,
          child: Wrap(
            children: [
              Container(
                child: Card(
                  color: Colors.grey[100],
                  child: ListTile(
                    leading: Icon(
                      Icons.monetization_on,
                      color: Colors.grey[600],
                    ),
                    title: TextField(
                      keyboardType: TextInputType.number,
                      controller: closingAmount,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amberAccent, width: 1),
                          ),
                          hintText: 'Closing Amount',
                          errorText: checkField ? errorMessage : null),
                    ),
                    trailing: RaisedButton(
                      elevation: 2.0,
                      onPressed: () {
                        setState(() {
                          checkField = closingAmount.text == '' ? true : false;
                          errorMessage = 'Required.';
                        });

                        if (!checkField) {
                          double amount = double.parse(closingAmount.text);
                          if (amount > 0) {
                            Config.currentShift.closingBalance =
                                closingAmount.text;
                            Config.currentShift.closingBalanceDateTime =
                                Config.getCurrentDateTimeDBFormat();
                            Config.database.update(
                                Tables.shiftData,
                                {
                                  ShiftTable.closingBalance: closingAmount.text,
                                  ShiftTable.closingBalanceDateTime:
                                      Config.getCurrentDateTimeDBFormat(),
                                  ShiftTable.registerStatus: '2'
                                },
                                where: '${ShiftTable.localId} = ?',
                                whereArgs: [Config.currentShift.remoteId]);
                            Lib.closeRegister(Config.currentShift);
                            LoginController().pushAndRemoveUntil(context);
                          } else {
                            checkField = true;
                            errorMessage = 'Invalid Amount.';
                          }
                        }
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
                ),
              ),
            ],
          ),
        );
        break;
      default:
        return Container(
          child: Text('Invalid Layout Type'),
        );
        break;
    }
  }

  Widget floatingButtonLayoutController(int layoutType) {
    switch (layoutType) {
      case 1:
        return FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                
                DataLists.instance.listDevices.forEach((d) {
                  if (_deviceKey.text == d.deviceKey) {
                    Config.currentDevice = d;
                    Config.currentShift = Shift(
                        shift: _dropdown,
                        deviceKey: _deviceKey.text.trim(),
                        openingBalance: openingAmount.text.trim(),
                        userId: Config.currentUser.serverId,
                        openingBalanceDateTime:
                            Config.getCurrentDateTimeDBFormat(),
                        outletId: Config.currentUser.outletId,
                        companyId: Config.currentUser.companyId,
                        registerStatus: '1',
                        closingBalance: '0',
                        closingBalanceDateTime: '0',
                        isUpload: '0'
                    );

                    Shift().getNextShiftRemoteId(Config.database).then((value) {
                      if (value > 0) {
                        Config.currentShift.remoteId = value.toString();
                        Config.currentShift.registerNo = Lib.codeGenerator(
                            'REG', int.parse(value.toString()));
                        Config.database
                            .insert(ShiftTable.tableName,
                                Config.currentShift.toMap(Config.currentShift))
                            .then((value) {
                          if (value > 0)
                            AppTheme.showAlertDialogOK(context,
                                title: 'Success',
                                message:
                                    'Shift# ${Config.currentShift.registerNo} opened successfully.',
                                onOK: () => DashboardController(context)
                                    .pushAndRemoveUntil(context));
                          else
                            AppTheme.showAlertDialogOK(context,
                                title: 'Error',
                                message:
                                    'Your request is not accepted by Server. Please Try Again!',
                                onOK: () => Navigator.of(context).pop());
                        });
                      }
                    });
                  } else {
                    Config.log.e('Device not found');
                  }
                });
              } else {
                _autoValidate = true;
              }
            });
          },
          child: Icon(Icons.check),
          backgroundColor: Colors.yellow[600],
        );
        break;
      case 2:
        return FloatingActionButton(
          onPressed: () {
            try {
              setState(() {
                checkField = closingAmount.text == '' ? true : false;
                errorMessage = 'Required.';
              });

              if (!checkField) {
                double amount = double.parse(closingAmount.text);
                if (amount > 0) {

                  ///UPDATING THE SHIFT OBJECT IN CONFIG
                  Config.currentShift.closingBalance = closingAmount.text;
                  Config.currentShift.closingBalanceDateTime =
                      Config.getCurrentDateTimeDBFormat();
                  Config.currentShift.registerStatus = '2';

                  ///UPDATING SHIFT IN THE DATABASE
                  Config.database.update(ShiftTable.tableName, {
                    ShiftTable.closingBalance : Config.currentShift.closingBalance,
                    ShiftTable.closingBalanceDateTime : Config.currentShift.closingBalanceDateTime,
                    ShiftTable.registerStatus : Config.currentShift.registerStatus
                  }, where: '${ShiftTable.localId} = ${Config.currentShift.remoteId}').then((value) {
                    if (value > 0)
                      AppTheme.showAlertDialogOK(context,
                          title: 'Success',
                          message:
                          'Shift# ${Config.currentShift.registerNo} closed successfully.',
                          onOK: () => LoginController().pushAndRemoveUntil(context));
                    else
                      AppTheme.showAlertDialogOK(context,
                          title: 'Error',
                          message:
                          'Something went wrong. Please Try Again!',
                          onOK: () => Navigator.of(context).pop());
                  });

                  // LoginController().pushAndRemoveUntil(context);

                } else {
                  checkField = true;
                  errorMessage = 'Invalid Amount.';
                }
              }
            } catch (e) {
              Config.log.e(e);
            }
          },
          child: Icon(Icons.close),
          backgroundColor: Colors.yellow[600],
        );
        break;
      default:
        return Container();
        break;
    }
  }
}
