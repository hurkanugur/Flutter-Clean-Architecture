import 'package:clean_architecture/app/presentation/home/controller/home_view_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewProvider {
  const HomeViewProvider._();

  /// Provider for [HomeViewController].
  static final homeViewControllerProvider = StateNotifierProvider<HomeViewController, HomeViewState>((ref) {
    return HomeViewController();
  });
}
