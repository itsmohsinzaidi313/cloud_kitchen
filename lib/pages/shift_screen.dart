import 'package:flutter/material.dart';
import 'package:food_app/pages/dashboard_screen.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShiftScreen extends StatefulWidget {
  @override
  _ShiftScreen createState() => _ShiftScreen();
}

class _ShiftScreen extends State<ShiftScreen> {
  String _dropdown = 'Morning';
  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _amount = TextEditingController();

  List<String> _shiftList = ['Morning', 'Evening', 'Night'];

  Future onAmountEntered() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final df = new DateFormat('dd-MM-yyyy hh:mm a');
    String date = df.format(DateTime.now());
    print(
        'Dropdown value : $_dropdown\n Amount : ${_amount.text}\n Date : $date');
    int regRow = 0;
    print('Shift return $regRow');
    await _sharedPreferences.setInt('regId', regRow);
    Navigator.of(context).pushReplacementNamed('/dbd', arguments: {
      'shiftId': _sharedPreferences.getInt('shiftId'),
    });
  }

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
                                    items: _shiftList.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )),
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
            // if (_formKey.currentState.validate()) {
            //   _formKey.currentState.save();
            //   onAmountEntered();
            // } else {
            //   _autoValidate = true;
            // }
            AppTheme.timerWithNavigation(context, 0, Dashboard());
          });
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.yellow[600],
      ),
    );
  }
}
