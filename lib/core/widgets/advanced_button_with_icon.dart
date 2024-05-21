import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/core/widgets/enum/widget_status_type.dart';
import 'package:clean_architecture/core/widgets/enum/widget_style_type.dart';
import 'package:clean_architecture/core/widgets/model/advanced_border_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedIconButton extends ConsumerWidget {
  final WidgetStyleType widgetStyleType;
  final WidgetType widgetType;
  final IconData icon;
  final String tooltip;
  final Future<void> Function()? onTap;
  final AdvancedBorderModel border;

  const AdvancedIconButton({
    super.key,
    required this.widgetStyleType,
    required this.widgetType,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.border = const AdvancedBorderModel(),
  });

  /// Creates a copy of this class.
  AdvancedIconButton copyWith({
    WidgetStyleType? widgetStyleType,
    WidgetType? widgetType,
    IconData? icon,
    String? tooltip,
    Future<void> Function()? onTap,
    AdvancedBorderModel? border,
  }) {
    return AdvancedIconButton(
      widgetStyleType: widgetStyleType ?? this.widgetStyleType,
      widgetType: widgetType ?? this.widgetType,
      icon: icon ?? this.icon,
      tooltip: tooltip ?? this.tooltip,
      onTap: onTap ?? this.onTap,
      border: border ?? this.border,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppDimensions.widgetHeight,
      width: MediaQuery.sizeOf(context).width,
      child: Tooltip(
        message: tooltip,
        child: _createIconButton(context: context),
      ),
    );
  }

  /// Creates a button.
  Widget _createIconButton({required BuildContext context}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
      tooltip: tooltip,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(_getBackgroundColor(context: context)),
        foregroundColor: WidgetStatePropertyAll(_getForegroundColor(context: context)),
        shape: WidgetStatePropertyAll(
          border.getRoundedRectangleBorder(
            context: context,
            widgetStyleType: widgetStyleType,
            isDisabled: onTap == null,
          ),
        ),
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
}
