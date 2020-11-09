import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/bloc/dialog_message_bloc.dart';
import 'package:food_app/models/view_models/login_model.dart';
import 'package:food_app/pages/login_screen.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/data_lists.dart';
import 'package:food_app/shared/lib.dart';
import 'package:logger/logger.dart';

class LoginController {
  LoginModel model;
  LoginController() {
    model = LoginModel();
    this.model.imageUrl =
        'https://image.freepik.com/free-photo/hands-holding-burger-yellow-background_23-2148258479.jpg';
    this.model.hintEmail = 'Enter Email';
    this.model.hintPassword = 'Enter Password';
    this.model.loginButtonText = 'Login';
  }

  void launch(BuildContext context) => Navigator.pushReplacement(
      context, new MaterialPageRoute(builder: (context) => LoginScreen(model)));

  void pushAndRemoveUntil(BuildContext context) =>
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen(model)),
          (route) => false);

  static Future<bool> loadData(DialogMessageBloc bloc) async {

    DataLists.instance.getInList().forEach((element) {
      if (element.isNotEmpty) element.clear();
    });
    ///Manually data loading
    if(Config.activeStatus == 'Online'){
      bool value1 = await Lib.install(bloc);
      if(value1){
        Config.currentDevice = DataLists.instance.listDevices.where((element) => element.deviceKey == Config.authToken).first;
        bool value2 = await DataLists.importToDatabase(Config.database, bloc);
        if (value2) {
          Config.log.w('Online data loaded');
          return true;
        } else {
          Config.log.w('Online data load failed');
          return false;
        }
      } else {
        Config.log.w('Cannot access server');
        return false;
      }
    }else {
      bool value2 = await DataLists.importToMemory(Config.database, bloc);
      if (value2) {
        Config.currentDevice = DataLists.instance.listDevices.where((element) => element.deviceKey == Config.authToken).first;
        Config.log.w('Offline data loaded');
        return true;
      } else {
        Config.log.w('Offline data load failed');
        return false;
      }
    }
    ///For automatic data load
    // bool value1 = await Lib.install(bloc);
    // if (value1 && Config.activeStatus == 'Online') {
    //   bool value2 = await DataLists.importToDatabase(Config.database, bloc);
    //   if (value2) {
    //     Config.log.w('Online data loaded');
    //     return true;
    //   } else {
    //     Config.log.w('Online data load failed');
    //     return false;
    //   }
    // } else {
    //   bool value2 = await DataLists.importToMemory(Config.database, bloc);
    //   if (value2) {
    //     Config.log.w('Offline data loaded');
    //     return true;
    //   } else {
    //     Config.log.w('Offline data load failed');
    //     return false;
    //   }
    // }
  }
}
