import 'package:flutter/material.dart';
import 'package:food_app/bloc/dialog_message_bloc.dart';
import 'package:food_app/bloc/dialog_message_event.dart';
import 'package:food_app/controller/shift_controller.dart';
import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/view_models/login_model.dart';
import 'package:food_app/pages/sql_view_page.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/shared/lib.dart';
import 'package:logger/logger.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final LoginModel loginModel;

  LoginScreen(this.loginModel);

  @override
  _LoginScreenState createState() => _LoginScreenState(this.loginModel);
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginModel loginModel;

  _LoginScreenState(this.loginModel);

  Logger _log = Config.log;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController deviceKey = TextEditingController();

  final DialogMessageBloc _bloc = new DialogMessageBloc();

  bool _autoValidate = false;
  bool _obscureText = true;
  bool isLoading = false;
  bool isLogin = false;
  bool _deviceKeyPresent = false;
  bool _deviceKeyCheck = false;
  Icon _icon = Icon(Icons.visibility_off);

  String errorEmail = 'Invalid Email', errorPassword = 'Invalid Password';

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _icon =
          _obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences _sharedPreferences;
  ProgressDialog progressDialog;

  @override
  initState() {
    super.initState();
      Config.database
          .query(ShiftTable.tableName,
          columns: [ShiftTable.deviceKey],
          orderBy: '${ShiftTable.localId} desc')
          .then((value) {
        setState(() {
          try {
            if (value.isNotEmpty) {
              String dKey = value[0][ShiftTable.deviceKey] == null
                  ? ''
                  : value[0][ShiftTable.deviceKey];
              if (dKey.isNotEmpty) {
                _deviceKeyPresent = dKey == '' ? false : true;
                deviceKey.text = dKey;
                Config.authToken = dKey;
                Config.installApi = dKey;
                progressDialog =
                    AppTheme
                        .showProgressDialog(
                      context,
                      widget: StreamBuilder(
                        initialData:
                        Text('Loading...'),
                        stream: _bloc.message,
                        builder: (context,
                            snapshot) {
                          return snapshot.data;
                        },
                      ),
                    );
                progressDialog.show();
                loadData(_bloc)
                    .then((value) => _deviceKeyPresent = value)
                    .whenComplete(() {
                  // setState(() {
                  // DataLists.instance.listDevices.where((element) => dKey == element.deviceKey);
                  DataLists.instance.listDevices.forEach((element) {
                    if (dKey == element.deviceKey) {
                      Config.currentDevice = element;
                      progressDialog.hide();
                    }
                  });
                  // });
                });
              } else {
                dispose();
                progressDialog.hide();
                _deviceKeyPresent = false;
              }
            }
          } catch (e) {
            dispose();
            progressDialog.hide();
            _deviceKeyPresent = false;
            _log.e(e);
          }
        });
      }).catchError((onError) {
        dispose();
        progressDialog.hide();
        _deviceKeyPresent = false;
      });

  }

  Future<bool> loadData(DialogMessageBloc bloc) async {
    bool value1 = await Lib.install(bloc);
    if (value1) {
      bool value2 = await DataLists.importToDatabase(Config.database, bloc);
      if (value2) {
        _log.w('Online data loaded');
        return true;
      } else {
        _log.w('Online data load failed');
        return false;
      }
    } else {
      bool value2 = await DataLists.importToMemory(Config.database, bloc);
      if (value2) {
        _log.w('Offline data loaded');
        return true;
      } else {
        _log.w('Offline data load failed');
        return false;
      }
    }
  }

  bool validateUser(email, pass) {
    List<User> listUser = DataLists.instance.listUsers;
    bool valid = false;
    for (int i = 0; i < listUser.length; i++) {
      if (listUser[i].emailAddress == email && listUser[i].password == pass) {
        Config.currentUser = listUser[i];
        print(Config.currentUser.serverId);
        setState(() {
          valid = true;
        });
        break;
      }
    }
    return valid;
  }

  Future getSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    bool isLogin = _sharedPreferences.getBool('isLogin') ?? false;
    if (isLogin == true) {
      Navigator.pushReplacementNamed(context, '/r', arguments: {
        'id': _sharedPreferences.getInt('userId'),
      });
    }
  }

  Future setSharedPreferences(user) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setBool('isLogin', true);
    await _sharedPreferences.setInt('userId', user[0]['id']);
  }

  void onButtonTap() {
    if (false) {
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => SqlView()));
    } else {
      setState(() {
        if (_formKey.currentState.validate()) {
          isLoading = true;
          _formKey.currentState.save();
          email.text = email.text.trim();
          password.text = password.text.trim();
          Config.authToken = deviceKey.text;
          validateUser(email.text, password.text)
              ? ShiftController(1).launch(context)
              : _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text('Invalid email or password')));
          // }
        } else {
          isLoading = false;
          _autoValidate = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Container(
                // margin: EdgeInsets.all(8.0),
                height: Config.getDeviceHeight(context),
                width: Config.getDeviceWidth(context),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: Config.getDeviceHeight(context),
                      width: Config.getDeviceWidth(context) * 0.4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            // Colors.yellowAccent,
                            // Colors.yellow,
                            // Colors.amberAccent,
                            Colors.amber,
                            Colors.redAccent,
                            // Colors.indigo,
                            // Colors.indigoAccent,
                            // Colors.redAccent,
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        // borderRadius: new BorderRadius.horizontal(
                        //     right: new Radius.circular(250)),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.horizontal(
                          right:
                              Radius.circular(Config.getDeviceHeight(context)),
                        ),
                        color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/logo1.png',
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(10, 10),
                                        color: Colors.grey[300],
                                        blurRadius: 20),
                                    BoxShadow(
                                        offset: Offset(-10, -10),
                                        color: Colors.grey[300],
                                        blurRadius: 20)
                                  ],
                                ),
                                child: Form(
                                  key: _formKey,
                                  autovalidate: _autoValidate,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[100]))),
                                              child: TextField(
                                                enabled: !_deviceKeyPresent,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: 'Device Key',
                                                  labelStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                  ),
                                                  errorText:
                                                      deviceKey.text != ''
                                                          ? null
                                                          : 'Required',
                                                ),
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: deviceKey,
                                              ),
                                            ),
                                          ),
                                          FlatButton(
                                            child: Text('SUBMIT'),
                                            onPressed: !_deviceKeyPresent
                                                ? () {
                                                    ProgressDialog
                                                        progressDialog =
                                                        AppTheme
                                                            .showProgressDialog(
                                                      context,
                                                      widget: StreamBuilder(
                                                        initialData:
                                                            Text('Loading...'),
                                                        stream: _bloc.message,
                                                        builder: (context,
                                                            snapshot) {
                                                          return snapshot.data;
                                                        },
                                                      ),
                                                    );
                                                    progressDialog.show();
                                                    _deviceKeyCheck =
                                                        deviceKey.text == ''
                                                            ? false
                                                            : true;
                                                    if (_deviceKeyCheck) {
                                                      Config.authToken =
                                                          deviceKey.text;
                                                      Config.installApi =
                                                          deviceKey.text;
                                                      loadData(_bloc).then((value) {
                                                        if (value) {
                                                          DataLists.instance
                                                              .listDevices
                                                              .forEach(
                                                                  (element) {
                                                            if (deviceKey
                                                                    .text ==
                                                                element
                                                                    .deviceKey) {
                                                              setState(() {
                                                                Config.currentDevice =
                                                                    element;
                                                                _deviceKeyPresent =
                                                                    true;
                                                              });
                                                            }
                                                            progressDialog
                                                                .hide();
                                                          });
                                                        } else {
                                                          dispose();
                                                          progressDialog.hide();
                                                          AppTheme.showAlertDialogOK(
                                                              context,
                                                              title:
                                                                  'Attention',
                                                              message:
                                                                  'Unable to load data.\nMake sure you have an internet connection\nand try again.',
                                                              onOK: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop());
                                                        }
                                                      });
                                                    } else {
                                                      dispose();
                                                      progressDialog.hide();
                                                    }
                                                  }
                                                : null,
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[100]))),
                                        child: TextFormField(
                                          enabled: _deviceKeyPresent,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: loginModel.hintEmail,
                                            labelStyle: TextStyle(
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          onFieldSubmitted: (value) {
                                            FocusScope.of(context).nextFocus();
                                          },
                                          validator: (value) {
                                            if (value.isEmpty ||
                                                !value.contains('@')) {
                                              return errorEmail;
                                            }
                                            return null;
                                          },
                                          controller: email,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                              child: TextFormField(
                                                enabled: _deviceKeyPresent,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText:
                                                      loginModel.hintPassword,
                                                  labelStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                                obscureText: _obscureText,
                                                textInputAction:
                                                    TextInputAction.done,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                onFieldSubmitted: (value) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                controller: password,
                                                validator: (value) {
                                                  if (value.isEmpty ||
                                                      value.length <= 0) {
                                                    return errorPassword;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Positioned(
                                              right: 5,
                                              child: IconButton(
                                                icon: _icon,
                                                onPressed: _toggle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              // isLoading
                              //     ? AppTheme.circularProgressIndicator(
                              //         Colors.redAccent)
                              //     : SizedBox(
                              //         height: 0,
                              //       ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.redAccent,
                                      Colors.amber,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(10, 10),
                                        color: Colors.grey[300],
                                        blurRadius: 20),
                                    BoxShadow(
                                        offset: Offset(-10, -10),
                                        color: Colors.grey[300],
                                        blurRadius: 20)
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.yellow[100],
                                    onTap:
                                        _deviceKeyPresent ? onButtonTap : null,
                                    child: Center(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
