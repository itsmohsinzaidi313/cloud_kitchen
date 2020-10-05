import 'package:flutter/material.dart';

class ShiftModel {
  List<DropdownMenuItem<String>> _shiftList;
  set shiftList(List<DropdownMenuItem<String>> value) => _shiftList = value;
  get shiftList => _shiftList;
  int _layoutType;
  set layoutType(int value) => _layoutType = value;
  int get layoutType => _layoutType;
}
