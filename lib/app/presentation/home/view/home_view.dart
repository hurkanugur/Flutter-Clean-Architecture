import 'package:clean_architecture/app/presentation/settings/widget/settings_drawer.dart';
import 'package:clean_architecture/app/presentation/weather/widget/weather_drawer.dart';
import 'package:clean_architecture/app/presentation/weather_details/widget/weather_details_drawer.dart';
import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/core/localization/extension/localization_extension.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/app/presentation/home/provider/home_view_provider.dart';
import 'package:clean_architecture/app/presentation/settings/view/settings_view.dart';
import 'package:clean_architecture/app/presentation/settings/widget/settings_app_bar.dart';
import 'package:clean_architecture/app/presentation/weather/view/weather_view.dart';
import 'package:clean_architecture/app/presentation/weather/widget/weather_app_bar.dart';
import 'package:clean_architecture/app/presentation/weather/widget/weather_floating_action_button.dart';
import 'package:clean_architecture/app/presentation/weather_details/view/weather_details_view.dart';
import 'package:clean_architecture/app/presentation/weather_details/widget/weather_details_app_bar.dart';
import 'package:clean_architecture/core/widgets/advanced_navigation_bar.dart';
import 'package:clean_architecture/core/widgets/advanced_navigation_rail.dart';
import 'package:clean_architecture/config/app_icons.dart';
import 'package:clean_architecture/core/router/enum/home_page_type.dart';
import 'package:clean_architecture/core/widgets/model/advanced_bottom_navigation_bar_item_model.dart';
import 'package:clean_architecture/core/widgets/model/advanced_navigation_rail_destination_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewState = ref.watch(HomeViewProvider.homeViewControllerProvider);

    return Scaffold(
      key: homeViewState.homePageScaffoldKey,
      appBar: _getAppBar(ref: ref, homePageType: homeViewState.homePageType) as PreferredSizeWidget?,
      drawerEnableOpenDragGesture: true,
      drawer: _getDrawer(ref: ref, homePageType: homeViewState.homePageType),
      onDrawerChanged: (isOpened) => _onDrawerChanged(ref: ref, isOpened: isOpened),
      body: Row(
        children: <Widget>[
          _getNavigationRail(ref: ref, homePageType: homeViewState.homePageType),
          Expanded(
            child: PageView(
              controller: homeViewState.pageController,
              onPageChanged: (index) async => await _onPageChanged(ref: ref, index: index),
              children: const <Widget>[
                WeatherView(),
                WeatherDetailsView(),
                SettingsView(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _createFloatingActionButton(homePageType: homeViewState.homePageType),
      bottomNavigationBar: _getBottomNavigationBar(ref: ref, homePageType: homeViewState.homePageType),
    );
  }

  /// Represents the page change event.
  Future<void> _onPageChanged({required WidgetRef ref, required int index}) async {
    final homeViewController = ref.read(HomeViewProvider.homeViewControllerProvider.notifier);
    final HomePageType? homePageType = HomePageType.getHomePageTypeByIndex(index: index);

    await homeViewController.changePage(homePageType: homePageType);
  }

  /// Represents the start drawer change event.
  Future<void> _onDrawerChanged({required WidgetRef ref, required bool isOpened}) async {}

  /// Creates a [FloatingActionButton].
  Widget? _createFloatingActionButton({required HomePageType homePageType}) {
    return switch (homePageType) {
      HomePageType.weather => const WeatherFloatingActionButton(),
      HomePageType.weatherDetails => null,
      HomePageType.settings => null,
    };
  }

  /// Creates an [AppBar].
  Widget _getAppBar({required WidgetRef ref, required HomePageType homePageType}) {
    return switch (homePageType) {
      HomePageType.weather => const WeatherAppBar(),
      HomePageType.weatherDetails => const WeatherDetailsAppBar(),
      HomePageType.settings => const SettingsAppBar(),
    };
  }

  /// Creates an [Drawer].
  Widget _getDrawer({required WidgetRef ref, required HomePageType homePageType}) {
    return switch (homePageType) {
      HomePageType.weather => const WeatherDrawer(),
      HomePageType.weatherDetails => const WeatherDetailsDrawer(),
      HomePageType.settings => const SettingsDrawer(),
    };
  }

  /// Creates a [AdvancedNavigationBar].
  Widget? _getBottomNavigationBar({required WidgetRef ref, required HomePageType homePageType}) {
    if (MediaQuery.sizeOf(ref.context).shortestSide >= AppDimensions.maxPhoneWidth) {
      return null;
    }

    return AdvancedNavigationBar(
      currentIndex: homePageType.index,
      onTap: (index) async => await _onPageChanged(ref: ref, index: index),
      items: <AdvancedNavigationBarItemModel>[
        AdvancedNavigationBarItemModel(
          unselectedIcon: AppIcons.weatherIcon,
          selectedIcon: AppIcons.weatherIcon,
          title: ref.translateText(textType: TextType.weather),
          tooltip: ref.translateText(textType: TextType.weather),
        ),
        AdvancedNavigationBarItemModel(
          unselectedIcon: AppIcons.weatherDetailsIcon,
          selectedIcon: AppIcons.weatherDetailsIcon,
          title: ref.translateText(textType: TextType.details),
          tooltip: ref.translateText(textType: TextType.details),
        ),
        AdvancedNavigationBarItemModel(
          unselectedIcon: AppIcons.settingsIcon,
          selectedIcon: AppIcons.settingsIcon,
          title: ref.translateText(textType: TextType.settings),
          tooltip: ref.translateText(textType: TextType.settings),
        ),
      ],
    );
  }

  /// Creates a [AdvancedNavigationRail].
  Widget _getNavigationRail({required WidgetRef ref, required HomePageType homePageType}) {
    if (MediaQuery.sizeOf(ref.context).shortestSide < AppDimensions.maxPhoneWidth) {
      return const SizedBox();
    }

    return AdvancedNavigationRail(
      currentIndex: homePageType.index,
      onTap: (index) async => await _onPageChanged(ref: ref, index: index),
      destinations: <AdvancedNavigationRailDestinationModel>[
        AdvancedNavigationRailDestinationModel(
          unselectedIcon: AppIcons.weatherIcon,
          selectedIcon: AppIcons.weatherIcon,
          title: ref.translateText(textType: TextType.weather),
        ),
        AdvancedNavigationRailDestinationModel(
          unselectedIcon: AppIcons.weatherDetailsIcon,
          selectedIcon: AppIcons.weatherDetailsIcon,
          title: ref.translateText(textType: TextType.details),
        ),
        AdvancedNavigationRailDestinationModel(
          unselectedIcon: AppIcons.settingsIcon,
          selectedIcon: AppIcons.settingsIcon,
          title: ref.translateText(textType: TextType.settings),
        ),
      ],
    );
  }
}
