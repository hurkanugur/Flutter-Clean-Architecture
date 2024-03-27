import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedListTile extends ConsumerWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? title;
  final String? subtitle;
  final Future<void> Function()? onTap;
  final Future<void> Function()? onLongPress;

  const AdvancedListTile({
    super.key,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.onLongPress,
  });

  /// Creates a copy of this class.
  AdvancedListTile copyWith({
    IconData? leadingIcon,
    IconData? trailingIcon,
    String? title,
    String? subtitle,
    Future<void> Function()? onTap,
    Future<void> Function()? onLongPress,
  }) {
    return AdvancedListTile(
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      onTap: onTap ?? this.onTap,
      onLongPress: onLongPress ?? this.onLongPress,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      iconColor: context.appColors.transparentWidgetForegroundColor,
      textColor: context.appColors.transparentWidgetForegroundColor,
      tileColor: context.appColors.transparentWidgetBackgroundColor,
      title: _getTitleWidget(context: context),
      subtitle: _getSubtitleWidget(context: context),
      leading: _getLeadingWidget(context: context),
      trailing: _getTrailingWidget(context: context),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

  /// Creates the title widget.
  Widget? _getTitleWidget({required BuildContext context}) {
    if (title?.isEmpty == true) {
      return null;
    }

    return Text(
      title!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Creates the subtitle widget.
  Widget? _getSubtitleWidget({required BuildContext context}) {
    if (subtitle?.isEmpty == true) {
      return null;
    }

    return Text(
      subtitle!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Creates the leading widget.
  Widget? _getLeadingWidget({required BuildContext context}) {
    if (leadingIcon == null) {
      return null;
    }

    return Icon(
      leadingIcon,
      size: AppDimensions.listTileLeadingIconSize,
    );
  }

  /// Creates the trailing widget.
  Widget? _getTrailingWidget({required BuildContext context}) {
    if (trailingIcon == null) {
      return null;
    }

    return Icon(
      trailingIcon,
      size: AppDimensions.listTileTrailingIconSize,
    );
  }
}
