import 'package:flutter/material.dart';

import '../constants.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: primaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black87,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
        color: Colors.white
    ),
    iconTheme: IconThemeData(
        color: Colors.white
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 50,
    backgroundColor: Colors.black87,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
  ),
  scaffoldBackgroundColor: Colors.black87,
  // textTheme: Theme.of(context).textTheme.apply(
  //   bodyColor: Colors.white,
  // ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
        color: Colors.black
    ),
    iconTheme: IconThemeData(
        color: Colors.black
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 50,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
  ),
  scaffoldBackgroundColor: Colors.white,
  // textTheme: Theme.of(context).textTheme.apply(
  //   bodyColor: Colors.black,
  // ),
);