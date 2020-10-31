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
    bool value1 = await Lib.install(bloc);
    if (value1) {
      bool value2 = await DataLists.importToDatabase(Config.database, bloc);
      if (value2) {
        Config.log.w('Online data loaded');
        return true;
      } else {
        Config.log.w('Online data load failed');
        return false;
      }
    } else {
      bool value2 = await DataLists.importToMemory(Config.database, bloc);
      if (value2) {
        Config.log.w('Offline data loaded');
        return true;
      } else {
        Config.log.w('Offline data load failed');
        return false;
      }
    }
  }
}
