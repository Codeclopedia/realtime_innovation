import 'package:flutter/material.dart';

class AppSizing {
  final AppSizing _instance = AppSizing._internal();

  static late double _screenWidth;
  static late double _screenHeight;
  static late TextScaler _textScaler;

  AppSizing._internal();

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _textScaler = mediaQuery.textScaler;
  }

  AppSizing get instance => _instance;

  static double w(double percentage) => _screenWidth * (percentage / 100);

  static double h(double percentage) => _screenHeight * (percentage / 100);

  static double sp(double fontSize) => _textScaler.scale(fontSize);
}
