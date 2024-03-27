import 'package:clean_architecture/app/presentation/home/view/home_view.dart';
import 'package:clean_architecture/core/router/enum/router_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

extension RouterExtension on BuildContext {
  /// Static instance of [GoRouter] for application-wide routing.
  static final GoRouter goRouter = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: RouterType.home.relativePath,
        pageBuilder: (BuildContext context, GoRouterState state) => CupertinoPage<void>(
          key: state.pageKey,
          child: const HomeView(),
        ),
        routes: const <RouteBase>[],
      ),
    ],
  );

  /// Opens a new page using the GoRouter.
  void openPage({required RouterType screenType}) => GoRouter.of(this).go(screenType.absolutePath);

  /// Closes the current page using the GoRouter.
  void closePage() => GoRouter.of(this).pop();

  /// Retrieves the current location from the router.
  String getCurrentLocation() {
    final RouteMatch lastMatch = goRouter.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch ? lastMatch.matches : goRouter.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
