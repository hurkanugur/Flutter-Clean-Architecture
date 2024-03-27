import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeState {
  final ThemeMode themeMode;

  const ThemeState({
    required this.themeMode,
  });

  /// Creates a copy of this class.
  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class ThemeController extends StateNotifier<ThemeState> {
  ThemeController() : super(const ThemeState(themeMode: ThemeMode.system));

  /// Getter for [themeMode].
  ThemeMode get themeMode => state.themeMode;

  /// Setter for [themeMode].
  set themeMode(ThemeMode themeMode) => state = state.copyWith(themeMode: themeMode);
}
