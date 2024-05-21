import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/core/widgets/enum/widget_status_type.dart';
import 'package:clean_architecture/core/widgets/enum/widget_style_type.dart';
import 'package:clean_architecture/core/widgets/model/advanced_border_model.dart';
import 'package:clean_architecture/core/widgets/model/advanced_icon_button_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedIconTextButton extends ConsumerWidget {
  final WidgetStyleType widgetStyleType;
  final WidgetType widgetType;
  final String title;
  final Future<void> Function()? onTap;
  final AdvancedIconButtonModel? leading;
  final AdvancedIconButtonModel? tailing;
  final AdvancedBorderModel border;

  const AdvancedIconTextButton({
    super.key,
    required this.widgetStyleType,
    required this.widgetType,
    required this.title,
    required this.onTap,
    this.leading,
    this.tailing,
    this.border = const AdvancedBorderModel(),
  });

  /// Creates a copy of this class.
  AdvancedIconTextButton copyWith({
    WidgetStyleType? widgetStyleType,
    WidgetType? widgetType,
    String? title,
    Future<void> Function()? onTap,
    AdvancedIconButtonModel? leading,
    AdvancedIconButtonModel? tailing,
    AdvancedBorderModel? border,
  }) {
    return AdvancedIconTextButton(
      widgetStyleType: widgetStyleType ?? this.widgetStyleType,
      widgetType: widgetType ?? this.widgetType,
      title: title ?? this.title,
      onTap: onTap ?? this.onTap,
      leading: leading ?? this.leading,
      tailing: tailing ?? this.tailing,
      border: border ?? this.border,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppDimensions.widgetHeight,
      width: MediaQuery.sizeOf(context).width,
      child: _createIconTextButton(context: context),
    );
  }

  /// Creates a button.
  Widget _createIconTextButton({required BuildContext context}) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(_getForegroundColor(context: context, onTap: onTap)),
        backgroundColor: WidgetStatePropertyAll(_getBackgroundColor(context: context, onTap: onTap)),
        shape: WidgetStatePropertyAll(
          border.getRoundedRectangleBorder(
            context: context,
            widgetStyleType: widgetStyleType,
            isDisabled: onTap == null,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          _createIconButton(iconButtonModel: leading, context: context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: _getTextStyle(context: context),
              ),
            ),
          ),
          _createIconButton(iconButtonModel: tailing, context: context),
        ],
      ),
    );
  }

  /// Creates the leading and tailing icon buttons.
  Widget _createIconButton({
    required AdvancedIconButtonModel? iconButtonModel,
    required BuildContext context,
  }) {
    if (iconButtonModel == null) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: iconButtonModel.onTap,
      child: Tooltip(
        message: iconButtonModel.tooltip,
        child: Icon(
          iconButtonModel.icon,
          color: _getForegroundColor(context: context, onTap: iconButtonModel.onTap),
        ),
      ),
    );
  }

  /// Get foreground color by [widgetType].
  Color? _getForegroundColor({required BuildContext context, Future<void> Function()? onTap}) {
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
  Color? _getBackgroundColor({required BuildContext context, Future<void> Function()? onTap}) {
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
  TextStyle? _getTextStyle({required BuildContext context}) {
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
