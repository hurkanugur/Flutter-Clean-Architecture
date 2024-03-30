import 'package:clean_architecture/core/animation/constants/animation_constants.dart';
import 'package:clean_architecture/core/router/enum/home_page_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewState {
  final HomePageType homePageType;
  final PageController pageController;
  final GlobalKey<ScaffoldState> homePageScaffoldKey;

  const HomeViewState({
    required this.pageController,
    required this.homePageType,
    required this.homePageScaffoldKey,
  });

  /// Creates a copy of this class.
  HomeViewState copyWith({
    PageController? pageController,
    HomePageType? homePageType,
    bool? isDrawerOpen,
    GlobalKey<ScaffoldState>? homePageScaffoldKey,
  }) {
    return HomeViewState(
      pageController: pageController ?? this.pageController,
      homePageType: homePageType ?? this.homePageType,
      homePageScaffoldKey: homePageScaffoldKey ?? this.homePageScaffoldKey,
    );
  }
}

class HomeViewController extends StateNotifier<HomeViewState> {
  /// Mutex for [changePage].
  bool _changePageMethodMutex = false;

  HomeViewController()
      : super(
          HomeViewState(
            pageController: PageController(initialPage: HomePageType.weather.index),
            homePageType: HomePageType.weather,
            homePageScaffoldKey: GlobalKey<ScaffoldState>(),
          ),
        );

  /// Getter for [homePageType].
  HomePageType get homePageType => state.homePageType;

  /// Getter for [homePageScaffoldKey].
  GlobalKey<ScaffoldState>? get homePageScaffoldKey => state.homePageScaffoldKey;

  /// Checks whether the drawer is open or not.
  bool isDrawerOpen() => homePageScaffoldKey?.currentState?.isDrawerOpen ?? false;

  /// Changes the current page of the home view.
  Future<void> changePage({required HomePageType? homePageType}) async {
    if (_changePageMethodMutex || homePageType == null || (homePageType == state.homePageType)) {
      return;
    }

    _changePageMethodMutex = true;

    state = state.copyWith(homePageType: homePageType);

    if (state.pageController.hasClients) {
      await state.pageController.animateToPage(
        homePageType.index,
        duration: const Duration(milliseconds: AnimationConstants.pageViewAnimationDurationMS),
        curve: AnimationConstants.pageViewAnimationCurve,
      );
    }

    _changePageMethodMutex = false;
  }
}
