import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/bloc/dialog_message_event.dart';

class DialogMessageBloc{

  String _message = 'message';
  Widget _widget;

  final _dialogMessageEventController = StreamController<DialogMessageEvent>();
  Sink<DialogMessageEvent> get dialogMessageEventSink =>
      _dialogMessageEventController.sink;

  final _dialogMessageStateController = StreamController<Widget>();
  StreamSink<Widget> get _inMessage =>
      _dialogMessageStateController.sink;
  Stream<Widget> get message => _dialogMessageStateController.stream;

  DialogMessageBloc(){
    _dialogMessageEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(DialogMessageEvent event){
    if( event is UpdateDialogMessageEvent)
      _widget = Text(event.message);
    _inMessage.add(_widget);
  }

  void dispose(){
    _dialogMessageEventController.close();
    _dialogMessageStateController.close();
  }
}