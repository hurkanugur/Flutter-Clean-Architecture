import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  // General Colors
  final Color? scaffoldBackgroundColor;
  final Color? appBarBackgroundColor;
  final Color? navigationBarBackgroundColor;
  final Color? navigationRailBackgroundColor;
  final Color? floatingActionButtonBackgroundColor;
  final Color? drawerBackgroundColor;
  final Color? dividerColor;
  final Color? lottieLoadingBackgroundColor;
  final Color? menuBarrierBackgroundColor;
  // Transparent Widget Colors
  final Color? transparentWidgetBackgroundColor;
  final Color? transparentWidgetForegroundColor;
  final Color? transparentWidgetBorderColor;
  final Color? transparentWidgetSelectedBackgroundColor;
  final Color? transparentWidgetSelectedForegroundColor;
  final Color? transparentWidgetSelectedBorderColor;
  final Color? transparentWidgetUnselectedBackgroundColor;
  final Color? transparentWidgetUnselectedForegroundColor;
  final Color? transparentWidgetUnselectedBorderColor;
  final Color? transparentWidgetDisabledBackgroundColor;
  final Color? transparentWidgetDisabledForegroundColor;
  final Color? transparentWidgetDisabledBorderColor;
  // Filled Widget Colors
  final Color? filledWidgetBackgroundColor;
  final Color? filledWidgetForegroundColor;
  final Color? filledWidgetBorderColor;
  final Color? filledWidgetSelectedBackgroundColor;
  final Color? filledWidgetSelectedForegroundColor;
  final Color? filledWidgetSelectedBorderColor;
  final Color? filledWidgetUnselectedBackgroundColor;
  final Color? filledWidgetUnselectedForegroundColor;
  final Color? filledWidgetUnselectedBorderColor;
  final Color? filledWidgetDisabledBackgroundColor;
  final Color? filledWidgetDisabledForegroundColor;
  final Color? filledWidgetDisabledBorderColor;
  // Alert Colors
  final Color? informationColor;
  final Color? warningColor;
  final Color? errorColor;

  const AppColors({
    // General Colors
    required this.scaffoldBackgroundColor,
    required this.appBarBackgroundColor,
    required this.navigationBarBackgroundColor,
    required this.navigationRailBackgroundColor,
    required this.floatingActionButtonBackgroundColor,
    required this.drawerBackgroundColor,
    required this.dividerColor,
    required this.lottieLoadingBackgroundColor,
    required this.menuBarrierBackgroundColor,
    // Transparent Widget Colors
    required this.transparentWidgetBackgroundColor,
    required this.transparentWidgetForegroundColor,
    required this.transparentWidgetBorderColor,
    required this.transparentWidgetSelectedBackgroundColor,
    required this.transparentWidgetSelectedForegroundColor,
    required this.transparentWidgetSelectedBorderColor,
    required this.transparentWidgetUnselectedBackgroundColor,
    required this.transparentWidgetUnselectedForegroundColor,
    required this.transparentWidgetUnselectedBorderColor,
    required this.transparentWidgetDisabledBackgroundColor,
    required this.transparentWidgetDisabledForegroundColor,
    required this.transparentWidgetDisabledBorderColor,
    // Filled Widget Colors
    required this.filledWidgetBackgroundColor,
    required this.filledWidgetForegroundColor,
    required this.filledWidgetBorderColor,
    required this.filledWidgetSelectedBackgroundColor,
    required this.filledWidgetSelectedForegroundColor,
    required this.filledWidgetSelectedBorderColor,
    required this.filledWidgetUnselectedBackgroundColor,
    required this.filledWidgetUnselectedForegroundColor,
    required this.filledWidgetUnselectedBorderColor,
    required this.filledWidgetDisabledBackgroundColor,
    required this.filledWidgetDisabledForegroundColor,
    required this.filledWidgetDisabledBorderColor,
    // Alert Colors
    required this.informationColor,
    required this.warningColor,
    required this.errorColor,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    // General Colors
    Color? scaffoldBackgroundColor,
    Color? appBarBackgroundColor,
    Color? navigationBarBackgroundColor,
    Color? navigationRailBackgroundColor,
    Color? floatingActionButtonBackgroundColor,
    Color? drawerBackgroundColor,
    Color? dividerColor,
    Color? lottieLoadingBackgroundColor,
    Color? menuBarrierBackgroundColor,
    // Transparent Widget Colors
    Color? transparentWidgetBackgroundColor,
    Color? transparentWidgetForegroundColor,
    Color? transparentWidgetBorderColor,
    Color? transparentWidgetSelectedBackgroundColor,
    Color? transparentWidgetSelectedForegroundColor,
    Color? transparentWidgetSelectedBorderColor,
    Color? transparentWidgetUnselectedBackgroundColor,
    Color? transparentWidgetUnselectedForegroundColor,
    Color? transparentWidgetUnselectedBorderColor,
    Color? transparentWidgetDisabledBackgroundColor,
    Color? transparentWidgetDisabledForegroundColor,
    Color? transparentWidgetDisabledBorderColor,
    // Filled Widget Colors
    Color? filledWidgetBackgroundColor,
    Color? filledWidgetForegroundColor,
    Color? filledWidgetBorderColor,
    Color? filledWidgetSelectedBackgroundColor,
    Color? filledWidgetSelectedForegroundColor,
    Color? filledWidgetSelectedBorderColor,
    Color? filledWidgetUnselectedBackgroundColor,
    Color? filledWidgetUnselectedForegroundColor,
    Color? filledWidgetUnselectedBorderColor,
    Color? filledWidgetDisabledBackgroundColor,
    Color? filledWidgetDisabledForegroundColor,
    Color? filledWidgetDisabledBorderColor,
    // Alert Colors
    Color? informationColor,
    Color? warningColor,
    Color? errorColor,
  }) {
    return AppColors(
      // General Colors
      scaffoldBackgroundColor: scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
      appBarBackgroundColor: appBarBackgroundColor ?? this.appBarBackgroundColor,
      navigationBarBackgroundColor: navigationBarBackgroundColor ?? this.navigationBarBackgroundColor,
      navigationRailBackgroundColor: navigationRailBackgroundColor ?? this.navigationRailBackgroundColor,
      floatingActionButtonBackgroundColor: floatingActionButtonBackgroundColor ?? this.floatingActionButtonBackgroundColor,
      drawerBackgroundColor: drawerBackgroundColor ?? this.drawerBackgroundColor,
      dividerColor: dividerColor ?? this.dividerColor,
      lottieLoadingBackgroundColor: lottieLoadingBackgroundColor ?? this.lottieLoadingBackgroundColor,
      menuBarrierBackgroundColor: menuBarrierBackgroundColor ?? this.menuBarrierBackgroundColor,
      // Transparent Widget Colors
      transparentWidgetBackgroundColor: transparentWidgetBackgroundColor ?? this.transparentWidgetBackgroundColor,
      transparentWidgetForegroundColor: transparentWidgetForegroundColor ?? this.transparentWidgetForegroundColor,
      transparentWidgetBorderColor: transparentWidgetBorderColor ?? this.transparentWidgetBorderColor,
      transparentWidgetSelectedBackgroundColor: transparentWidgetSelectedBackgroundColor ?? this.transparentWidgetSelectedBackgroundColor,
      transparentWidgetSelectedForegroundColor: transparentWidgetSelectedForegroundColor ?? this.transparentWidgetSelectedForegroundColor,
      transparentWidgetSelectedBorderColor: transparentWidgetSelectedBorderColor ?? this.transparentWidgetSelectedBorderColor,
      transparentWidgetUnselectedBackgroundColor: transparentWidgetUnselectedBackgroundColor ?? this.transparentWidgetUnselectedBackgroundColor,
      transparentWidgetUnselectedForegroundColor: transparentWidgetUnselectedForegroundColor ?? this.transparentWidgetUnselectedForegroundColor,
      transparentWidgetUnselectedBorderColor: transparentWidgetUnselectedBorderColor ?? this.transparentWidgetUnselectedBorderColor,
      transparentWidgetDisabledBackgroundColor: transparentWidgetDisabledBackgroundColor ?? this.transparentWidgetDisabledBackgroundColor,
      transparentWidgetDisabledForegroundColor: transparentWidgetDisabledForegroundColor ?? this.transparentWidgetDisabledForegroundColor,
      transparentWidgetDisabledBorderColor: transparentWidgetDisabledBorderColor ?? this.transparentWidgetDisabledBorderColor,
      // Filled Widget Colors
      filledWidgetBackgroundColor: filledWidgetBackgroundColor ?? this.filledWidgetBackgroundColor,
      filledWidgetForegroundColor: filledWidgetForegroundColor ?? this.filledWidgetForegroundColor,
      filledWidgetBorderColor: filledWidgetBorderColor ?? this.filledWidgetBorderColor,
      filledWidgetSelectedBackgroundColor: filledWidgetSelectedBackgroundColor ?? this.filledWidgetSelectedBackgroundColor,
      filledWidgetSelectedForegroundColor: filledWidgetSelectedForegroundColor ?? this.filledWidgetSelectedForegroundColor,
      filledWidgetSelectedBorderColor: filledWidgetSelectedBorderColor ?? this.filledWidgetSelectedBorderColor,
      filledWidgetUnselectedBackgroundColor: filledWidgetUnselectedBackgroundColor ?? this.filledWidgetUnselectedBackgroundColor,
      filledWidgetUnselectedForegroundColor: filledWidgetUnselectedForegroundColor ?? this.filledWidgetUnselectedForegroundColor,
      filledWidgetUnselectedBorderColor: filledWidgetUnselectedBorderColor ?? this.filledWidgetUnselectedBorderColor,
      filledWidgetDisabledBackgroundColor: filledWidgetDisabledBackgroundColor ?? this.filledWidgetDisabledBackgroundColor,
      filledWidgetDisabledForegroundColor: filledWidgetDisabledForegroundColor ?? this.filledWidgetDisabledForegroundColor,
      filledWidgetDisabledBorderColor: filledWidgetDisabledBorderColor ?? this.filledWidgetDisabledBorderColor,
      // Alert Colors
      informationColor: informationColor ?? this.informationColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other == null || other is! AppColors) {
      return this;
    }

    return AppColors(
      // General Colors
      scaffoldBackgroundColor: Color.lerp(scaffoldBackgroundColor, other.scaffoldBackgroundColor, t),
      appBarBackgroundColor: Color.lerp(appBarBackgroundColor, other.appBarBackgroundColor, t),
      navigationBarBackgroundColor: Color.lerp(navigationBarBackgroundColor, other.navigationBarBackgroundColor, t),
      navigationRailBackgroundColor: Color.lerp(navigationRailBackgroundColor, other.navigationRailBackgroundColor, t),
      floatingActionButtonBackgroundColor: Color.lerp(floatingActionButtonBackgroundColor, other.floatingActionButtonBackgroundColor, t),
      drawerBackgroundColor: Color.lerp(drawerBackgroundColor, other.drawerBackgroundColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      lottieLoadingBackgroundColor: Color.lerp(lottieLoadingBackgroundColor, other.lottieLoadingBackgroundColor, t),
      menuBarrierBackgroundColor: Color.lerp(menuBarrierBackgroundColor, other.menuBarrierBackgroundColor, t),
      // Transparent Widget Colors
      transparentWidgetBackgroundColor: Color.lerp(transparentWidgetBackgroundColor, other.transparentWidgetBackgroundColor, t),
      transparentWidgetForegroundColor: Color.lerp(transparentWidgetForegroundColor, other.transparentWidgetForegroundColor, t),
      transparentWidgetBorderColor: Color.lerp(transparentWidgetBorderColor, other.transparentWidgetBorderColor, t),
      transparentWidgetSelectedBackgroundColor: Color.lerp(transparentWidgetSelectedBackgroundColor, other.transparentWidgetSelectedBackgroundColor, t),
      transparentWidgetSelectedForegroundColor: Color.lerp(transparentWidgetSelectedForegroundColor, other.transparentWidgetSelectedForegroundColor, t),
      transparentWidgetSelectedBorderColor: Color.lerp(transparentWidgetSelectedBorderColor, other.transparentWidgetSelectedBorderColor, t),
      transparentWidgetUnselectedBackgroundColor: Color.lerp(transparentWidgetUnselectedBackgroundColor, other.transparentWidgetUnselectedBackgroundColor, t),
      transparentWidgetUnselectedForegroundColor: Color.lerp(transparentWidgetUnselectedForegroundColor, other.transparentWidgetUnselectedForegroundColor, t),
      transparentWidgetUnselectedBorderColor: Color.lerp(transparentWidgetUnselectedBorderColor, other.transparentWidgetUnselectedBorderColor, t),
      transparentWidgetDisabledBackgroundColor: Color.lerp(transparentWidgetDisabledBackgroundColor, other.transparentWidgetDisabledBackgroundColor, t),
      transparentWidgetDisabledForegroundColor: Color.lerp(transparentWidgetDisabledForegroundColor, other.transparentWidgetDisabledForegroundColor, t),
      transparentWidgetDisabledBorderColor: Color.lerp(transparentWidgetDisabledBorderColor, other.transparentWidgetDisabledBorderColor, t),
      // Filled Widget Colors
      filledWidgetBackgroundColor: Color.lerp(filledWidgetBackgroundColor, other.filledWidgetBackgroundColor, t),
      filledWidgetForegroundColor: Color.lerp(filledWidgetForegroundColor, other.filledWidgetForegroundColor, t),
      filledWidgetBorderColor: Color.lerp(filledWidgetBorderColor, other.filledWidgetBorderColor, t),
      filledWidgetSelectedBackgroundColor: Color.lerp(filledWidgetSelectedBackgroundColor, other.filledWidgetSelectedBackgroundColor, t),
      filledWidgetSelectedForegroundColor: Color.lerp(filledWidgetSelectedForegroundColor, other.filledWidgetSelectedForegroundColor, t),
      filledWidgetSelectedBorderColor: Color.lerp(filledWidgetSelectedBorderColor, other.filledWidgetSelectedBorderColor, t),
      filledWidgetUnselectedBackgroundColor: Color.lerp(filledWidgetUnselectedBackgroundColor, other.filledWidgetUnselectedBackgroundColor, t),
      filledWidgetUnselectedForegroundColor: Color.lerp(filledWidgetUnselectedForegroundColor, other.filledWidgetUnselectedForegroundColor, t),
      filledWidgetUnselectedBorderColor: Color.lerp(filledWidgetUnselectedBorderColor, other.filledWidgetUnselectedBorderColor, t),
      filledWidgetDisabledBackgroundColor: Color.lerp(filledWidgetDisabledBackgroundColor, other.filledWidgetDisabledBackgroundColor, t),
      filledWidgetDisabledForegroundColor: Color.lerp(filledWidgetDisabledForegroundColor, other.filledWidgetDisabledForegroundColor, t),
      filledWidgetDisabledBorderColor: Color.lerp(filledWidgetDisabledBorderColor, other.filledWidgetDisabledBorderColor, t),
      // Alert Colors
      informationColor: Color.lerp(informationColor, other.informationColor, t),
      warningColor: Color.lerp(warningColor, other.warningColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
    );
  }
}
