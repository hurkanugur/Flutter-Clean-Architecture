import 'package:clean_architecture/config/app_strings.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/core/widgets/enum/floating_action_button_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedFloatingActionButton extends ConsumerWidget {
  final IconData icon;
  final String? title;
  final Future<void> Function()? onTap;
  final String tooltip;
  final FloatingActionButtonType type;

  const AdvancedFloatingActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.tooltip,
    required this.type,
  });

  /// Creates a copy of this class.
  AdvancedFloatingActionButton copyWith({
    IconData? icon,
    String? title,
    Future<void> Function()? onTap,
    String? tooltip,
    FloatingActionButtonType? type,
  }) {
    return AdvancedFloatingActionButton(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      onTap: onTap ?? this.onTap,
      tooltip: tooltip ?? this.tooltip,
      type: type ?? this.type,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (type) {
      FloatingActionButtonType.small => _getSmallWidget(context: context),
      FloatingActionButtonType.normal => _getNormalWidget(context: context),
      FloatingActionButtonType.large => _getLargeWidget(context: context),
      FloatingActionButtonType.extended => _getExtendedWidget(context: context),
    };
  }

  /// Creates a small floating action button.
  Widget _getSmallWidget({required BuildContext context}) {
    return FloatingActionButton.small(
      backgroundColor: onTap == null ? context.appColors.filledWidgetDisabledBackgroundColor : context.appColors.floatingActionButtonBackgroundColor,
      foregroundColor: onTap == null ? context.appColors.filledWidgetDisabledForegroundColor : context.appColors.filledWidgetForegroundColor,
      tooltip: tooltip,
      onPressed: onTap,
      child: Icon(icon),
    );
  }

  /// Creates a normal floating action button.
  Widget _getNormalWidget({required BuildContext context}) {
    return FloatingActionButton(
      backgroundColor: onTap == null ? context.appColors.filledWidgetDisabledBackgroundColor : context.appColors.floatingActionButtonBackgroundColor,
      foregroundColor: onTap == null ? context.appColors.filledWidgetDisabledForegroundColor : context.appColors.filledWidgetForegroundColor,
      tooltip: tooltip,
      onPressed: onTap,
      child: Icon(icon),
    );
  }

  /// Creates a large floating action button.
  Widget _getLargeWidget({required BuildContext context}) {
    return FloatingActionButton.large(
      backgroundColor: onTap == null ? context.appColors.filledWidgetDisabledBackgroundColor : context.appColors.floatingActionButtonBackgroundColor,
      foregroundColor: onTap == null ? context.appColors.filledWidgetDisabledForegroundColor : context.appColors.filledWidgetForegroundColor,
      tooltip: tooltip,
      onPressed: onTap,
      child: Icon(icon),
    );
  }

  /// Creates a extended floating action button.
  Widget _getExtendedWidget({required BuildContext context}) {
    return FloatingActionButton.extended(
      backgroundColor: onTap == null ? context.appColors.filledWidgetDisabledBackgroundColor : context.appColors.floatingActionButtonBackgroundColor,
      foregroundColor: onTap == null ? context.appColors.filledWidgetDisabledForegroundColor : context.appColors.filledWidgetForegroundColor,
      tooltip: tooltip,
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(
        title?.isEmpty == true ? AppStrings.unknownText : title!,
        style: onTap == null ? context.appTextStyles.mediumDisabledTextWithFilledBackground : context.appTextStyles.mediumTextWithFilledBackground,
      ),
    );
  }
}
