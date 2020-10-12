import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final MethodChannel ordersChannel =
      MethodChannel("com.devaj.cloudKitchen/orderService");
  final MethodChannel registerChannel =
      MethodChannel("com.devaj.cloudKitchen/registerService");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          RaisedButton(
              child: Text('Ok'),
              onPressed: () {
                if (Platform.isAndroid) {
                  ordersChannel
                      .invokeMethod("start")
                      .then((value) => print(value))
                      .catchError((onError) {
                    log('Error', error: onError);
                  });
                }
              }),
        ],
      ),
    );
  }

  void startServiceInPlatform() async {
    if (Platform.isAndroid) {
      ordersChannel.invokeMethod("start");
      registerChannel.invokeMethod("start");
    }
  }
}
