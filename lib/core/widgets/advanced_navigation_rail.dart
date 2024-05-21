import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/core/widgets/model/advanced_navigation_rail_destination_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedNavigationRail extends ConsumerWidget {
  final List<AdvancedNavigationRailDestinationModel> destinations;
  final int currentIndex;
  final Future<void> Function(int index) onTap;

  const AdvancedNavigationRail({
    super.key,
    required this.destinations,
    required this.currentIndex,
    required this.onTap,
  });

  /// Creates a copy of this class.
  AdvancedNavigationRail copyWith({
    List<AdvancedNavigationRailDestinationModel>? destinations,
    int? currentIndex,
    Future<void> Function(int index)? onTap,
  }) {
    return AdvancedNavigationRail(
      destinations: destinations ?? this.destinations,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationRailTheme(
      data: NavigationRailThemeData(
        labelType: NavigationRailLabelType.all,
        backgroundColor: context.appColors.navigationRailBackgroundColor,
        indicatorColor: context.appColors.filledWidgetSelectedBackgroundColor,
        selectedIconTheme: IconThemeData(color: context.appColors.filledWidgetSelectedForegroundColor),
        selectedLabelTextStyle: context.appTextStyles.mediumTextWithTransparentBackground,
        unselectedIconTheme: IconThemeData(color: context.appColors.transparentWidgetUnselectedForegroundColor),
        unselectedLabelTextStyle: context.appTextStyles.mediumTextWithTransparentBackground,
      ),
      child: NavigationRail(
        destinations: _createDestinationItemList(context: context),
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
      ),
    );
  }

  /// Creates list of [NavigationRailDestination].
  List<NavigationRailDestination> _createDestinationItemList({required BuildContext context}) {
    return destinations
        .map<NavigationRailDestination>(
          (e) => NavigationRailDestination(
            icon: Icon(e.unselectedIcon),
            selectedIcon: Icon(e.selectedIcon),
            label: Text(e.title),
          ),
        )
        .toList();
  }
}
