import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/view_models/login_model.dart';
import 'package:food_app/pages/login_screen.dart';

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
}
