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
        foregroundColor: MaterialStatePropertyAll(_getForegroundColor(context: context)),
        backgroundColor: MaterialStatePropertyAll(_getBackgroundColor(context: context)),
        shape: MaterialStatePropertyAll(
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
      ),
    );
  }

  /// Get foreground color by [widgetType].
  Color? _getForegroundColor({required BuildContext context}) {
    if (onTap == null) {
      return switch (widgetStyleType) {
        WidgetStyleType.filled => context.appColors.filledWidgetDisabledForegroundColor,
        WidgetStyleType.transparent => switch (widgetType) {
            WidgetType.onTransparentWidget => context.appColors.transparentWidgetDisabledForegroundColor,
            WidgetType.onFilledWidget => context.appColors.filledWidgetDisabledForegroundColor,
            WidgetType.success => context.appColors.transparentWidgetDisabledForegroundColor,
            WidgetType.warning => context.appColors.transparentWidgetDisabledForegroundColor,
            WidgetType.error => context.appColors.transparentWidgetDisabledForegroundColor,
          },
      };
    }

    return switch (widgetStyleType) {
      WidgetStyleType.filled => context.appColors.filledWidgetForegroundColor,
      WidgetStyleType.transparent => switch (widgetType) {
          WidgetType.onTransparentWidget => context.appColors.transparentWidgetForegroundColor,
          WidgetType.onFilledWidget => context.appColors.filledWidgetForegroundColor,
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
          WidgetType.onTransparentWidget => context.appColors.filledWidgetBackgroundColor,
          WidgetType.onFilledWidget => context.appColors.filledWidgetBackgroundColor,
          WidgetType.success => context.appColors.informationColor,
          WidgetType.warning => context.appColors.warningColor,
          WidgetType.error => context.appColors.errorColor,
        },
      WidgetStyleType.transparent => context.appColors.transparentWidgetBackgroundColor,
    };
  }
}
