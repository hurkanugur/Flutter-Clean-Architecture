import 'package:clean_architecture/core/theme/model/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DarkThemeConstants {
  const DarkThemeConstants._();

  // Theme Data
  static const String _fontFamily = 'Poppins';
  static const Color _colorSchemeSeed = Color(0xFF353535);

  // Color Palette
  static const Color _dartkestGreyColor = Color(0xFF181818);
  static const Color _darkGreyColor = Color(0xFF252525);
  static const Color _greyColor = Color.fromARGB(255, 72, 72, 72);
  static const Color _lightGreyColor = Color.fromARGB(255, 126, 126, 126);
  static const Color _transparentColor = Colors.transparent;
  static const Color _whiteColor = Colors.white;
  static const Color _greenColor = Colors.teal;
  static const Color _amberColor = Color(0xFFFFC107);
  static const Color _redColor = Colors.red;
  static const Color _barrierColor = kCupertinoModalBarrierColor;

  /// Theme data for the dark mode.
  static final ThemeData themeData = ThemeData(
    fontFamily: _fontFamily,
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: _colorSchemeSeed,
    extensions: <AppColors>[
      AppColors(
        // General Colors
        scaffoldBackgroundColor: _dartkestGreyColor,
        appBarBackgroundColor: _darkGreyColor,
        navigationBarBackgroundColor: _darkGreyColor,
        navigationRailBackgroundColor: _darkGreyColor,
        floatingActionButtonBackgroundColor: _colorSchemeSeed,
        drawerBackgroundColor: _darkGreyColor,
        dividerColor: _greyColor,
        lottieLoadingBackgroundColor: _barrierColor.withOpacity(0.6),
        menuBarrierBackgroundColor: _barrierColor,
        // Transparent Widget Colors
        transparentWidgetBackgroundColor: _transparentColor,
        transparentWidgetForegroundColor: _whiteColor,
        transparentWidgetBorderColor: _greyColor,
        transparentWidgetSelectedBackgroundColor: _transparentColor,
        transparentWidgetSelectedForegroundColor: _colorSchemeSeed,
        transparentWidgetSelectedBorderColor: _colorSchemeSeed,
        transparentWidgetUnselectedBackgroundColor: _transparentColor,
        transparentWidgetUnselectedForegroundColor: _whiteColor,
        transparentWidgetUnselectedBorderColor: _greyColor,
        transparentWidgetDisabledBackgroundColor: _transparentColor,
        transparentWidgetDisabledForegroundColor: _lightGreyColor,
        transparentWidgetDisabledBorderColor: _greyColor,
        // Filled Widget Colors
        filledWidgetBackgroundColor: _colorSchemeSeed,
        filledWidgetForegroundColor: _whiteColor,
        filledWidgetBorderColor: _greyColor,
        filledWidgetSelectedBackgroundColor: _colorSchemeSeed,
        filledWidgetSelectedForegroundColor: _whiteColor,
        filledWidgetSelectedBorderColor: _colorSchemeSeed,
        filledWidgetUnselectedBackgroundColor: _greyColor,
        filledWidgetUnselectedForegroundColor: _lightGreyColor,
        filledWidgetUnselectedBorderColor: _greyColor,
        filledWidgetDisabledBackgroundColor: _greyColor,
        filledWidgetDisabledForegroundColor: _lightGreyColor,
        filledWidgetDisabledBorderColor: _greyColor,
        // Alert Colors
        informationColor: _greenColor,
        warningColor: _amberColor,
        errorColor: _redColor,
      ),
    ],
  );
}
