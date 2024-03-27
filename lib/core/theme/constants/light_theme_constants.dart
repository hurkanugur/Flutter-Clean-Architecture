import 'package:clean_architecture/core/theme/model/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightThemeConstants {
  const LightThemeConstants._();

  // Theme Data
  static const String _fontFamily = 'Poppins';
  static const Color _colorSchemeSeed = Color.fromARGB(255, 9, 54, 91);

  // Color Palette
  static const Color _lightestGreyColor = Color(0xFFF5F5F5);
  static const Color _lightGreyColor = Color.fromARGB(255, 224, 224, 224);
  static const Color _greyColor = Color.fromARGB(255, 169, 169, 169);
  static const Color _darkGreyColor = Color.fromARGB(255, 79, 79, 79);
  static const Color _transparentColor = Colors.transparent;
  static const Color _whiteColor = Colors.white;
  static const Color _greenColor = Colors.green;
  static const Color _amberColor = Color(0xFFFFC107);
  static const Color _redColor = Colors.red;
  static const Color _barrierColor = kCupertinoModalBarrierColor;

  /// Theme data for the light mode.
  static final ThemeData themeData = ThemeData(
    fontFamily: _fontFamily,
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: _colorSchemeSeed,
    extensions: <AppColors>[
      AppColors(
        // General Colors
        scaffoldBackgroundColor: _lightestGreyColor,
        appBarBackgroundColor: _whiteColor,
        navigationBarBackgroundColor: _whiteColor,
        navigationRailBackgroundColor: _whiteColor,
        floatingActionButtonBackgroundColor: _colorSchemeSeed,
        drawerBackgroundColor: _whiteColor,
        dividerColor: _lightGreyColor,
        lottieLoadingBackgroundColor: _barrierColor.withOpacity(0.6),
        menuBarrierBackgroundColor: _barrierColor,
        // Transparent Widget Colors
        transparentWidgetBackgroundColor: _transparentColor,
        transparentWidgetForegroundColor: _darkGreyColor,
        transparentWidgetBorderColor: _greyColor,
        transparentWidgetSelectedBackgroundColor: _transparentColor,
        transparentWidgetSelectedForegroundColor: _colorSchemeSeed,
        transparentWidgetSelectedBorderColor: _colorSchemeSeed,
        transparentWidgetUnselectedBackgroundColor: _transparentColor,
        transparentWidgetUnselectedForegroundColor: _darkGreyColor,
        transparentWidgetUnselectedBorderColor: _greyColor,
        transparentWidgetDisabledBackgroundColor: _transparentColor,
        transparentWidgetDisabledForegroundColor: _greyColor,
        transparentWidgetDisabledBorderColor: _greyColor,
        // Filled Widget Colors
        filledWidgetBackgroundColor: _colorSchemeSeed,
        filledWidgetForegroundColor: _whiteColor,
        filledWidgetBorderColor: _greyColor,
        filledWidgetSelectedBackgroundColor: _colorSchemeSeed,
        filledWidgetSelectedForegroundColor: _whiteColor,
        filledWidgetSelectedBorderColor: _greyColor,
        filledWidgetUnselectedBackgroundColor: _greyColor,
        filledWidgetUnselectedForegroundColor: _whiteColor,
        filledWidgetUnselectedBorderColor: _greyColor,
        filledWidgetDisabledBackgroundColor: _greyColor,
        filledWidgetDisabledForegroundColor: _whiteColor,
        filledWidgetDisabledBorderColor: _greyColor,
        // Alert Colors
        informationColor: _greenColor,
        warningColor: _amberColor,
        errorColor: _redColor,
      ),
    ],
  );
}
