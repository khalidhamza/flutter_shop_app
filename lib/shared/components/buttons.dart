
import 'package:flutter/material.dart';

import '../constants.dart';

Widget normalBtn({
  required String label,
  required Color backgroundColor,
  VoidCallback? function
})
{

  late Widget functionality;
  if (function == null){
    functionality = const CircularProgressIndicator(color: Colors.white);
  }else{
    functionality = Text(
      label.toUpperCase(),
      style: const TextStyle(
          fontSize: 18,
          color: Colors.white
      ),
    );
  }

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    onPressed: function,
    child: functionality,
  );
}

Widget primaryBtn({required String label, VoidCallback? function})
{
  Color backgroundColor = primaryColor;
  return normalBtn(label: label, backgroundColor: backgroundColor, function:function);
}

Widget secondaryBtn({required String label, VoidCallback? function})
{
  Color backgroundColor = Colors.blue;
  return normalBtn(label: label, backgroundColor: backgroundColor, function:function);
}


