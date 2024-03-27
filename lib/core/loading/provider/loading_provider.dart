import 'package:clean_architecture/core/loading/controller/loading_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingProvider {
  const LoadingProvider._();

  /// Provider for [LoadingController].
  static final loadingControllerProvider = StateNotifierProvider<LoadingController, LoadingState>((ref) {
    return LoadingController();
  });
}
