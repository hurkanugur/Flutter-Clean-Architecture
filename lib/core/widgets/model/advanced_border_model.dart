import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/core/widgets/enum/widget_style_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdvancedBorderModel extends Equatable {
  final bool hasBorder;
  final bool isTopLeftRounded;
  final bool isTopRightRounded;
  final bool isBottomLeftRounded;
  final bool isBottomRightRounded;

  const AdvancedBorderModel({
    this.hasBorder = true,
    this.isTopLeftRounded = true,
    this.isTopRightRounded = true,
    this.isBottomLeftRounded = true,
    this.isBottomRightRounded = true,
  });

  @override
  List<Object?> get props => [hasBorder, isTopLeftRounded, isTopRightRounded, isBottomLeftRounded, isBottomRightRounded];

  /// Creates a copy of this class.
  AdvancedBorderModel copyWith({
    bool? hasBorder,
    bool? isTopLeftRounded,
    bool? isTopRightRounded,
    bool? isBottomLeftRounded,
    bool? isBottomRightRounded,
  }) {
    return AdvancedBorderModel(
      hasBorder: hasBorder ?? this.hasBorder,
      isTopLeftRounded: isTopLeftRounded ?? this.isTopLeftRounded,
      isTopRightRounded: isTopRightRounded ?? this.isTopRightRounded,
      isBottomLeftRounded: isBottomLeftRounded ?? this.isBottomLeftRounded,
      isBottomRightRounded: isBottomRightRounded ?? this.isBottomRightRounded,
    );
  }

  /// Get [RoundedRectangleBorder].
  RoundedRectangleBorder getRoundedRectangleBorder({
    required BuildContext context,
    required WidgetStyleType widgetStyleType,
    bool? isSelected,
    bool? isDisabled,
  }) {
    final Color? borderColor;

    if (isDisabled == true) {
      borderColor = switch (widgetStyleType) {
        WidgetStyleType.filled => context.appColors.filledWidgetDisabledBorderColor,
        WidgetStyleType.transparent => context.appColors.transparentWidgetDisabledBorderColor,
      };
    } else {
      borderColor = switch (widgetStyleType) {
        WidgetStyleType.filled => (isSelected != null && isSelected) ? context.appColors.filledWidgetSelectedBorderColor : context.appColors.filledWidgetBorderColor,
        WidgetStyleType.transparent => (isSelected != null && isSelected) ? context.appColors.transparentWidgetSelectedBorderColor : context.appColors.transparentWidgetBorderColor,
      };
    }

    return RoundedRectangleBorder(
      borderRadius: getBorderRadius(context: context),
      side: (hasBorder && borderColor != null) ? BorderSide(color: borderColor) : BorderSide.none,
    );
  }

  /// Get [BorderRadius].
  BorderRadius getBorderRadius({required BuildContext context}) {
    return BorderRadius.only(
      topLeft: isTopLeftRounded ? Radius.circular(AppDimensions.buttonBorderRadius) : Radius.zero,
      topRight: isTopRightRounded ? Radius.circular(AppDimensions.buttonBorderRadius) : Radius.zero,
      bottomLeft: isBottomLeftRounded ? Radius.circular(AppDimensions.buttonBorderRadius) : Radius.zero,
      bottomRight: isBottomRightRounded ? Radius.circular(AppDimensions.buttonBorderRadius) : Radius.zero,
    );
  }
}
