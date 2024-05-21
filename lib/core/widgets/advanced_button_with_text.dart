import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/core/widgets/enum/widget_status_type.dart';
import 'package:clean_architecture/core/widgets/enum/widget_style_type.dart';
import 'package:clean_architecture/core/widgets/model/advanced_border_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedTextButton extends ConsumerWidget {
  final WidgetStyleType widgetStyleType;
  final WidgetType widgetType;
  final String title;
  final Future<void> Function()? onTap;
  final AdvancedBorderModel border;

  const AdvancedTextButton({
    super.key,
    required this.widgetStyleType,
    required this.widgetType,
    required this.title,
    required this.onTap,
    this.border = const AdvancedBorderModel(),
  });

  /// Creates a copy of this class.
  AdvancedTextButton copyWith({
    WidgetStyleType? widgetStyleType,
    WidgetType? widgetType,
    String? title,
    Future<void> Function()? onTap,
    AdvancedBorderModel? border,
  }) {
    return AdvancedTextButton(
      widgetStyleType: widgetStyleType ?? this.widgetStyleType,
      widgetType: widgetType ?? this.widgetType,
      title: title ?? this.title,
      onTap: onTap ?? this.onTap,
      border: border ?? this.border,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppDimensions.widgetHeight,
      width: MediaQuery.sizeOf(context).width,
      child: _createTextButton(context: context),
    );
  }

  /// Creates a button.
  Widget _createTextButton({required BuildContext context}) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(_getForegroundColor(context: context)),
        backgroundColor: WidgetStatePropertyAll(_getBackgroundColor(context: context)),
        shape: WidgetStatePropertyAll(
          border.getRoundedRectangleBorder(
            context: context,
            widgetStyleType: widgetStyleType,
            isDisabled: onTap == null,
          ),
        ),
      ),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: _getTextStyle(context: context, onTap: onTap),
      ),
    );
  }

  /// Get foreground color by [widgetType].
  Color? _getForegroundColor({required BuildContext context}) {
    if (onTap == null) {
      return switch (widgetStyleType) {
        WidgetStyleType.filled => context.appColors.filledWidgetDisabledForegroundColor,
        WidgetStyleType.transparent => switch (widgetType) {
            WidgetType.withTransparentParentWidget => context.appColors.transparentWidgetDisabledForegroundColor,
            WidgetType.withFilledParentWidget => context.appColors.filledWidgetDisabledForegroundColor,
            WidgetType.success => context.appColors.transparentWidgetDisabledForegroundColor,
            WidgetType.warning => context.appColors.transparentWidgetDisabledForegroundColor,
            WidgetType.error => context.appColors.transparentWidgetDisabledForegroundColor,
          },
      };
    }

    return switch (widgetStyleType) {
      WidgetStyleType.filled => context.appColors.filledWidgetForegroundColor,
      WidgetStyleType.transparent => switch (widgetType) {
          WidgetType.withTransparentParentWidget => context.appColors.transparentWidgetForegroundColor,
          WidgetType.withFilledParentWidget => context.appColors.filledWidgetForegroundColor,
          WidgetType.success => context.appColors.informationColor,
          WidgetType.warning => context.appColors.warningColor,
          WidgetType.error => context.appColors.errorColor,
        },
    };
  }

  /// Get background color by [widgetType].
  Color? _getBackgroundColor({required BuildContext context}) {
    if (onTap == null) {
      return switch (widgetStyleType) {
        WidgetStyleType.filled => context.appColors.filledWidgetDisabledBackgroundColor,
        WidgetStyleType.transparent => context.appColors.transparentWidgetDisabledBackgroundColor,
      };
    }

    return switch (widgetStyleType) {
      WidgetStyleType.filled => switch (widgetType) {
          WidgetType.withTransparentParentWidget => context.appColors.filledWidgetBackgroundColor,
          WidgetType.withFilledParentWidget => context.appColors.filledWidgetBackgroundColor,
          WidgetType.success => context.appColors.informationColor,
          WidgetType.warning => context.appColors.warningColor,
          WidgetType.error => context.appColors.errorColor,
        },
      WidgetStyleType.transparent => context.appColors.transparentWidgetBackgroundColor,
    };
  }

  /// Get text style by [widgetType].
  TextStyle? _getTextStyle({required BuildContext context, Future<void> Function()? onTap}) {
    if (onTap == null) {
      return switch (widgetStyleType) {
        WidgetStyleType.filled => context.appTextStyles.mediumDisabledTextWithFilledBackground,
        WidgetStyleType.transparent => switch (widgetType) {
            WidgetType.withTransparentParentWidget => context.appTextStyles.mediumDisabledTextWithTransparentBackground,
            WidgetType.withFilledParentWidget => context.appTextStyles.mediumDisabledTextWithFilledBackground,
            WidgetType.success => context.appTextStyles.mediumDisabledTextWithTransparentBackground,
            WidgetType.warning => context.appTextStyles.mediumDisabledTextWithTransparentBackground,
            WidgetType.error => context.appTextStyles.mediumDisabledTextWithTransparentBackground,
          },
      };
    }

    return switch (widgetStyleType) {
      WidgetStyleType.filled => context.appTextStyles.mediumTextWithFilledBackground,
      WidgetStyleType.transparent => switch (widgetType) {
          WidgetType.withTransparentParentWidget => context.appTextStyles.mediumTextWithTransparentBackground,
          WidgetType.withFilledParentWidget => context.appTextStyles.mediumTextWithFilledBackground,
          WidgetType.success => context.appTextStyles.mediumInfoText,
          WidgetType.warning => context.appTextStyles.mediumWarningText,
          WidgetType.error => context.appTextStyles.mediumErrorText,
        },
    };
  }
}
