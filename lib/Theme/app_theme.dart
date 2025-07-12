import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primaryColorLight,
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 22, color: AppColors.white),
      labelLarge: TextStyle(
        fontSize: 22,
        color: AppColors.primaryColorLight,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 22,
        color: AppColors.primaryColorLight,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.gray,
      suffixIconColor: AppColors.gray,
      hintStyle: TextStyle(
        fontSize: 16,
        color: AppColors.gray,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.red),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.gray),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.gray),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.red),
        borderRadius: BorderRadius.circular(16),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.gray),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryColorLight,
            foregroundColor: AppColors.white,
            textStyle: TextStyle(color: AppColors.offWhite, fontSize: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            minimumSize: Size(361, 56))),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColorLight,
        shape:
            StadiumBorder(side: BorderSide(color: AppColors.white, width: 6))),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryColorDark,
    primaryColor: AppColors.primaryColorDark,
    textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 22, color: AppColors.white),
        labelLarge: TextStyle(
          fontSize: 22,
          color: AppColors.primaryColorLight,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.offWhite,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 22,
          color: AppColors.primaryColorLight,
        )),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.offWhite,
      suffixIconColor: AppColors.offWhite,
      hintStyle: TextStyle(
        fontSize: 16,
        color: AppColors.offWhite,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.red),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.primaryColorLight),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.primaryColorLight),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.red),
        borderRadius: BorderRadius.circular(16),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.primaryColorLight),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryColorLight,
            foregroundColor: AppColors.white,
            textStyle: TextStyle(color: AppColors.offWhite, fontSize: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            minimumSize: Size(361, 56))),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColorDark,
        shape:
            StadiumBorder(side: BorderSide(color: AppColors.white, width: 6))),
  );
}
