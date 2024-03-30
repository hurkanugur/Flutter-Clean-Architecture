import 'package:clean_architecture/core/theme/model/app_colors.dart';
import 'package:flutter/material.dart';

extension ColorExtension on BuildContext {
  /// A getter for [AppColors].
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
