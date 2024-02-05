import 'package:flutter/material.dart';
import 'package:shoe_store/config/constants/app_color_constant.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme() {
    return ThemeData(
      colorScheme:
          const ColorScheme.light(primary: AppColorConstant.primaryColor),
      fontFamily: 'Montserrat',
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColorConstant.appBarColor,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 156, 54, 47),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      )),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColorConstant.bottomNavColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
