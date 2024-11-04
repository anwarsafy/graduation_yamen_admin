import 'package:flutter/material.dart';

import 'core/utils/utils/constant_colors.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: ConstantColors.lightPrimary,
      hintColor: ConstantColors.lightAccent,
      scaffoldBackgroundColor: ConstantColors.lightBackground,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: ConstantColors.lightTextPrimary,
          fontFamily: 'LamaSans',
        ),
        displayMedium: TextStyle(
          color: ConstantColors.lightTextPrimary,
          fontFamily: 'LamaSans',
        ),
        bodyLarge: TextStyle(
          color: ConstantColors.lightTextPrimary,
          fontFamily: 'LamaSans',
        ),
        bodyMedium: TextStyle(
          color: ConstantColors.lightTextSecondary,
          fontFamily: 'LamaSans',
        ),
      ),
      cardColor: ConstantColors.lightSurface,
      iconTheme: const IconThemeData(color: ConstantColors.lightAccent),
      appBarTheme: AppBarTheme(
        backgroundColor: ConstantColors.lightPrimary,
        iconTheme: const IconThemeData(color: ConstantColors.lightAccent),
        toolbarTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: ConstantColors.lightTextPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'LamaSans',
          ),
        ).bodyMedium,
        titleTextStyle: const TextStyle(
          color: ConstantColors.lightTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'LamaSans',
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: ConstantColors.bgColor,
        textTheme: ButtonTextTheme.primary,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: ConstantColors.lightBackground,
        titleTextStyle: const TextStyle(
          color: ConstantColors.lightTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'LamaSans',
        ),
        contentTextStyle: const TextStyle(
          color: ConstantColors.lightTextSecondary,
          fontSize: 16,
          fontFamily: 'LamaSans',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: ConstantColors.lightBackground,
        textStyle: TextStyle(
          color: ConstantColors.lightTextPrimary,
          fontFamily: 'LamaSans',
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        surface: ConstantColors.lightBackground,
        primary: ConstantColors.lightPrimary,
        secondary: ConstantColors.lightAccent,
        onSurface: ConstantColors.lightTextPrimary,
        onPrimary: ConstantColors.lightTextPrimary,
        onSecondary: ConstantColors.lightTextPrimary,
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: ConstantColors.lightBackground,
        dayStyle: TextStyle(
          color: ConstantColors.lightTextPrimary,
          fontFamily: 'LamaSans',
        ),
        yearStyle: TextStyle(
          color: ConstantColors.lightTextPrimary,
          fontFamily: 'LamaSans',
        ),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      primaryColor: ConstantColors.darkPrimary,
      hintColor: ConstantColors.darkAccent,
      scaffoldBackgroundColor: ConstantColors.bgColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: ConstantColors.darkTextPrimary,
          fontFamily: 'LamaSans',
        ),
        displayMedium: TextStyle(
          color: ConstantColors.darkTextPrimary,
          fontFamily: 'LamaSans',
        ),
        bodyLarge: TextStyle(
          color: ConstantColors.darkTextPrimary,
          fontFamily: 'LamaSans',
        ),
        bodyMedium: TextStyle(
          color: ConstantColors.darkTextSecondary,
          fontFamily: 'LamaSans',
        ),
      ),
      cardColor: ConstantColors.darkSurface,
      iconTheme: const IconThemeData(color: ConstantColors.darkAccent),
      appBarTheme: AppBarTheme(
        backgroundColor: ConstantColors.bgColor,
        toolbarTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: ConstantColors.darkTextPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'LamaSans',
          ),
        ).bodyMedium,
        titleTextStyle: const TextStyle(
          color: ConstantColors.darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'LamaSans',
        ),
        iconTheme: const IconThemeData(color: ConstantColors.darkAccent),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: ConstantColors.bgColor,
        textTheme: ButtonTextTheme.primary,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: ConstantColors.darkBackground,
        titleTextStyle: const TextStyle(
          color: ConstantColors.darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
        contentTextStyle: const TextStyle(
          color: ConstantColors.darkTextSecondary,
          fontSize: 16,
          fontFamily: 'LamaSans',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: ConstantColors.darkBackground,
        textStyle: TextStyle(
          color: ConstantColors.darkTextPrimary,
          fontFamily: 'LamaSans',
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        surface: ConstantColors.bgColor,
        primary: ConstantColors.darkPrimary,
        secondary: ConstantColors.darkAccent,
        onSurface: ConstantColors.darkTextPrimary,
        onPrimary: ConstantColors.darkTextPrimary,
        onSecondary: ConstantColors.darkTextPrimary,
      ),
      datePickerTheme: const DatePickerThemeData(
        headerForegroundColor: Colors.white,
        backgroundColor: ConstantColors.darkBackground,
        dayStyle: TextStyle(
          color: ConstantColors.darkTextPrimary,
          fontFamily: 'LamaSans',
        ),
        yearStyle: TextStyle(
          color: ConstantColors.darkTextPrimary,
          fontFamily: 'LamaSans',
        ),
        headerHelpStyle: TextStyle(
          color: ConstantColors.darkTextPrimary,
          fontFamily: 'LamaSans',
        ), // Add header style
      ),
    );
  }
}
