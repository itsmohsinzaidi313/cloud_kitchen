import 'package:flutter/material.dart';
import 'package:food_app/bloc/dialog_message_bloc.dart';
import 'package:food_app/controller/login_controller.dart';
import 'package:food_app/controller/shift_controller.dart';
import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/models/objects/shift.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/view_models/login_model.dart';
import 'package:food_app/pages/sql_view_page.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

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

  bool _autoValidate = false, _isSwitched = true;
  bool _obscureText = true;
  bool isLoading = false;
  bool isLogin = false;
  bool _deviceKeyPresent = false;
  bool _deviceKeyCheck = false;
  Icon _icon = Icon(Icons.visibility_off);
  String errorEmail = 'Invalid Email', errorPassword = 'Invalid Password';
  Color activeColor = Colors.yellow[700];

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _icon =
          _obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility);
    });
  }

  @override
  void dispose() {
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
      _verifyingDeviceKey();
  }

  void _verifyingDeviceKey(){
    if(Config.currentDevice != null){
      deviceKey.text = Config.currentDevice.deviceKey;
      _deviceKeyPresent = true;
    }
    if(Config.isLogin){
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
                progressDialog = AppTheme.showProgressDialog(
                  context,
                  widget: StreamBuilder(
                    initialData: Text('Loading...'),
                    stream: _bloc.message,
                    builder: (context, snapshot) {
                      return snapshot.data;
                    },
                  ),
                );
                progressDialog.show();
                LoginController.loadData(_bloc)
                    .then((value) {
                  if(value) _deviceKeyPresent = value;
                  else{
                    progressDialog.hide();
                    AppTheme.showToast('Cannot Access Server!', context);
                    // _bloc.dispose();
                  }
                }).whenComplete(() {
                  if(DataLists.instance.listDevices.isNotEmpty){
                    DataLists.instance.listDevices.forEach((element) {
                      if (dKey == element.deviceKey) {
                        Config.currentDevice = element;
                        progressDialog.hide();
                      }
                    });
                  }else{
                    AppTheme.showToast('Cannot Access Server!', context);
                  }
                });
              } else {
                progressDialog.hide();
                _deviceKeyPresent = false;
              }
            }
          } catch (e) {
            progressDialog.hide();
            _log.e(e);
          }
        });
      }).catchError((onError) {
        // progressDialog.hide();
        _deviceKeyPresent = false;
      });
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

  void _onSwitchTap(bool value){
    setState(() {
      _isSwitched = value;
      if(_isSwitched){
        activeColor = Colors.yellow[700];
        Config.activeStatus = 'Online';
      }  else{
        activeColor = Colors.grey;
        Config.activeStatus = 'Offline';
      }
      print(_isSwitched);
    });
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
                            Colors.amber,
                            Colors.redAccent,
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
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
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            Config.activeStatus,
                                            style: GoogleFonts.ubuntuCondensed(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              letterSpacing: 1.0,
                                              color: activeColor
                                            ),
                                          ),
                                          Switch(
                                            value: _isSwitched,
                                            onChanged: _onSwitchTap,
                                            activeTrackColor: Colors.yellowAccent[600],
                                            activeColor: Colors.yellow[700],
                                            inactiveTrackColor: Colors.grey[200],
                                            inactiveThumbColor: Colors.grey,
                                          ),
                                        ],
                                      ),
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
                                                      LoginController.loadData(
                                                              _bloc)
                                                          .then((value) {
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
                                                          // _bloc.dispose();
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
                                                      // _bloc.dispose();
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
                                                color: Colors.grey,
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
