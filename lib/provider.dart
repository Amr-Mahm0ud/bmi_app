import 'dart:math';

import 'package:flutter/material.dart';

class MyProv extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool isMale = true;
  double result = 18.5;
  int age = 20;

  String get resultPhrase {
    String resultText = '';
    if (result >= 30)
      resultText = 'Obese';
    else if (result >= 25)
      resultText = 'Overweight';
    else if (result >= 18.5)
      resultText = 'Normal';
    else
      resultText = 'Thin';

    return resultText;
  }

  void calculateResult(int weight, double height) {
    result = weight / pow((height / 100), 2);
  }

  void changeGender(bool newVal) {
    isMale = newVal;
    notifyListeners();
  }

  void changeTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  //-------------DARK THEME SETTINGS----
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.teal, accentColor: Colors.blueGrey),
    scaffoldBackgroundColor: Colors.black54,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          fontSize: 70, color: Colors.white70, fontWeight: FontWeight.w900),
    ),
  );

  //-------------light THEME SETTINGS----
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue, accentColor: Colors.lightBlue[200]),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(
          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          fontSize: 70, color: Colors.black87, fontWeight: FontWeight.w900),
    ),
  );
}
