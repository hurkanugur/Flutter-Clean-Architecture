import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/core/widgets/model/advanced_bottom_navigation_bar_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedNavigationBar extends ConsumerWidget {
  final List<AdvancedNavigationBarItemModel> items;
  final int currentIndex;
  final Future<void> Function(int index) onTap;

  const AdvancedNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  /// Creates a copy of this class.
  AdvancedNavigationBar copyWith({
    List<AdvancedNavigationBarItemModel>? items,
    int? currentIndex,
    Future<void> Function(int index)? onTap,
  }) {
    return AdvancedNavigationBar(
      items: items ?? this.items,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: context.appColors.filledWidgetSelectedBackgroundColor,
        backgroundColor: context.appColors.navigationBarBackgroundColor,
        labelTextStyle: WidgetStatePropertyAll(context.appTextStyles.mediumTextWithTransparentBackground),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      child: NavigationBar(
        elevation: AppDimensions.widgetElevation,
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        destinations: _createItemList(context: context),
      ),
    );
  }

  /// Creates list of [BottomNavigationBarItem].
  List<NavigationDestination> _createItemList({required BuildContext context}) {
    return items
        .map<NavigationDestination>(
          (e) => NavigationDestination(
            icon: Icon(e.unselectedIcon, color: context.appColors.transparentWidgetUnselectedForegroundColor),
            selectedIcon: Icon(e.selectedIcon, color: context.appColors.filledWidgetSelectedForegroundColor),
            label: e.title,
            tooltip: e.tooltip,
          ),
        )
        .toList();
  }
}
