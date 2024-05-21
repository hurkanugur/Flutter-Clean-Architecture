import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/core/widgets/model/advanced_app_bar_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final AdvancedAppBarIconModel? leading;
  final List<AdvancedAppBarIconModel>? actionList;
  final String? title;

  const AdvancedAppBar({
    super.key,
    required this.leading,
    required this.actionList,
    required this.title,
  });

  /// Creates a copy of this class.
  AdvancedAppBar copyWith({
    AdvancedAppBarIconModel? leading,
    List<AdvancedAppBarIconModel>? actionList,
    String? title,
  }) {
    return AdvancedAppBar(
      leading: leading ?? this.leading,
      actionList: actionList ?? this.actionList,
      title: title ?? this.title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: AppDimensions.widgetElevation,
      backgroundColor: context.appColors.appBarBackgroundColor,
      foregroundColor: context.appColors.transparentWidgetForegroundColor,
      leading: _getLeadingWidget(context: context),
      actions: _getActionsWidget(context: context),
      title: _getTitleWidget(context: context),
    );
  }

  /// Creates the title widget.
  Widget? _getTitleWidget({required BuildContext context}) {
    if (title == null || title!.isEmpty) {
      return null;
    }

    return Text(
      title!,
      style: context.appTextStyles.largeBoldTextWithTransparentBackground,
    );
  }

  /// Creates the leading widget.
  Widget? _getLeadingWidget({required BuildContext context}) {
    if (leading == null) {
      return null;
    }

    return IconButton(
      icon: Icon(leading!.icon),
      tooltip: leading!.tooltip,
      onPressed: leading!.onTap,
    );
  }

  /// Creates list of [IconButton].
  List<Widget>? _getActionsWidget({required BuildContext context}) {
    return actionList
        ?.map<IconButton>(
          (e) => IconButton(
            icon: Icon(e.icon),
            tooltip: e.tooltip,
            onPressed: e.onTap,
          ),
        )
        .toList();
  }
}
