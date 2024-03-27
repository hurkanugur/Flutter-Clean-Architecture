import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingState {
  final bool isLoading;

  const LoadingState({
    required this.isLoading,
  });

  /// Creates a copy of this class.
  LoadingState copyWith({bool? isLoading}) {
    return LoadingState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LoadingController extends StateNotifier<LoadingState> {
  LoadingController() : super(const LoadingState(isLoading: false));

  /// Getter for [isLoading].
  bool get isLoading => state.isLoading;

  /// Setter for [isLoading].
  set isLoading(bool isLoading) => state = state.copyWith(isLoading: isLoading);
}
