import 'package:flutter/material.dart';
import 'package:shop_app/shared/constants.dart';

Widget primaryLoader(){
  return const Center(
      child: CircularProgressIndicator(
          color: primaryColor
      )
    );
}