import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastManager{
  static void showToastShort({required String msg}) {
    Fluttertoast.showToast(
        backgroundColor: Colors.black.withOpacity(1),
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 2);
  }
}