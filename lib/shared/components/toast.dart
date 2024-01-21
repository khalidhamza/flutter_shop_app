

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../enums/toast_status.dart';

Future<bool?> showToast({required String message, required ToastStatus status})
{
  late Color background;
  int lengthIos = 5;
  Toast lengthAndroid = Toast.LENGTH_LONG;

  switch (status) {
    case ToastStatus.warning:
      background  = Colors.amberAccent;
      break;
    case ToastStatus.error:
      background  = Colors.red;
      break;
    default:
      background  = Colors.green;
      lengthAndroid = Toast.LENGTH_SHORT;
      lengthIos   = 2;
  }
  return Fluttertoast.showToast(
    msg: message,
    toastLength: lengthAndroid,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: lengthIos,
    backgroundColor: background,
    textColor: Colors.white,
    fontSize: 16.0
  );
}