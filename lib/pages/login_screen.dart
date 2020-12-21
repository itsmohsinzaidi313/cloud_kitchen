import 'package:flutter/material.dart';
import 'package:food_app/bloc/dialog_message_bloc.dart';
import 'package:food_app/controller/dashboard_controller.dart';
import 'package:food_app/controller/login_controller.dart';
import 'package:food_app/controller/shift_controller.dart';
import 'package:food_app/database/table_object/setting_detail_table.dart';
import 'package:food_app/database/table_object/shift_table.dart';
import 'package:food_app/models/objects/device.dart';
import 'package:food_app/models/objects/setting_detail.dart';
import 'package:food_app/models/objects/shift.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/view_models/login_model.dart';
import 'package:food_app/shared/app_theme.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:google_fonts/google_fonts.dart';
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

  // bool isLogin = false;
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

  @override
  Widget build(BuildContext context) {
    if (deviceKey.text.isNotEmpty) {
      setState(() {
        _deviceKeyPresent = true;
      });
    }
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            Config.activeStatus,
                                            style: GoogleFonts.ubuntuCondensed(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                letterSpacing: 1.0,
                                                color: activeColor),
                                          ),
                                          Switch(
                                            value: Config.isSwitched,
                                            onChanged: _onSwitchTap,
                                            activeTrackColor:
                                                Colors.yellowAccent[600],
                                            activeColor: Colors.yellow[700],
                                            inactiveTrackColor:
                                                Colors.grey[200],
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
                                                ? _onSubmit
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

  void _verifyingDeviceKey() {
    bool _isFirstTime;
    setSharedPreferences().whenComplete(() {
      getSharedPreferences().then((value) {
        if (value == null)
          setSharedPreferences();
        else if (value)
          _isFirstTime = value;
        else
          _isFirstTime = value;
      });
    });

    Config.database
        .query(ShiftTable.tableName,
            columns: [ShiftTable.deviceKey],
            orderBy: '${ShiftTable.localId} desc')
        .then((value) {
      try {
        if (value.isNotEmpty) {
          String dKey = value[0][ShiftTable.deviceKey] == null
              ? ''
              : value[0][ShiftTable.deviceKey];
          if (dKey.isNotEmpty) {
            setState(() {
              deviceKey.text = dKey;
              Config.authToken = dKey;
              _deviceKeyPresent = true;
              Config.installApi = dKey;
            });
            if (_isFirstTime) {
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
              LoginController.loadData(_bloc).then((value) {
                if (value)
                  _deviceKeyPresent = value;
                else {
                  progressDialog.hide();
                  AppTheme.showToast('Cannot Access Server!', context);
                  // _bloc.dispose();
                }
              }).whenComplete(() {
                if (DataLists.instance.listDevices.isNotEmpty) {
                  DataLists.instance.listDevices.forEach((element) {
                    if (dKey == element.deviceKey) {
                      setState(() {
                        Config.currentDevice = element;
                      });
                      progressDialog.hide();
                    }
                  });
                } else {
                  AppTheme.showToast('Cannot Access Server!', context);
                }
              });
            }
          } else {
            progressDialog.hide();
            setState(() {
              _deviceKeyPresent = false;
            });
          }
        }
      } catch (e) {
        progressDialog.hide();
        _log.e(e);
      }
    }).catchError((onError) {
      // progressDialog.hide();
      setState(() {
        _deviceKeyPresent = false;
      });
    });
    // }
  }

  void _onSubmit() {
    ProgressDialog progressDialog = AppTheme.showProgressDialog(
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
    setState(() {
      _deviceKeyCheck = deviceKey.text == '' ? false : true;
    });
    if (_deviceKeyCheck) {
      setState(() {
        Config.authToken = deviceKey.text;
        Config.installApi = deviceKey.text;
      });
      LoginController.loadData(_bloc).then((value) {
        if (value) {
          DataLists.instance.listDevices.forEach((element) {
            if (deviceKey.text == element.deviceKey) {
              setState(() {
                Config.currentDevice = element;
                _deviceKeyPresent = true;
              });
            }
            setSharedPreferences();
            progressDialog.hide();
          });
        } else {
          // _bloc.dispose();
          progressDialog.hide();
          AppTheme.showAlertDialogOK(context,
              title: 'Attention',
              message:
                  'Unable to load data.\nMake sure you have an internet connection\nand try again.',
              onOK: () => Navigator.of(context).pop());
        }
      });
    } else {
      // _bloc.dispose();
      progressDialog.hide();
    }
  }

  Future<User> validateUser(email, pass) async {
    User _user;
    List<User> listUser = DataLists.instance.listUsers;
    if (listUser.isEmpty) {
      User user1 = await User().getUserByLogin(email, pass);
      if (user1 != null) {
        Config.currentUser = user1;
        Device device =
            await Device().getDeviceById(int.tryParse(user1.outletId));
        if (device != null) {
          Config.currentDevice = device;
        } else {
          print('Device found NaN');
        }
        print(Config.currentUser.serverId);
        setState(() {
          _user = user1;
        });
      }
    } else {
      for (int i = 0; i < listUser.length; i++) {
        if (listUser[i].emailAddress == email && listUser[i].password == pass) {
          Config.currentUser = listUser[i];
          print(Config.currentUser.serverId);
          setState(() {
            _user = listUser[i];
          });
          break;
        }
      }
    }
    return _user;
  }

  Future<bool> getSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstTime = _sharedPreferences.getBool('isFirstTime') ?? false;
    if (isFirstTime) return isFirstTime;
    return false;
  }

  Future setSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    bool value = (await getSharedPreferences() ?? false) ? true : false;
    await _sharedPreferences.setBool('isFirstTime', value);
    // await _sharedPreferences.setInt('userId', user[0]['id']);
  }

  void onButtonTap() async {
    ProgressDialog progressDialog1 = AppTheme.showProgressDialog(context,
        widget: Center(
          child: Text('Loading..'),
        ));
    await progressDialog1.show();
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
        _formKey.currentState.save();
        email.text = email.text.trim();
        password.text = password.text.trim();
        Config.authToken = deviceKey.text;
      });

      User user = await validateUser(email.text, password.text);
      if (user != null) {
        int status = Config.isSwitched ? 1 : 0;
        SettingDetail settingDetail = await SettingDetail()
            .getUserSettingById(int.tryParse(user.serverId));
        if (settingDetail != null && settingDetail.registerStatus == 0) {
          settingDetail.loginStatus = 0;
          int res1 = await SettingDetail().updateSettingDetail(
              settingDetail: settingDetail,
              where: '${SettingDetailTable.id} = ?',
              whereArgs: [settingDetail.id]);
          if (res1 > 0) {
            Shift().getShiftByUserId(settingDetail.userId).then((value) async {
              if (value != null) {
                Config.currentShift = value;
                await progressDialog1.hide();
                DashboardController(context).launchAndReplacement();
              } else {
                await progressDialog1.hide();
                print('No Shift Found..');
              }
            });
          } else {
            await progressDialog1.hide();
            print('Setting did not inserted');
          }
        } else {
          int res = await SettingDetail().insertSettingDetail(
              settingDetail: SettingDetail(
                  userId: int.tryParse(user.serverId),
                  loginStatus: 0,
                  shiftId: 0,
                  connectionStatus: status));
          if (res > 0) {
            await progressDialog1.hide();
            ShiftController(1).launch(context);
          } else {
            await progressDialog1.hide();
            print('Setting did not inserted');
          }
        }
      } else {
        await progressDialog1.hide();
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('Invalid email or password')));
      }
      // }
    } else {
      await progressDialog1.hide();
      setState(() {
        isLoading = false;
        _autoValidate = true;
      });
    }
  }

  void _onSwitchTap(bool value) {
    setState(() {
      Config.isSwitched = value;
      if (Config.isSwitched) {
        activeColor = Colors.yellow[700];
        Config.activeStatus = 'Online';
      } else {
        activeColor = Colors.grey;
        Config.activeStatus = 'Offline';
      }
      print(Config.isSwitched);
    });
  }
}
