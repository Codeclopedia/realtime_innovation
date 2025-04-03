import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizing.dart';

class AppThemeData {
  static ThemeData appThemeData = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.swatchColor,
    ).copyWith(
      secondary: AppColors.secondaryhighlightColor,
      surface: AppColors.primaryBackgroundColor,
    ),
    dividerTheme: const DividerThemeData(color: AppColors.dividerColor),
    scaffoldBackgroundColor: AppColors.primaryBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appbarBackgroundColor,
      titleTextStyle: TextStyle(
        color: AppColors.appbarTextColor,
        fontSize: AppSizing.sp(20),
        fontWeight: FontWeight.w500,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.appbarTextColor,
      ),
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: AppColors.hintTextColor),
        prefixIconColor: AppColors.iconPrimaryColor,
        suffixIconColor: AppColors.iconPrimaryColor,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(AppSizing.sp(5))),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizing.sp(10)))),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
          fontSize: AppSizing.sp(16), color: AppColors.primarytextColor),
      bodyMedium: TextStyle(
          fontSize: AppSizing.sp(14), color: AppColors.primarytextColor),
      titleLarge: TextStyle(
          fontSize: AppSizing.sp(22),
          fontWeight: FontWeight.bold,
          color: AppColors.primarytextColor),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.buttonBackgroundColor,
      textTheme: ButtonTextTheme.primary,
    ),
    useMaterial3: true,
  );
}
