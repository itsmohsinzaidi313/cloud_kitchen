import 'package:flutter/material.dart';

class ShiftModel {
  List<DropdownMenuItem<String>> _shiftList;
  set shiftList(List<DropdownMenuItem<String>> value) => _shiftList = value;
  get shiftList => _shiftList;
}
